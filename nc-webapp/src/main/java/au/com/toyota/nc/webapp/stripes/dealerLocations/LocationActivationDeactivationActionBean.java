package au.com.toyota.nc.webapp.stripes.dealerLocations;

import au.com.toyota.nc.common.AbstractNCException;
import au.com.toyota.nc.common.locations.exceptions.InvalidLocationException;
import au.com.toyota.nc.common.model.LocationChangeStatusResponse;
import au.com.toyota.nc.common.model.hibernate.FranchiseCodeEvent;
import au.com.toyota.nc.common.model.hibernate.Location;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidationErrorHandler;
import net.sourceforge.stripes.validation.ValidationErrors;
import org.apache.log4j.Logger;

import java.text.MessageFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 *
 */
public class LocationActivationDeactivationActionBean extends BaseDealerLocationActionBean implements ValidationErrorHandler{
    private static final Logger LOG = Logger.getLogger(LocationActivationDeactivationActionBean.class.getName());

    private Long locationId;
    private Long locationForPromotionId;
    private Date appointmentDate;
    private Date cessationDate;

    @Validate(maxlength = Location.MAX_CESSATION_REASON)
    private String cessationReason;
    private String lastTabShown;
    private Long franchiseCodeEventId;


    @HandlesEvent(EVENT_ACTIVATE)
    public Resolution activate() throws InvalidLocationException {
        LOG.info(MessageFormat.format("Starting IMMEDIATE activation for location [{0}]", locationId));

        Location location = locationDBService.fetchLocation(locationId);
        location.setAppointmentDate(new Date());

        Resolution resolution = changeLocationStatus(location);
        LOG.info(MessageFormat.format("Finished IMMEDIATE activation for location [{0}]", locationId));

        return resolution;
    }

    @HandlesEvent(EVENT_SCHEDULE_ACTIVATION)
    public Resolution scheduleActivation() throws InvalidLocationException {
        LOG.info(MessageFormat.format("Starting SCHEDULED activation for location  [{0}]", locationId));
        Location location = locationDBService.fetchLocation(locationId);

        // scheduling activation sets the date manually
        location.setAppointmentDate(appointmentDate);

        Resolution resolution = changeLocationStatus(location);
        LOG.info(MessageFormat.format("Finished SCHEDULED activation for location [{0}]", locationId));

        return resolution;
    }

    @HandlesEvent(EVENT_DEACTIVATE)
    public Resolution deactivate() throws InvalidLocationException {
        LOG.info(MessageFormat.format("Starting IMMEDIATE deactivation  for location [{0}]", locationId));

        Location location = locationDBService.fetchLocation(locationId);
        location.setCessationDate(new Date());
        setDeactivationDetails(location);

        Resolution resolution = changeLocationStatus(location);
        LOG.info(MessageFormat.format("Finished IMMEDIATE deactivation for location [{0}]", locationId));
        return resolution;
    }


    @HandlesEvent(EVENT_SCHEDULE_DEACTIVATION)
    public Resolution scheduleDeActivation() throws  InvalidLocationException {
        LOG.info(MessageFormat.format("Starting SCHEDULED deactivation  for location [{0}]", locationId));

        Location location = locationDBService.fetchLocation(locationId);

        // scheduling deactivation sets the date manually
        location.setCessationDate(cessationDate);

        setDeactivationDetails(location);

        Resolution resolution = changeLocationStatus(location);
        LOG.info(MessageFormat.format("Finished SCHEDULED  deactivation for location [{0}]", locationId));
        return resolution;
    }

    private void setDeactivationDetails(Location location) {
        location.setCessationReason(cessationReason);
        if (franchiseCodeEventId != null) {
            FranchiseCodeEvent franchiseCodeEvent = new FranchiseCodeEvent();
            franchiseCodeEvent.setCommonValueId(franchiseCodeEventId);
            location.setFranchiseCodeEvent(franchiseCodeEvent);
        }
    }

    private Resolution changeLocationStatus(Location location) throws InvalidLocationException {
        try {
            LOG.info("Changing location status");
            LocationChangeStatusResponse response;
            if(location.getDeactivationRequiresReplacementPrincipalLocation())
            {
                response = locationTopology.deactivateActivePrincipalLocation(location.getLocationId(), getLocationForPromotionId());
            }
            else
            {
                response = locationTopology.changeLocationStatus(location);
            }
            location = response.getLatestLocation();
            switch (response.getStatus()) {
                case Executed:
                    addExecutedChangeLocationStatusMessage(location);
                    break;
                case Scheduled:
                    addScheduledChangeLocationStatusMessage(location);
                    break;
            }
            return new RedirectResolution(ManageLocationActionBean.class, BaseManageDealerLocationActionBean.EVENT_DISPLAY_TAB)
                    .addParameters(getParametersOnTabSwitch(getLastTabShown()));
        }
        catch (AbstractNCException e)
        {
            e.printStackTrace();
            // Theoretically, we should have save this as global error. Unfortunately, Stripes dont save the errors in the flashscope (which we can understand, since
            // error shouldnt redirect. It should go back to the source page. The hack is to store the errors as global warnings. If we have time we will do this as
            // error that is stored inside flash scope.
            addSimpleGlobalWarning(e.getMessage());
            return new RedirectResolution(ManageLocationActionBean.class, BaseManageDealerLocationActionBean.EVENT_DISPLAY_TAB)
                    .addParameters(getParametersOnTabSwitch(getLastTabShown()));
        }
    }

    protected Map<String, Object> getParametersOnTabSwitch(String lastTabShown) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put(BaseManageDealerLocationActionBean.REQUEST_LAST_TAB_SHOWN, lastTabShown);
        params.put(BaseManageDealerLocationActionBean.REQUEST_READ_ONLY_MODE, false);
        params.put(ManageLocationActionBean.REQUEST_PARAM_LOCATION_ID, locationId);
        return params;
    }


    private void addScheduledChangeLocationStatusMessage(Location location) {
        switch (location.getStatus()) {
            case Draft:
                addScheduledActivationMessage(location.getAppointmentDate());
                break;
            case Active:
                addScheduledDeactivationMessage(location.getCessationDate());
                break;
        }
    }

    private void addExecutedChangeLocationStatusMessage(Location location) {
        switch (location.getStatus()) {
            case Active:
                addExecutedActivationMessage();
                break;
            case Inactive:
                addExecutedDeactivationMessage();
                break;
        }
    }

    protected void addExecutedActivationMessage() {
        addLocalizableGlobalMessage("message.activation.executed");
    }

    protected void addExecutedDeactivationMessage() {
        addLocalizableGlobalMessage("message.deactivation.executed");
    }

    protected void addScheduledActivationMessage(Date date) {
        addLocalizableGlobalMessage("message.activation.scheduled", formatDate(date));
    }

    protected void addScheduledDeactivationMessage(Date date) {
        addLocalizableGlobalMessage("message.deactivation.scheduled", formatDate(date));
    }


    public Long getLocationId() {
        return locationId;
    }

    public void setLocationId(Long locationId) {
        this.locationId = locationId;
    }

    public Date getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(Date appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    public Date getCessationDate() {
        return cessationDate;
    }

    public void setCessationDate(Date cessationDate) {
        this.cessationDate = cessationDate;
    }

    public String getCessationReason() {
        return cessationReason;
    }

    public void setCessationReason(String cessationReason) {
        this.cessationReason = cessationReason;
    }

    public String getLastTabShown() {
        return lastTabShown;
    }

    public void setLastTabShown(String lastTabShown) {
        this.lastTabShown = lastTabShown;
    }

    public Long getFranchiseCodeEventId() {
        return franchiseCodeEventId;
    }

    public void setFranchiseCodeEventId(Long franchiseCodeEventId) {
        this.franchiseCodeEventId = franchiseCodeEventId;
    }

    public Long getLocationForPromotionId()
    {
        return locationForPromotionId;
    }

    public void setLocationForPromotionId(Long locationForPromotionId)
    {
        this.locationForPromotionId = locationForPromotionId;
    }

    private Location getLocation() throws InvalidLocationException
    {
        return locationDBService.fetchLocation(getLocationId());
    }

    public Resolution handleValidationErrors(ValidationErrors errors) throws Exception {
        convertToSimpleGlobalWarning(errors);
        return new RedirectResolution(ManageLocationActionBean.class, BaseManageDealerLocationActionBean.EVENT_DISPLAY_TAB)
                    .addParameters(getParametersOnTabSwitch(getLastTabShown()));
    }
}
