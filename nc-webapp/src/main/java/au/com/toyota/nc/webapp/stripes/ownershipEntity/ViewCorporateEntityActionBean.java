package au.com.toyota.nc.webapp.stripes.ownershipEntity;

import net.sourceforge.stripes.action.Before;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.controller.LifecycleStage;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidateNestedProperties;

import org.apache.log4j.Logger;

import au.com.toyota.nc.common.model.hibernate.Company;
import au.com.toyota.nc.common.ownerentity.exceptions.StatusChangeException;

/**
 * User: Deepthi Fernando
 * Date: 7/04/2009
 * Time: 11:18:32 AM
 */
public class ViewCorporateEntityActionBean extends OwnershipEntityActionBean{
    private static final Logger LOG = Logger.getLogger(ViewCorporateEntityActionBean.class.getName());

    public static final String EVENT_VIEW_COMPANY = "viewCompany";
    public static final String EVENT_SAVE_SHAREHOLDING = "saveShareholding";

    @ValidateNestedProperties({
        @Validate(field="shareholders.numShares", required=false, minvalue = 0,maxlength = 12, mask=MASK_NUMERIC_ONLY, on=EVENT_SAVE_SHAREHOLDING),
        @Validate(field="ownedCompanies.numShares", required=false, minvalue = 0,maxlength = 12, mask=MASK_NUMERIC_ONLY, on=EVENT_SAVE_SHAREHOLDING)
    })
    private Company company = new Company();

    @DefaultHandler
    @HandlesEvent(EVENT_VIEW_COMPANY)
    public Resolution viewCompany() {
        company = operatingEntityService.getCorporateEntity(getCompany().getId());
        return new ForwardResolution(OWNERSHIP_JSP_BASE + "/viewCompany.jsp");
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    @HandlesEvent(EVENT_SAVE_SHAREHOLDING)
    public Resolution saveShareholding() {
        try {
            company = operatingEntityService.saveCorporateEntity(getCompany());
        } catch (StatusChangeException e) {
            addLocalizableValidationError("company.status", e.getErrorCode());
        }
        return new ForwardResolution(OWNERSHIP_JSP_BASE + "/viewCompany.jsp");
    }

    /**
     *
     */
    @Before(stages = LifecycleStage.BindingAndValidation)
    public void loadCompany(){
        if (getContext().getEventName().equals(EVENT_SAVE_SHAREHOLDING)){
                company = operatingEntityService.getCorporateEntity(getCompanyID());
        }
    }
    
    /**
     * Get the actual username from the toyota LDAP using the T/K number or the dealer name.  
     * @return The actual name from e-Dir
     */
    public String getLastMaintainedUserNameFromLDAP() {
    	return getLastMaintainedUserName(company);
    }

}