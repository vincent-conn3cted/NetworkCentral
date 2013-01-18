package au.com.toyota.nc.webapp.stripes.dealerLocations;

import au.com.toyota.nc.common.AbstractNCException;
import au.com.toyota.nc.common.dealers.exceptions.InvalidDealerException;
import au.com.toyota.nc.common.model.DealerChangeStatusResponse;
import au.com.toyota.nc.common.model.hibernate.Dealer;
import au.com.toyota.nc.common.model.hibernate.FranchiseCodeEvent;
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
public class DealerActivationDeactivationActionBean extends BaseDealerLocationActionBean implements ValidationErrorHandler{
    private static final Logger LOG = Logger.getLogger(DealerActivationDeactivationActionBean.class.getName());

    private Long dealerId;
    private Date appointmentDate;
    private Date cessationDate;

    @Validate(maxlength = Dealer.GeneralInfo.MAX_CESSATION_REASON)
    private String cessationReason;
    private String lastTabShown;
    private Long franchiseCodeEventId;


    @HandlesEvent(EVENT_ACTIVATE)
    public Resolution activate() throws InvalidDealerException {
        LOG.info(MessageFormat.format("Starting IMMEDIATE activation for dealer [{0}]", dealerId));
        Dealer dealer = dealerDBService.fetchDealer(dealerId);
        dealer.getGeneralInfo().setAppointmentDate(new Date());
        Resolution resolution = changeDealerStatus(dealer);
        LOG.info(MessageFormat.format("Finished IMMEDIATE activation for dealer [{0}]", dealerId));
        return resolution;
    }

    @HandlesEvent(EVENT_SCHEDULE_ACTIVATION)
    public Resolution scheduleActivation() throws InvalidDealerException{
        LOG.info(MessageFormat.format("Starting SCHEDULED activation for dealer [{0}]", dealerId));
        Dealer dealer = dealerDBService.fetchDealer(dealerId);

        // scheduling activation sets the date manually
        dealer.getGeneralInfo().setAppointmentDate(appointmentDate);

        Resolution resolution = changeDealerStatus(dealer);
        LOG.info(MessageFormat.format("Finished SCHEDULED activation for dealer [{0}]", dealerId));
        return resolution;
    }

    @HandlesEvent(EVENT_SCHEDULE_DEACTIVATION)
    public Resolution scheduleDeActivation() throws InvalidDealerException {
        LOG.info(MessageFormat.format("Starting SCHEDULED deactivation  for dealer [{0}]", dealerId));
        Dealer dealer = dealerDBService.fetchDealer(dealerId);

        // scheduling deactivation sets the date manually
        dealer.getGeneralInfo().setCessationDate(cessationDate);

        setDeactivationDetails(dealer);

        Resolution resolution = changeDealerStatus(dealer);
        LOG.info(MessageFormat.format("Finished SCHEDULED  deactivation for dealer [{0}]", dealerId));
        return resolution;
    }

    @HandlesEvent(EVENT_DEACTIVATE)
    public Resolution deactivate() throws InvalidDealerException{                                          
        LOG.info(MessageFormat.format("Starting IMMEDIATE deactivation  for dealer [{0}]", dealerId));
        Dealer dealer = dealerDBService.fetchDealer(dealerId);
        dealer.getGeneralInfo().setCessationDate(new Date());
        setDeactivationDetails(dealer);
        Resolution resolution = changeDealerStatus(dealer);
        LOG.info(MessageFormat.format("Finished IMMEDIATE eactivation for dealer [{0}]", dealerId));
        return resolution;
    }

    private void setDeactivationDetails(Dealer dealer) {
        dealer.getGeneralInfo().setCessationReason(cessationReason);
        if (franchiseCodeEventId != null) {
            FranchiseCodeEvent franchiseCodeEvent = new FranchiseCodeEvent();
            franchiseCodeEvent.setCommonValueId(franchiseCodeEventId);
            dealer.getGeneralInfo().setFranchiseCodeEvent(franchiseCodeEvent);
        }
    }

    private Resolution changeDealerStatus(Dealer dealer) throws InvalidDealerException {
        try {
            DealerChangeStatusResponse response= dealerTopology.changeDealerStatus(dealer);
            dealer = response.getLatestDealer();
            switch (response.getStatus()) {
                case Executed:
                    addExecutedChangeDealerStatusMessage(dealer);
                    break;
                case Scheduled:
                    addScheduledChangeDealerStatusMessage(dealer);
                    break;
            }
            return new RedirectResolution(ManageDealerLocationActionBean.class, BaseManageDealerLocationActionBean.EVENT_DISPLAY_TAB)
                    .addParameters(getParametersOnTabSwitch(getLastTabShown()));
        }
        catch (AbstractNCException e) 
        {
            e.printStackTrace();
            // Theoretically, we should have save this as global error. Unfortunately, Stripes dont save the errors in the flashscope (which we can understand, since
            // error shouldnt redirect. It should go back to the source page. The hack is to store the errors as global warnings. If we have time we will do this as
            // error that is stored inside flash scope.
            addSimpleGlobalWarning(e.getMessage());
            return new RedirectResolution(ManageDealerLocationActionBean.class, BaseManageDealerLocationActionBean.EVENT_DISPLAY_TAB)
                    .addParameters(getParametersOnTabSwitch(getLastTabShown()));
        }
    }

    private void addScheduledChangeDealerStatusMessage(Dealer dealer){
        switch (dealer.getGeneralInfo().getStatus()) {
            case Draft:
                addScheduledActivationMessage(dealer.getGeneralInfo().getAppointmentDate());
                break;
            case Active:
                addScheduledDeactivationMessage(dealer.getGeneralInfo().getCessationDate());
                break;
        }
    }
    private void addExecutedChangeDealerStatusMessage(Dealer dealer){
        switch (dealer.getGeneralInfo().getStatus()) {
            case Active:
                addExecutedActivationMessage();
                break;
            case Inactive:
                addExecutedDeactivationMessage();
                break;
        }
    }
    protected void addScheduledActivationMessage(Date date) {
          addLocalizableGlobalMessage("message.activation.scheduled", formatDate(date));
      }

      protected void addScheduledDeactivationMessage(Date date) {
          addLocalizableGlobalMessage("message.deactivation.scheduled", formatDate(date));
      }
      protected void addExecutedActivationMessage(){
          addLocalizableGlobalMessage("message.activation.executed");
      }
      protected void addExecutedDeactivationMessage(){
          addLocalizableGlobalMessage("message.deactivation.executed");
      }



    protected Map<String, Object> getParametersOnTabSwitch(String lastTabShown) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put(BaseManageDealerLocationActionBean.REQUEST_LAST_TAB_SHOWN, lastTabShown);
        params.put(BaseManageDealerLocationActionBean.REQUEST_READ_ONLY_MODE, false);
        params.put(ManageDealerLocationActionBean.REQUEST_PARAM_DEALER_ID, dealerId);
        return params;
    }


    public Long getDealerId() {
        return dealerId;
    }

    public void setDealerId(Long dealerId) {
        this.dealerId = dealerId;
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

    public Long getFranchiseCodeEventId() {
        return franchiseCodeEventId;
    }

    public void setFranchiseCodeEventId(Long franchiseCodeEventId) {
        this.franchiseCodeEventId = franchiseCodeEventId;
    }

    public String getLastTabShown() {
        return lastTabShown;
    }

    public void setLastTabShown(String lastTabShown) {
        this.lastTabShown = lastTabShown;
    }

    public Resolution handleValidationErrors(ValidationErrors errors) throws Exception {
        convertToSimpleGlobalWarning(errors);
        return new RedirectResolution(ManageDealerLocationActionBean.class, BaseManageDealerLocationActionBean.EVENT_DISPLAY_TAB)
                    .addParameters(getParametersOnTabSwitch(getLastTabShown()));
    }
}
