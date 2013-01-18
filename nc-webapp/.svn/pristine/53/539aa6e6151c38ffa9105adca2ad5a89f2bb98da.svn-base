package au.com.toyota.nc.webapp.stripes.dealerchangeover;

import au.com.toyota.nc.common.batch.AppointmentChangeoverOperation;
import au.com.toyota.nc.common.batch.exceptions.DealerChangeoverException;
import au.com.toyota.nc.common.batch.exceptions.InvalidDealerChangeoverException;
import au.com.toyota.nc.common.dealers.exceptions.InvalidDealerException;
import au.com.toyota.nc.common.model.hibernate.Appointment;
import au.com.toyota.nc.common.model.hibernate.AppointmentChangeover;
import au.com.toyota.nc.common.model.hibernate.AppointmentChangeoverAction;
import au.com.toyota.nc.common.model.hibernate.Dealer;
import au.com.toyota.nc.common.model.hibernate.DealerChangeover;
import au.com.toyota.nc.common.model.hibernate.DealerChangeoverSequencePoint;
import au.com.toyota.nc.common.model.hibernate.DealerStaff;
import au.com.toyota.nc.common.model.hibernate.Location;
import au.com.toyota.nc.common.model.hibernate.LocationChangeover;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidateNestedProperties;
import net.sourceforge.stripes.validation.ValidationMethod;
import org.apache.log4j.Logger;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: Alex Ooi
 * Date: 30/03/2009
 * Time: 11:03:14
 */
public class ProcessDealerChangeoverActionBean extends BaseActionBean
{
    private static final Logger LOG = Logger.getLogger(ProcessDealerChangeoverActionBean.class);

    protected static final String DEALER_CHANGEOVER_JSP_BASE = JSP_BASE + "/dealerchangeover";

    @Validate(on = "saveDealer", required = true)
    private Long selectedDealerId;

    private List<Long> selectedLocationIds = new ArrayList<Long>();

    private List<Long> selectedDealerStaffIds = new ArrayList<Long>();

    private List<Long> selectedOldLocationIds = new ArrayList<Long>();

    private List<AppointmentChangeoverAction> selectedChangeoverActions = new ArrayList<AppointmentChangeoverAction>();

    @ValidateNestedProperties(
            @Validate(field = "scheduledDate", required = true, on = "saveAutomation")
    )
    private DealerChangeover dealerChangeover;

    private int totalCountOfDisplayedStaff;

    private Map<DealerChangeoverSequencePoint, String> editDealerRoutingMap;

    private static final String JSPS_AUTOMATION = DEALER_CHANGEOVER_JSP_BASE + "/automation.jsp";
    private static final String JSPS_STAFF = DEALER_CHANGEOVER_JSP_BASE + "/staff.jsp";
    private static final String JSPS_CANCEL = DEALER_CHANGEOVER_JSP_BASE + "/cancel.jsp";
    private static final String JSPS_CANCELLED = DEALER_CHANGEOVER_JSP_BASE + "/cancelled.jsp";

    private static final String JSPS_NEW_DEALERS = DEALER_CHANGEOVER_JSP_BASE + "/newDealers.jsp";

    private static final String JSPS_NEW_LOCATIONS = DEALER_CHANGEOVER_JSP_BASE + "/newLocations.jsp";
    private static final String JSPS_EDIT_DEALERS = DEALER_CHANGEOVER_JSP_BASE + "/editDealers.jsp";
    private static final String JSPS_EDIT_LOCATIONS = DEALER_CHANGEOVER_JSP_BASE + "/editLocations.jsp";
    
    private boolean deleteAndPurge;

    public ProcessDealerChangeoverActionBean()
    {
        editDealerRoutingMap = new HashMap<DealerChangeoverSequencePoint, String>();
        editDealerRoutingMap.put(DealerChangeoverSequencePoint.SelectDealerCompleted, "selectEditDealers");
        editDealerRoutingMap.put(DealerChangeoverSequencePoint.SelectLocationsCompleted, "selectEditLocations");
        editDealerRoutingMap.put(DealerChangeoverSequencePoint.SelectStaffCompleted, "selectEditStaff");
        editDealerRoutingMap.put(DealerChangeoverSequencePoint.SetupAutomationCompleted, "setupAutomation");
    }

    @DefaultHandler
    public Resolution list()
    {
        LOG.info("Request for listing all dealer changeovers");
        return new ForwardResolution(DEALER_CHANGEOVER_JSP_BASE + "/list.jsp");
    }

    public Resolution selectDealers()
    {
        return new ForwardResolution(JSPS_NEW_DEALERS);
    }

    public Resolution saveDealer()
    {
        Resolution resolution;
        try
        {
            Dealer selectedDealer = dealerDBService.fetchDealer(selectedDealerId);
            dealerChangeover = dealerChangeoverTopology.createChangeoverFor(selectedDealer);
            resolution = createRedirectResolution("selectLocations");
        }
        catch (InvalidDealerException e)
        {
            addSimpleGlobalError(e.getMessage());
            resolution = new ForwardResolution(JSPS_NEW_DEALERS);
        }
        return resolution;
    }

    public Resolution selectLocations() throws InvalidDealerChangeoverException
    {
        dealerChangeover = dealerChangeoverTopology.fetch(dealerChangeover.getDealerChangeoverId());
        return new ForwardResolution(JSPS_NEW_LOCATIONS);
    }

    public Resolution saveLocations() throws DealerChangeoverException
    {
        dealerChangeover = dealerChangeoverTopology.createLocationsFor(dealerChangeover.getDealerChangeoverId(),
                getSelectedLocationIds().toArray(new Long[getSelectedLocationIds().size()]));
        return createRedirectResolution("selectStaff");
    }

    public Resolution selectStaff() throws InvalidDealerChangeoverException
    {
        dealerChangeover = dealerChangeoverTopology.fetch(dealerChangeover.getDealerChangeoverId());
        return new ForwardResolution(JSPS_STAFF);
    }

    public Resolution saveStaff()
    {
        final List<AppointmentChangeoverOperation> operations = new ArrayList<AppointmentChangeoverOperation>();
        for (int i = 0; i < selectedLocationIds.size(); i++)
        {
            final AppointmentChangeoverOperation operation = new AppointmentChangeoverOperation(
                    selectedDealerStaffIds.get(i),
                    selectedOldLocationIds.get(i),
                    selectedLocationIds.get(i),
                    selectedChangeoverActions.get(i));
            operations.add(operation);
        }
        dealerChangeoverTopology.assignStaff(dealerChangeover.getDealerChangeoverId(), operations.toArray(new AppointmentChangeoverOperation[0]));
        return createRedirectResolution("setupAutomation");
    }

    public Resolution setupAutomation() throws InvalidDealerChangeoverException
    {
        dealerChangeover = dealerChangeoverTopology.fetch(dealerChangeover.getDealerChangeoverId());
        return new ForwardResolution(JSPS_AUTOMATION);
    }

    public Resolution saveAutomation() throws InvalidDealerChangeoverException
    {
        Resolution resolution;
        try
        {
            dealerChangeover = dealerChangeoverTopology.saveAutomation(dealerChangeover.getDealerChangeoverId(), dealerChangeover.getScheduledDate());
            addLocalizableGlobalMessage("dealerChangeover.create.success");
            resolution = new RedirectResolution(getClass(), "list").flash(this);
        }
        catch (DealerChangeoverException e)
        {
            addSimpleGlobalError(e.getMessage());
            resolution = new ForwardResolution(getClass(), "setupAutomation");
        }
        return resolution;
    }

    public Resolution edit() throws InvalidDealerChangeoverException
    {
        dealerChangeover = dealerChangeoverTopology.fetch(dealerChangeover.getDealerChangeoverId());
        return new ForwardResolution(getClass(), editDealerRoutingMap.get(dealerChangeover.getDealerChangeoverSequencePoint()));
    }

    public Resolution selectEditDealers() throws InvalidDealerChangeoverException
    {
        dealerChangeover = dealerChangeoverTopology.fetch(dealerChangeover.getDealerChangeoverId());
        return new ForwardResolution(JSPS_EDIT_DEALERS);
    }

    public Resolution saveEditDealer() throws InvalidDealerChangeoverException
    {
        dealerChangeover = dealerChangeoverTopology.fetch(dealerChangeover.getDealerChangeoverId());
        return createRedirectResolution("selectEditLocations");
    }

    public Resolution selectEditLocations() throws InvalidDealerChangeoverException
    {
        dealerChangeover = dealerChangeoverTopology.fetch(dealerChangeover.getDealerChangeoverId());
        for (LocationChangeover locationChangeover : dealerChangeover.getLocationChangeovers())
        {
            selectedLocationIds.add(locationChangeover.getOldLocation().getLocationId());
        }
        return new ForwardResolution(JSPS_EDIT_LOCATIONS);
    }

    public Resolution saveEditLocations() throws InvalidDealerChangeoverException
    {
        try
        {
            dealerChangeover = dealerChangeoverTopology.fetch(dealerChangeover.getDealerChangeoverId());
            dealerChangeover = dealerChangeoverTopology.createLocationsFor(dealerChangeover.getDealerChangeoverId(), selectedLocationIds.toArray(new Long[0]));
            return createRedirectResolution("selectEditStaff");
        }
        catch (DealerChangeoverException e)
        {
            addSimpleGlobalError(e.getMessage());
            return new ForwardResolution(JSPS_EDIT_LOCATIONS);
        }
    }

    public Resolution selectEditStaff() throws InvalidDealerChangeoverException
    {
        dealerChangeover = dealerChangeoverTopology.fetch(dealerChangeover.getDealerChangeoverId());
        final List<AppointmentChangeover> uniqueAppointmentsForChangeover = dealerChangeover.getUniqueAppointmentChangeovers();
        final List<AppointmentChangeover> sortedUniqueAppointmentsForChangeover = sortAppointmentsChangeoversByStaffAtLocation(uniqueAppointmentsForChangeover);
        selectedChangeoverActions = Arrays.asList(new AppointmentChangeoverAction[sortedUniqueAppointmentsForChangeover.size()]);
        selectedLocationIds = Arrays.asList(new Long[sortedUniqueAppointmentsForChangeover.size()]);
        for (int i = 0; i < sortedUniqueAppointmentsForChangeover.size(); i++)
        {
            final AppointmentChangeover appointmentChangeover = sortedUniqueAppointmentsForChangeover.get(i);
            selectedChangeoverActions.set(i, appointmentChangeover.getChangeoverAction());
            if (appointmentChangeover.getNewAppointment() != null)
            {
                selectedLocationIds.set(i, appointmentChangeover.getNewAppointment().getLocation().getLocationId());
            }
        }
        return new ForwardResolution(JSPS_STAFF);
    }

    public Resolution cancel()
    {
        return new ForwardResolution(JSPS_CANCEL);
    }
    
    //checks if the "Delete Cloned Data" checkbox is ticked and then either calls cancelAndPurge or cancelAndArchive resolutions.
    public Resolution cancelDealerChangeover() {
    	if (isDeleteAndPurge()) {
    		return cancelAndPurge();
    	}
    	else return cancelAndArchive();
    }

    public Resolution cancelAndPurge()
    {
        LOG.info("Attempting to cancel and purge for [" + dealerChangeover + "]");
        dealerChangeoverTopology.cancelAndPurge(dealerChangeover.getDealerChangeoverId());
        addLocalizableGlobalMessage("dealerChangeover.cancel.message.cancelled.purge");
        setDeleteAndPurge(false);
        return createRedirectResolution("list");
    }

    public Resolution cancelAndArchive()
    {
        LOG.info("Attempting to cancel and archive for [" + dealerChangeover + "]");
        dealerChangeoverTopology.cancelAndArchive(dealerChangeover.getDealerChangeoverId());
        addLocalizableGlobalMessage("dealerChangeover.cancel.message.cancelled.retain");
        setDeleteAndPurge(false);
        return createRedirectResolution("list");
    }
    
    /**
     * Displays the confirmation pop up. 
     */
    @HandlesEvent("showConfirmation")
    public Resolution showConfirmation() throws InvalidDealerChangeoverException {
    	setShowConfirmation(true);
    	return new ForwardResolution(JSPS_AUTOMATION);
    }

    @ValidationMethod(on = "saveStaff")
    public void ensureAllActionsSelected() throws InvalidDealerChangeoverException
    {
        if (totalCountOfDisplayedStaff != selectedChangeoverActions.size())
        {
            addSimpleGlobalError("You have not selected Archive or Transfer for one or more records.  Please make a selection for each record before continuing");
            dealerChangeover = dealerChangeoverTopology.fetch(dealerChangeover.getDealerChangeoverId());
        }
    }

    private Resolution createRedirectResolution(String event)
    {
        return new RedirectResolution(getClass(), event).addParameter("dealerChangeover.dealerChangeoverId", dealerChangeover.getDealerChangeoverId()).flash(this);
    }

    public List<Dealer> getChangeoverEnabledDealers()
    {
        return dealerDBService.getAllChangeoverEnabledDealers();
    }

    public List<DealerChangeover> getDealerChangeovers()
    {
        return dealerChangeoverTopology.getAllSignificantChangeovers();
    }

    public DealerChangeover getDealerChangeover()
    {
        return dealerChangeover;
    }

    public void setDealerChangeover(DealerChangeover dealerChangeover)
    {
        this.dealerChangeover = dealerChangeover;
    }

    public Long getSelectedDealerId()
    {
        return selectedDealerId;
    }

    public void setSelectedDealerId(Long selectedDealerId)
    {
        this.selectedDealerId = selectedDealerId;
    }

    public List<Long> getSelectedLocationIds()
    {
        return selectedLocationIds;
    }

    public void setSelectedLocationIds(List<Long> selectedLocationIds)
    {
        this.selectedLocationIds = selectedLocationIds;
    }

    public List<AppointmentChangeoverAction> getSelectedChangeoverActions()
    {
        return selectedChangeoverActions;
    }

    public void setSelectedChangeoverActions(List<AppointmentChangeoverAction> selectedChangeoverActions)
    {
        this.selectedChangeoverActions = selectedChangeoverActions;
    }

    public List<Long> getSelectedDealerStaffIds()
    {
        return selectedDealerStaffIds;
    }

    public void setSelectedDealerStaffIds(List<Long> selectedDealerStaffIds)
    {
        this.selectedDealerStaffIds = selectedDealerStaffIds;
    }

    public List<Long> getSelectedOldLocationIds()
    {
        return selectedOldLocationIds;
    }

    public void setSelectedOldLocationIds(List<Long> selectedOldLocationIds)
    {
        this.selectedOldLocationIds = selectedOldLocationIds;
    }

    public int getTotalCountOfDisplayedStaff()
    {
        return totalCountOfDisplayedStaff;
    }

    public void setTotalCountOfDisplayedStaff(int totalCountOfDisplayedStaff)
    {
        this.totalCountOfDisplayedStaff = totalCountOfDisplayedStaff;
    }

    public List<Appointment> getEligibleAppointmentsForChangeover()
    {
        final List<Appointment> appointments = dealerChangeoverTopology.getEligibleAppointmentsForChangeover(getDealerChangeover().getDealerChangeoverId());
        Collections.sort(appointments, new Comparator<Appointment>()
        {
            public int compare(Appointment o1, Appointment o2)
            {
                return compareLocationAndStaff(o1, o2);
            }
        });
        return appointments;
    }

    /**
     * appointment changeovers need to be sorted by location and staff, in the same way that getEligibleAppointmentsForChangeover() does,
     * because the re-rending of appointments is controlled by the getEligibleAppointmentsForChangeover() method, and this method is
     * in charge of returning the appointment changeovers for re-rendering. Thus, to ensure taht selected actions and locations for
     * each appointment changeover lines up in the UI, then the appointment Changeovers loaded from the DB need to be sorted in the
     * same way that the control of the rendering is sorted (i.e. by Location first, then by staff).
     */
    private List<AppointmentChangeover> sortAppointmentsChangeoversByStaffAtLocation(List<AppointmentChangeover> appointmentChangeovers)
    {
        final List<AppointmentChangeover> copiedAppointmentChangeovers = new ArrayList<AppointmentChangeover>(appointmentChangeovers);
        Collections.sort(copiedAppointmentChangeovers, new Comparator<AppointmentChangeover>()
        {
            public int compare(AppointmentChangeover o1, AppointmentChangeover o2)
            {
                return compareLocationAndStaff(o1.getOldAppointment(), o2.getOldAppointment());
            }
        });
        return copiedAppointmentChangeovers;
    }

    private int compareLocationAndStaff(Appointment o1, Appointment o2)
    {
        final Location location1 = o1.getLocation();
        final Location location2 = o2.getLocation();
        final DealerStaff dealerStaff1 = o1.getPerson();
        final DealerStaff dealerStaff2 = o2.getPerson();
        final int locationComparison = location1.getLocationId().compareTo(location2.getLocationId());
        final int staffComparison = dealerStaff1.getPersonId().compareTo(dealerStaff2.getPersonId());
        if(locationComparison != 0)
        {
            return locationComparison;
        }
        else
        {
            return staffComparison;
        }
    }

	public boolean isDeleteAndPurge() {
		return deleteAndPurge;
	}

	public void setDeleteAndPurge(boolean deleteAndPurge) {
		this.deleteAndPurge = deleteAndPurge;
	}
}
