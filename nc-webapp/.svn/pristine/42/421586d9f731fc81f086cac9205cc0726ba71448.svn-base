package au.com.toyota.nc.webapp.stripes.staff.dealerstaff;

import au.com.toyota.nc.common.dealers.exceptions.InvalidDealerException;
import au.com.toyota.nc.common.model.DateRange;
import au.com.toyota.nc.common.model.DealerStaffSearchRequest;
import au.com.toyota.nc.common.model.DealerStaffSearchResponse;
import au.com.toyota.nc.common.model.hibernate.*;
import au.com.toyota.nc.common.security.staff.ManageStaffSecurityContext;
import au.com.toyota.nc.common.staff.SapUsernameModificationHandler;
import au.com.toyota.nc.common.staff.exceptions.AppointmentNotFoundException;
import au.com.toyota.nc.common.staff.exceptions.SaveAppointmentValidationException;
import au.com.toyota.nc.common.utils.NCCollectionUtils;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;
import au.com.toyota.nc.webapp.stripes.ext.converters.PhoneNumberConverter;
import au.com.toyota.nc.webapp.stripes.staff.AppointmentSourceActionType;
import au.com.toyota.nc.webapp.stripes.staff.mydetails.MyDetailsActionBean;
import net.sourceforge.stripes.action.*;
import net.sourceforge.stripes.controller.LifecycleStage;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidateNestedProperties;
import net.sourceforge.stripes.validation.ValidationMethod;
import org.apache.log4j.Logger;
import org.joda.time.DateTime;

import java.util.ArrayList;
import static java.util.Arrays.asList;
import java.util.List;

public class DealerStaffPositionDOBValidationActionBean extends BaseActionBean
{
    private static final Logger LOG = Logger.getLogger(DealerStaffPositionDOBValidationActionBean.class);

    private static final String APPOINTMENTS_JSP_BASE = JSP_BASE + "/staff/appointments";
    private static final String EVENT_CHECK = "check";
    private static final String EVENT_LOAD_DOB_PAGE = "loadDobPage";
    private static final String REQUEST_PARAM_APPOINTMENT_ID = "appointment.appointmentId";

/*
    @SpringBean
    private SapUsernameModificationHandler sapUsernameModificationHandler;

*/
    @SpringBean
    private ManageStaffSecurityContext manageStaffSecurityContext;

    private Appointment appointment;

//    private Long selectedDealerId;

//    private List<Department> appointmentDepartments;

//    private AppointmentSourceActionType sourceActionType;

//    private String oldSapUsername;

//    private Long selectedPositionId;

    @DefaultHandler
    @HandlesEvent(EVENT_LOAD_DOB_PAGE)
    public Resolution loadDobPage(){
        return new ForwardResolution(APPOINTMENTS_JSP_BASE + "/dobInput.jsp");
    }


    @HandlesEvent(EVENT_CHECK)
    public Resolution check()
    {
        DealerStaff dealerStaff = staffServices.getDealerStaff(appointment.getPerson().getPersonId());
        DealerStaffSearchRequest dealerStaffSearchRequest = new DealerStaffSearchRequest();
        dealerStaffSearchRequest.setFirstname(dealerStaff.getFirstname());
        dealerStaffSearchRequest.setSurname(dealerStaff.getSurname());
        dealerStaffSearchRequest.setDob(dealerStaff.getDob());

        DealerStaffSearchResponse dealerStaffSearchResponse = staffServices.findDealerStaff(dealerStaffSearchRequest);

        if (dealerStaffSearchResponse.getStaffByDealers().size() > 1){
            return new ForwardResolution(APPOINTMENTS_JSP_BASE + "/Error.jsp");
        }else{
            return new RedirectResolution(DealerStaffPositionActionBean.class).addParameter(REQUEST_PARAM_APPOINTMENT_ID, appointment.getAppointmentId());
        }
    }

    @Before(stages = LifecycleStage.BindingAndValidation, on = EVENT_LOAD_DOB_PAGE)
    public void ensureAppointmentIsSet()
    {
        final long appointmentId = Long.parseLong(context.getRequest().getParameter(REQUEST_PARAM_APPOINTMENT_ID));
        final Appointment loadedAppointment = appointmentServices.get(appointmentId);
        appointment = new Appointment(loadedAppointment);
        appointment.setAppointmentId(appointmentId);
    }




/*
    @HandlesEvent("addDpGmr")
    public Resolution addDpGmr()
    {
        return new ForwardResolution(APPOINTMENTS_JSP_BASE + "/addDpGmr.jsp");
    }

    @HandlesEvent("showLocationsForDealer")
    public Resolution showLocationsForDealer() throws InvalidDealerException
    {
        locations = getEligibleLocations();
        return new ForwardResolution(APPOINTMENTS_JSP_BASE + "/showLocations.jsp");
    }

    @HandlesEvent("showPrincipalLocationForDealer")
    public Resolution showPrincipalLocationForDealer() throws InvalidDealerException
    {
        locations = asList(dealerDBService.fetchDealer(selectedDealerId).getPrincipalLocation());
        return new ForwardResolution(APPOINTMENTS_JSP_BASE + "/showLocations.jsp");
    }

    @HandlesEvent(EVENT_CREATE)
    public Resolution create()
    {
        Resolution resolution;
        try
        {
            Position position = new Position();
            position.setPositionId(selectedPositionId);
            appointment.setPosition(position);

            appointment = appointmentTopology.create(appointment, appointmentDepartments);
            resolution = redirectToEditStaff();
        }
        catch (SaveAppointmentValidationException e)
        {
            addSimpleGlobalError(e.getMessage());
            resolution = new ForwardResolution(APPOINTMENTS_JSP_BASE + "/addDpGmr.jsp");
        }
        return resolution;
    }

    @HandlesEvent("copy")
    public Resolution copy() throws AppointmentNotFoundException
    {
        final Appointment loadedApppointment = appointmentServices.fetch(appointment.getAppointmentId());
        appointment = copyFields(loadedApppointment);
        selectedDealerId = appointment.getDealer().getDealerId();
        return new ForwardResolution(APPOINTMENTS_JSP_BASE + "/add.jsp");
    }

    @HandlesEvent("discontinue")
    public Resolution discontinue()
    {
        appointmentTopology.discontinue(appointment.getAppointmentId());
        addLocalizableGlobalMessage("message.dealerstaffsearch.appointment.discontinue.success");
        return redirectToEditStaff();
    }

    @HandlesEvent("edit")
    public Resolution edit() throws AppointmentNotFoundException
    {
        appointment = appointmentServices.fetch(appointment.getAppointmentId());
        oldSapUsername = appointment.getSapInfo().getUsername();
        appointmentDepartments = new ArrayList<Department>();

        for (AppointmentDepartment appointmentDepartment : appointment.getDepartments())
        {
            appointmentDepartments.add(appointmentDepartment.getDepartment());
        }

        selectedPositionId = appointment.getPosition().getPositionId();
        return new ForwardResolution(APPOINTMENTS_JSP_BASE + "/edit.jsp");
    }

    @HandlesEvent(EVENT_UPDATE)
    public Resolution update() throws AppointmentNotFoundException, SaveAppointmentValidationException
    {
        if(AppointmentSourceActionType.MY_DETAILS == sourceActionType)
        {
            sapUsernameModificationHandler.handle(oldSapUsername, appointment.getSapInfo().getUsername(), appointment);
        }
        appointment = appointmentTopology.update(appointment, appointmentDepartments, this.selectedPositionId);

        return redirectToEditStaff();
    }

    @Before(stages = LifecycleStage.BindingAndValidation, on = {EVENT_UPDATE})
    public void ensureAppointmentIsSet()
    {
        final long appointmentId = Long.parseLong(context.getRequest().getParameter(REQUEST_PARAM_APPOINTMENT_ID));
        final Appointment loadedAppointment = appointmentServices.get(appointmentId);
        appointment = new Appointment(loadedAppointment);
        appointment.setAppointmentId(appointmentId);
    }

    // yes, one wonders why this is here when a simple required=true might be all thats required on the appointment validation annotation above....
    // but it is required... i suspect its a stripes bug but could easily be something that we are doing incorrectly...
    // anyway, the problem is that, despite PRE-BINDING the appointment record, and DESPITE the start date being present in the
    // loaded staff, and DESPITE the appointment being set in the appointment field, the validation STILL FAILS!!! saying that start date is
    // not present?!
    // the solution is a workaround. tell the validation annotation NOT to validate required fields, and validation required fields
    // explicitly, thereby fully controlling whehter a field is null or not.... hopefully this wont cause anyone to shoot me when it comes to
    // maintenance.... i fully apologize now if something else ive done has caused this wierd situation to occur ;)
    @ValidationMethod(on = {EVENT_CREATE, EVENT_UPDATE})
    public void validateAppointment()
    {
        if(getAppointment() != null)
        {
            ensureThatMandatoryFieldsArePopulated();
            ensureStartDateOnOrBeforeToday();
            validateSapUsername();
        }
    }

    private void ensureThatMandatoryFieldsArePopulated()
    {
        if(getAppointment().getAppointmentDate().getStartDate() == null)
        {
            addLocalizableValidationError("Start Date in role", "validation.required.valueNotPresent");
        }
        if(getAppointment().getLocation() == null || getAppointment().getLocation().getLocationId() == null)
        {
            addLocalizableValidationError("Location", "validation.required.valueNotPresent");
        }
        if(selectedPositionId == null)
        {
            addLocalizableValidationError("Position", "validation.required.valueNotPresent");
        }
        if(getAppointment().getPerson() == null || getAppointment().getPerson().getPersonId() == null)
        {
            addLocalizableValidationError("Person", "validation.required.valueNotPresent");
        }
        if(appointmentDepartments == null || appointmentDepartments.size() == 0)
        {
            addLocalizableValidationError("Department(s)", "validation.required.valueNotPresent");
        }
    }

    private void validateSapUsername()
    {
        if (appointment.getSapInfo().getUsername()!=null && appointment.getSapInfo().getUsername().length() > 12){
            addLocalizableValidationError("appointment.sapInfo.username", "validation.maxlength.valueTooLong", "12");
        }
    }

    private void ensureStartDateOnOrBeforeToday()
    {
        final DateRange dateRange = appointment.getAppointmentDate();
        if (dateRange != null)
        {
            final DateTime startDate = new DateTime(dateRange.getStartDate());
            if (startDate.isAfterNow())
            {
                addLocalizableGlobalError("errors.positions.startDate.afterToday");
            }
        }
    }

    private Resolution redirectToEditStaff()
    {
        final Resolution redirectResolution;
        if(AppointmentSourceActionType.MAINTAIN_STAFF == getSourceActionType())
        {
            redirectResolution = new RedirectResolution(DealerStaffActionBean.class, "edit").
                    addParameter("dealerStaff.personId", appointment.getPerson().getPersonId()).flash(this);
        }
        else if(AppointmentSourceActionType.MY_DETAILS == getSourceActionType())
        {
            redirectResolution = new RedirectResolution(MyDetailsActionBean.class, "view");
        }
        else
        {
            throw new RuntimeException("The source action type is required for redirecting after an update");
        }
        return redirectResolution;
    }

    private Appointment copyFields(Appointment loadedApppointment)
    {
        final Appointment cloned = new Appointment();
        cloned.setLocation(new Location());
        cloned.getLocation().setDealer(new Dealer());
        cloned.setContact(new AppointmentContact());

        cloned.getLocation().setLocationId(loadedApppointment.getLocation().getLocationId());
        cloned.getDealer().setDealerId(loadedApppointment.getDealer().getDealerId());
        cloned.getContact().setPhone(loadedApppointment.getContact().getPhone());
        cloned.getContact().setEmail(loadedApppointment.getContact().getEmail());
        cloned.getContact().setFax(loadedApppointment.getContact().getFax());
        cloned.getContact().setMobile(loadedApppointment.getContact().getMobile());

        cloned.getDripInfo().setEmailOptIn(loadedApppointment.getDripInfo().isEmailOptIn());
        cloned.getDripInfo().setSmsOptIn(loadedApppointment.getDripInfo().isSmsOptIn());
        cloned.getDripInfo().setSmsNumber(loadedApppointment.getDripInfo().getSmsNumber());

        cloned.getSapInfo().setSapUsernameActive(loadedApppointment.getSapInfo().isSapUsernameActive());
        cloned.getSapInfo().setUsername(loadedApppointment.getSapInfo().getUsername());

        return cloned;
    }

    public List<Location> getEligibleLocations()
    {
        return usersDealerService.getEligibleAppointmentLocationsFor(getContext().getUserDetails(), getContext().getUserRole(), selectedDealerId);
    }

    public List<Position> getAllEligiblePositions()
    {
        return positionService.getAllNonDpGmrPositions();
    }

    public boolean getIsSalesPositionSelected()
    {
        boolean isSales = false;
        if(getSelectedPositionId() != null)
        {
            final Position position = positionService.get(getSelectedPositionId());
            isSales = position.isSales();
        }
        return isSales;
    }

    public List<Position> getAllDpGmrPositions()
    {
        return positionService.getAllDpGmrPositions();
    }
*/

    public Appointment getAppointment()
    {
        return appointment;
    }

    public void setAppointment(Appointment appointment)
    {
        this.appointment = appointment;
    }

/*
    public List<Location> getLocations()
    {
        return locations;
    }

    public void setLocations(List<Location> locations)
    {
        this.locations = locations;
    }

*/
//    public Long getSelectedDealerId()
//    {
//        return selectedDealerId;
//    }
//
//    public void setSelectedDealerId(Long selectedDealerId)
//    {
//        this.selectedDealerId = selectedDealerId;
//    }

/*
    public List<Department> getAppointmentDepartments()
    {
        return appointmentDepartments;
    }

    public void setAppointmentDepartments(List<Department> appointmentDepartments)
    {
        this.appointmentDepartments = appointmentDepartments;
    }

*/
/*
    public String getAppointmentDepartmentsValues()
    {
        return NCCollectionUtils.combineAsCommaSeparatedString(getAppointmentDepartments());
    }

    public AppointmentSourceActionType getSourceActionType()
    {
        return sourceActionType;
    }

    public void setSourceActionType(AppointmentSourceActionType sourceActionType)
    {
        this.sourceActionType = sourceActionType;
    }
*/

/*
    public String getOldSapUsername()
    {
        return oldSapUsername;
    }

    public void setOldSapUsername(String oldSapUsername)
    {
        this.oldSapUsername = oldSapUsername;
    }

*/
//    public Long getSelectedPositionId() {
//        return selectedPositionId;
//    }
//
//    public void setSelectedPositionId(Long selectedPositionId) {
//        this.selectedPositionId = selectedPositionId;
//    }
//
//    public boolean getAppointmentIsAssociatedToUsersDealer()
//    {
//        return manageStaffSecurityContext.canUserManageStaff(getAppointment().getPerson(), getContext().getUserDetails(), getContext().getUserRole());
//    }
}