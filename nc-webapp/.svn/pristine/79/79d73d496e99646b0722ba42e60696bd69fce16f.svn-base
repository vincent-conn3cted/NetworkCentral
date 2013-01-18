package au.com.toyota.nc.webapp.stripes.ownershipEntity;

import java.text.MessageFormat;
import java.util.Arrays;

import javax.servlet.http.HttpSession;

import net.sourceforge.stripes.action.After;
import net.sourceforge.stripes.action.Before;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.controller.LifecycleStage;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidateNestedProperties;

import org.apache.log4j.Logger;

import au.com.toyota.nc.common.model.hibernate.Individual;
import au.com.toyota.nc.common.model.hibernate.Status;
import au.com.toyota.nc.common.ownerentity.exceptions.StatusChangeException;
import au.com.toyota.nc.webapp.stripes.ext.converters.PhoneNumberConverter;
import au.com.toyota.nc.webapp.stripes.staff.DealerStaffSearchActionBean;

/**
 * User: Deepthi Fernando
 * Date: 17/02/2009
 * Time: 11:25:27 AM
 */
public class ManageIndividualEntityActionBean extends OwnershipEntityActionBean {
    private static final Logger LOG = Logger.getLogger(ManageIndividualEntityActionBean.class.getName());

    public static final String RETURN = "maintainIndividual";
    public static final String EVENT_ADD_INDIVIDUAL = "addIndividual";
    public static final String EVENT_SELECTED_INDIVIDUAL = "selectedIndividual";
    public static final String EVENT_ADD_OWNER_INDIVIDUAL = "addOwnerIndividual";
    public static final String EVENT_SAVE_INDIVIDUAL = "saveIndividual";
    public static final String EVENT_EDIT_INDIVIDUAL = "editIndividual";
    public static final String EVENT_CHANGE_STATUS = "changeStatus";
    public static final String EVENT_LINK_DEALERSTAFF= "linkDealerStaff";
    public static final String EVENT_REMOVE_STAFF_MEMBER = "removeStaffMember";

    private static final String[] EVENTS_FOR_SAVING = new String[]
            {
                    EVENT_REMOVE_STAFF_MEMBER,
                    EVENT_SAVE_INDIVIDUAL
            };

    @ValidateNestedProperties({
        @Validate(field="name", required=true, maxlength = 40, on = {EVENT_SAVE_INDIVIDUAL}),
        @Validate(field="note", required=false, maxlength = 500, on = {EVENT_SAVE_INDIVIDUAL}),

        @Validate(field="contact.streetAddress.address1", required=false, maxlength = 35, on = {EVENT_SAVE_INDIVIDUAL}),
        @Validate(field="contact.streetAddress.suburb", required=false, maxlength = 40, on = {EVENT_SAVE_INDIVIDUAL}),
        @Validate(field="contact.streetAddress.address2", required=false, maxlength = 25, on = {EVENT_SAVE_INDIVIDUAL}),
        @Validate(field="contact.streetAddress.postCode", required=false, mask = MASK_POSTCODE, on = {EVENT_SAVE_INDIVIDUAL}),

        @Validate(field="contact.postalAddress.address1", required=false, maxlength = 35, on = {EVENT_SAVE_INDIVIDUAL}),
        @Validate(field="contact.postalAddress.suburb", required=false, maxlength = 40, on = {EVENT_SAVE_INDIVIDUAL}),
        @Validate(field="contact.postalAddress.address2", required=false, maxlength = 25, on = {EVENT_SAVE_INDIVIDUAL}),
        @Validate(field="contact.postalAddress.postCode", required=false, mask = MASK_POSTCODE, on = {EVENT_SAVE_INDIVIDUAL}),

        @Validate(field="contact.email", required=false, maxlength = 50, mask = MASK_EMAIL, on = {EVENT_SAVE_INDIVIDUAL}),

        @Validate(field="contact.phone", required=false, converter = PhoneNumberConverter.class, on = {EVENT_SAVE_INDIVIDUAL}),
        @Validate(field="contact.fax", required=false, converter = PhoneNumberConverter.class, on = {EVENT_SAVE_INDIVIDUAL})
    })
    private Individual individual;

    @HandlesEvent(EVENT_CHANGE_STATUS)
    public Resolution changeStatus() {
        try {
            if (individual.getId()!=null)
                individual = operatingEntityService.nextStatus(operatingEntityService.getIndividualShareholder(getIndividualID()));
        } catch (StatusChangeException e) {
            addLocalizableValidationError("individual.status", e.getErrorCode());
            individual = operatingEntityService.getIndividualShareholder(getIndividualID());
        }

        ForwardResolution forward = new ForwardResolution(OWNERSHIP_JSP_BASE + "/maintainIndividual.jsp");
        return forward;
    }

    @HandlesEvent(EVENT_REMOVE_STAFF_MEMBER)
    public Resolution removeStaffMember()
    {
        LOG.info(MessageFormat.format("Removing linked staff member from [{0}]", individual));
        individual.setDealerStaff(null);
        individual = operatingEntityService.saveIndividualShareholder(individual);
        Resolution resolution = new RedirectResolution(ManageIndividualEntityActionBean.class, EVENT_EDIT_INDIVIDUAL).
                addParameter("individual.id", individual.getId()).flash(this);
        addSimpleGlobalMessage("The Dealer Staff has been successfully removed from this Individual");
        return resolution;
    }


    @HandlesEvent(EVENT_SELECTED_INDIVIDUAL)
    public Resolution selectedIndividual() {
        return new ForwardResolution(OWNERSHIP_JSP_BASE + "/maintainIndividual.jsp");
    }



    @HandlesEvent(EVENT_ADD_INDIVIDUAL)
    public Resolution addIndividual() {
        return new ForwardResolution(OWNERSHIP_JSP_BASE + "/maintainIndividual.jsp");
    }


    @HandlesEvent(EVENT_ADD_OWNER_INDIVIDUAL)
    public Resolution addOwnerIndividual() {
        // Assign where this request came from to use with the save operation
        setReturnTo(OWNER_INDIVIDUAL);
        ForwardResolution forward = new ForwardResolution(OWNERSHIP_JSP_BASE + "/maintainIndividual.jsp");
        return forward;
    }

    @HandlesEvent(EVENT_LINK_DEALERSTAFF)
    public Resolution linkDealerStaff() {
        getContext().getRequest().getSession(true).setAttribute(INDIVIDUAL, individual);
        getContext().getRequest().getSession(true).setAttribute(RETURN_TO, RETURN);
        return new RedirectResolution(DealerStaffSearchActionBean.class, DealerStaffSearchActionBean.EVENT_DISPLAY_SEARCH_CRITERIA);
    }


    @HandlesEvent(EVENT_SAVE_INDIVIDUAL)
    public Resolution saveIndividual() {
        if (operatingEntityService.isNameIsUnique(individual)){
            individual = operatingEntityService.saveIndividualShareholder(individual);
        }else{
            addLocalizableValidationError("individual.name", "error.oe.individual.duplicateName");
        }

        if (getReturnTo()!=null && getReturnTo().equals(OWNER_INDIVIDUAL)){
            HttpSession session = getHttpSession();
            session.setAttribute(getReturnTo(), individual);
            return new ForwardResolution(ManageShareholdingActionBean.class, ManageShareholdingActionBean.EVENT_DISPLAY_SHAREHOLDING);
        }else{
            ForwardResolution forward = new ForwardResolution(OWNERSHIP_JSP_BASE + "/maintainIndividual.jsp");
            return forward;
/*
            RedirectResolution redirectResolution = new RedirectResolution(ManageIndividualEntityActionBean.class, ManageIndividualEntityActionBean.EVENT_EDIT_INDIVIDUAL);
            redirectResolution.addParameter(INDIVIDUAL, individual.getId());
            return redirectResolution;
*/
        }
    }

    @HandlesEvent(EVENT_EDIT_INDIVIDUAL)
    public Resolution editIndividual() {
        if (getReturnTo()!=null && getReturnTo().equals(RETURN)){
            if (individual.getId()!=null)
                individual = operatingEntityService.getIndividualShareholder(individual.getId());
            individual.setDealerStaff(staffServices.getDealerStaff(getDealerStaffID()));
            individual = operatingEntityService.saveIndividualShareholder(individual);
        }else{
            if (getIndividualID()!=null)
                individual = operatingEntityService.getIndividualShareholder(getIndividualID());
        }

        return new ForwardResolution(OWNERSHIP_JSP_BASE + "/maintainIndividual.jsp");
    }

    /*
        Create compnay with the the default values
     */
    private Individual createDefaultIndividual(){
        Individual individual = new Individual();
        individual.setStatus(Status.Draft);
        return individual;
    }

    /**
     *
     */
    @Before(stages = LifecycleStage.BindingAndValidation)
    public void loadIndividual(){
        if (Arrays.asList(EVENTS_FOR_SAVING).contains(getContext().getEventName())){
            if (getIndividualID()==null){
                individual = createDefaultIndividual();
            }else{
                individual = operatingEntityService.getIndividualShareholder(getIndividualID());
                dbServices.evictObject(individual);
            }
        } else if (getContext().getEventName().equals(EVENT_LINK_DEALERSTAFF) && getContext().getRequest().getSession(true).getAttribute(INDIVIDUAL) ==null){
            individual = createDefaultIndividual();
        }
    }

    @After(stages = LifecycleStage.BindingAndValidation)
    public void afterLoadIndividual(){
//        if (getContext().getEventName().equals(EVENT_LINK_DEALERSTAFF)){
            if (getContext().getRequest().getSession(true).getAttribute(INDIVIDUAL) !=null){
                individual = (Individual)getContext().getRequest().getSession(true).getAttribute(INDIVIDUAL);
                getContext().getRequest().getSession(true).removeAttribute(INDIVIDUAL);
            }
//        }
    }

/*
    @After(stages = LifecycleStage.BindingAndValidation)
    public void afterLoadIndividual(){
        if (getContext().getEventName().equals(EVENT_SAVE_INDIVIDUAL)){
            if (getIndividualID()==null){
                individual = createDefaultIndividual();
            }else{
                individual = operatingEntityService.getIndividualShareholder(getIndividualID());
                dbServices.evictObject(individual);
            }
        }
    }
*/

    public Individual getIndividual() {
        return individual;
    }

    public void setIndividual(Individual individual) {
        this.individual = individual;
    }
    
    /**
     * Get the actual username from the toyota LDAP using the T/K number or the dealer name.  
     * @return The actual name from e-Dir
     */
    public String getLastMaintainedUserNameFromLDAP() {
    	return getLastMaintainedUserName(individual);
    }

}
