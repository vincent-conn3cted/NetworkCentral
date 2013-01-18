package au.com.toyota.nc.webapp.stripes.ownershipEntity;

import java.io.Serializable;

import javax.servlet.http.HttpSession;

import net.sourceforge.stripes.action.Before;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.controller.LifecycleStage;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidateNestedProperties;

import org.apache.log4j.Logger;

import au.com.toyota.nc.common.model.hibernate.Company;
import au.com.toyota.nc.common.model.hibernate.CompanyStructure;
import au.com.toyota.nc.common.model.hibernate.Status;
import au.com.toyota.nc.common.ownerentity.exceptions.StatusChangeException;
import au.com.toyota.nc.webapp.stripes.ext.converters.ABNConverter;
import au.com.toyota.nc.webapp.stripes.ext.converters.ACNConverter;
import au.com.toyota.nc.webapp.stripes.ext.converters.PhoneNumberConverter;

/**
 * User: Deepthi Fernando
 * Date: 17/02/2009
 * Time: 11:18:32 AM
 */
public class ManageCorporateEntityActionBean extends OwnershipEntityActionBean implements Serializable {
    private static final Logger LOG = Logger.getLogger(ManageCorporateEntityActionBean.class.getName());

    public static final String EVENT_DISPLAY_COMPANY = "displayCompany";
    public static final String EVENT_ADD_COMPANY = "addCompany";
    public static final String EVENT_ADD_OWNED_COMPANY = "addOwnedCompany";
    public static final String EVENT_ADD_OWNER_COMPANY = "addOwnerCompany";

    public static final String EVENT_EDIT_COMPANY = "editCompany";
    public static final String EVENT_SAVE_COMPANY = "saveCompany";
    public static final String EVENT_CHANGE_STATUS = "changeStatus";

    public static final String RETURN_TO_MGR_SH_HOLDING_OWNED = "ownedCompany";
    public static final String RETURN_TO_MGR_SH_HOLDING_OWNER = "ownerCompany";

    @ValidateNestedProperties({
        @Validate(field="name", required=true, maxlength = 100, on = {EVENT_SAVE_COMPANY}),
        @Validate(field="companyStructure", required=true, on = {EVENT_SAVE_COMPANY}),
        @Validate(field="acn", maxlength = 11, required=false, converter = ACNConverter.class,  on = {EVENT_SAVE_COMPANY}),
        @Validate(field="abn", maxlength = 14,required=false, converter = ABNConverter.class, on = {EVENT_SAVE_COMPANY}),

        @Validate(field="secretary", required=false, maxlength = 50, on = {EVENT_SAVE_COMPANY}),
        @Validate(field="director", required=false, maxlength = 400, on = {EVENT_SAVE_COMPANY}),
        @Validate(field="note", required=false, maxlength = 500, on = {EVENT_SAVE_COMPANY}),

        @Validate(field="contact.streetAddress.address1", required=false, maxlength = 35, on = {EVENT_SAVE_COMPANY}),
        @Validate(field="contact.streetAddress.suburb", required=false, maxlength = 40, on = {EVENT_SAVE_COMPANY}),
        @Validate(field="contact.streetAddress.address2", required=false, maxlength = 25, on = {EVENT_SAVE_COMPANY}),
        @Validate(field="contact.streetAddress.postCode", required=false, mask = MASK_POSTCODE, on = {EVENT_SAVE_COMPANY}),

        @Validate(field="contact.postalAddress.address1", required=false, maxlength = 35, on = {EVENT_SAVE_COMPANY}),
        @Validate(field="contact.postalAddress.suburb", required=false, maxlength = 40, on = {EVENT_SAVE_COMPANY}),
        @Validate(field="contact.postalAddress.address2", required=false, maxlength = 25, on = {EVENT_SAVE_COMPANY}),
        @Validate(field="contact.postalAddress.postCode", required=false, mask = MASK_POSTCODE, on = {EVENT_SAVE_COMPANY}),

        @Validate(field="contact.email", required=false, maxlength = 50, mask = MASK_EMAIL, on = {EVENT_SAVE_COMPANY}),
        @Validate(field="contact.website", required=false, maxlength = 50, on = {EVENT_SAVE_COMPANY}),

        @Validate(field="contact.phone", maxlength = 12, required=false, converter = PhoneNumberConverter.class, on = {EVENT_SAVE_COMPANY}),
        @Validate(field="contact.fax", maxlength = 12, required=false, converter = PhoneNumberConverter.class, on = {EVENT_SAVE_COMPANY})
//        @Validate(field="multiOwnerFlag", maxlength = 1, required=false, on = {EVENT_SAVE_COMPANY})
    })
    private Company company = new Company();
    private Boolean companyEntityTypeLocked = Boolean.FALSE;

    @HandlesEvent(EVENT_CHANGE_STATUS)
    public Resolution changeStatus() {
        try {
            if (company.getId()!=null)
                company = operatingEntityService.nextStatus(operatingEntityService.getCorporateEntity(getCompanyID()));
        } catch (StatusChangeException e) {
            company = operatingEntityService.getCorporateEntity(getCompanyID());
            addLocalizableValidationError("company.status", e.getErrorCode());
        }

        ForwardResolution forward = new ForwardResolution(OWNERSHIP_JSP_BASE + "/maintainCompany.jsp");
        return forward;
    }

    @HandlesEvent(EVENT_DISPLAY_COMPANY)
    public Resolution displayCompany() {
        ForwardResolution forward = new ForwardResolution(OWNERSHIP_JSP_BASE + "/maintainCompany.jsp");
        return forward;
    }

    @HandlesEvent(EVENT_ADD_OWNED_COMPANY)
    public Resolution addOwnedCompany() {
        company.setCompanyStructure(CompanyStructure.Company);
        // Assign where this request came from to use with the save operation
        setReturnTo(OWNED_COMPANY);
        companyEntityTypeLocked = Boolean.TRUE;
        ForwardResolution forward = new ForwardResolution(OWNERSHIP_JSP_BASE + "/maintainCompany.jsp");
        return forward;
    }

    @HandlesEvent(EVENT_ADD_OWNER_COMPANY)
    public Resolution addOwnerCompany() {
        company.setCompanyStructure(CompanyStructure.Company);
        // Assign where this request came from to use with the save operation
        setReturnTo(OWNER_COMPANY);
        companyEntityTypeLocked = Boolean.TRUE;
        ForwardResolution forward = new ForwardResolution(OWNERSHIP_JSP_BASE + "/maintainCompany.jsp");
        return forward;
    }

    @DefaultHandler
    @HandlesEvent(EVENT_ADD_COMPANY)
    public Resolution addCompany() {
        ForwardResolution forward = new ForwardResolution(OWNERSHIP_JSP_BASE + "/maintainCompany.jsp");
        return forward;
    }

    @HandlesEvent(EVENT_SAVE_COMPANY)
    public Resolution saveCompany() {
        if (operatingEntityService.isNameIsUnique(company)){
            try {
                /*
                 * need to evict the company from the hibernate session if validation was a success. the reason being that it has previously
                 * been marked as READ-ONLY in the loadCompany() method (see that method for reason why). Hibernate then interprets this
                 * object as always been read only. eviciting it is the only way to reset the object so that hibernate will re-save it
                 * on flush
                 */
                dbServices.evictObject(company);
                company = operatingEntityService.saveCorporateEntity(company);
            } catch (StatusChangeException e) {
                addLocalizableValidationError("sharetype.status", e.getErrorCode());
            }
        }else{
            addLocalizableValidationError("company.name", "error.oe.company.duplicateName");
            return new ForwardResolution(ManageCorporateEntityActionBean.class, ManageCorporateEntityActionBean.EVENT_DISPLAY_COMPANY);
        }

        if (getReturnTo()!=null && (getReturnTo().equals(OWNED_COMPANY) || getReturnTo().equals(OWNER_COMPANY))){
            HttpSession session = getHttpSession();
            session.setAttribute(getReturnTo(), company);
            return new ForwardResolution(OWNERSHIP_JSP_BASE + "/maintainCompany.jsp");
        }else{
            RedirectResolution redirectResolution = new RedirectResolution(ManageCorporateEntityActionBean.class, EVENT_DISPLAY_COMPANY).flash(this);
            return redirectResolution;
        }
    }


    @HandlesEvent(EVENT_EDIT_COMPANY)
    public Resolution editCompany() {
        if (getCompany().getId()!=null)
            company = operatingEntityService.getCorporateEntity(getCompany().getId());
        else if (company.getId()!=null)
            company = operatingEntityService.getCorporateEntity(company.getId());

        return new ForwardResolution(ManageCorporateEntityActionBean.class, EVENT_DISPLAY_COMPANY);
    }


    public Boolean getCompanyEntityTypeLocked() {
        return companyEntityTypeLocked;
    }

    public void setCompanyEntityTypeLocked(Boolean companyEntityTypeLocked) {
        this.companyEntityTypeLocked = companyEntityTypeLocked;
    }

    /*
        Create compnay with the the default values
     */
    private Company createDefaultCompany(){
        Company company = new Company();
        company.setStatus(Status.Draft);
        return company;
    }

    /**
     *
     */
    @Before(stages = LifecycleStage.BindingAndValidation)
    public void loadCompany(){
        if (getContext().getEventName().equals(EVENT_SAVE_COMPANY)){
            if (getCompanyID()==null){
                company = createDefaultCompany();
                if (getReturn()!=null && (getReturn().equals(RETURN_TO_MGR_SH_HOLDING_OWNED) || getReturn().equals(RETURN_TO_MGR_SH_HOLDING_OWNER))){
                   company.setCompanyStructure(CompanyStructure.Company);
                }
            }else{
                company = operatingEntityService.getCorporateEntity(getCompanyID());
                /*
                required to set as readonly because future validation could fail. when future validation fails we do NOt want hibernate
                to auto-flush and save the invalid values (same scenario as in ManageDealerLocationActionBean). To make an update, need
                to call save explicitly on this object to re-attach it to the current hibernate session
                 */
                dbServices.setReadOnly(company);
            }
        }
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }
    
    /**
     * Get the actual username from the toyota LDAP using the T/K number or the dealer name.  
     * @return The actual name from e-Dir
     */
    public String getLastMaintainedUserNameFromLDAP() {
    	return getLastMaintainedUserName(company);
    }

}
