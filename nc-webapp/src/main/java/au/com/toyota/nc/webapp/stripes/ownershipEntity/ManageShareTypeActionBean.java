package au.com.toyota.nc.webapp.stripes.ownershipEntity;

import au.com.toyota.nc.common.model.OwnershipEntitySearchRequest;
import au.com.toyota.nc.common.model.OwnershipEntitySearchResponse;
import au.com.toyota.nc.common.model.hibernate.Company;
import au.com.toyota.nc.common.model.hibernate.OwnerEntityType;
import au.com.toyota.nc.common.model.hibernate.Party;
import au.com.toyota.nc.common.model.hibernate.ShareType;
import au.com.toyota.nc.common.model.hibernate.Status;
import au.com.toyota.nc.common.ownerentity.exceptions.StatusChangeException;
import net.sourceforge.stripes.action.Before;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.controller.LifecycleStage;
import net.sourceforge.stripes.validation.LocalizableError;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidateNestedProperties;
import net.sourceforge.stripes.validation.ValidationErrors;
import net.sourceforge.stripes.validation.ValidationMethod;
import org.apache.log4j.Logger;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * User: Deepthi Fernando
 * Date: 17/02/2009
 * Time: 11:25:27 AM
 */
public class ManageShareTypeActionBean extends OwnershipEntityActionBean {
    private static final Logger LOG = Logger.getLogger(ManageShareTypeActionBean.class.getName());

    public static final String EVENT_ADD_SHARETYPE = "addShareType";
    public static final String EVENT_SAVE_SHARETYPES = "saveShareTypes";
    public static final String EVENT_SEARCH_SHARETYPE = "searchShareType";
    public static final String EVENT_DISPLAY_SHARETYPE = "displayShareType";

    @ValidateNestedProperties({
        @Validate(field="shareTypes.shareName", required=true, maxlength = 30, on=EVENT_SAVE_SHARETYPES),
        @Validate(field="shareTypes.shareTotal", required=true, minvalue = 0,maxlength = 12, mask=MASK_NUMERIC_ONLY, on=EVENT_SAVE_SHARETYPES)
    })
    private Company company;

    @ValidateNestedProperties({
        @Validate(field="shareName", required=true, maxlength = 30, on=EVENT_ADD_SHARETYPE),
        @Validate(field="shareTotal", required=true, minvalue = 1,maxlength = 12, mask=MASK_NUMERIC_ONLY ,on=EVENT_ADD_SHARETYPE)
    })
    private ShareType shareType;
    private List<Party> companies;

    @HandlesEvent(EVENT_ADD_SHARETYPE)
    public Resolution addShareType() {
        if (!operatingEntityService.isNameIsUnique(shareType)){
            addLocalizableValidationError("shareType.shareName", "error.oe.sharetype.duplicateName");
            return new ForwardResolution(getClass(), EVENT_DISPLAY_SHARETYPE);
        }
        shareType = operatingEntityService.saveShareType(shareType);
        if (getReturnTo()!=null && getReturnTo().equals(ABSTRACT_SHAREHOLDING)){
            return new RedirectResolution(ManageShareholdingActionBean.class, ManageShareholdingActionBean.EVENT_DISPLAY_SHAREHOLDING);
        }else{
            shareType=null;
            return new ForwardResolution(getClass(), EVENT_DISPLAY_SHARETYPE);
        }
    }

    @HandlesEvent(EVENT_SAVE_SHARETYPES)
    public Resolution saveShareTypes() {
        try {
            if (!operatingEntityService.isNameUniqueWithInTheCollection(company.getShareTypes())){
                addLocalizableValidationError("shareType.shareName", "error.oe.sharetype.duplicateName");
                return new ForwardResolution(OWNERSHIP_JSP_BASE + "/maintainShareType.jsp");
            }

            company = operatingEntityService.saveCorporateEntity(company);
        } catch (StatusChangeException e) {
            addLocalizableValidationError("shareType.shareName", e.getErrorCode());
            return new ForwardResolution(OWNERSHIP_JSP_BASE + "/maintainShareType.jsp");
        }
        if (getReturnTo()!=null && getReturnTo().equals(ABSTRACT_SHAREHOLDING)){
            HttpSession session = getHttpSession();
            session.setAttribute(OWNED_COMPANY, company);
            return new RedirectResolution(ManageShareholdingActionBean.class, ManageShareholdingActionBean.EVENT_DISPLAY_SHAREHOLDING);
        }else{
            return new ForwardResolution(OWNERSHIP_JSP_BASE + "/maintainShareType.jsp");
        }

    }

    @HandlesEvent(EVENT_SEARCH_SHARETYPE)
    public Resolution searchShareTypes() {
        company=null;
        company = operatingEntityService.getCorporateEntity(getCompanyID());
        return new RedirectResolution(ManageShareTypeActionBean.class, ManageShareTypeActionBean.EVENT_DISPLAY_SHARETYPE).flash(this);
//        return new ForwardResolution(OWNERSHIP_JSP_BASE + "/maintainShareType.jsp");
    }

    @DefaultHandler
    @HandlesEvent(EVENT_DISPLAY_SHARETYPE)
    public Resolution displayShareType() {
       return new ForwardResolution(OWNERSHIP_JSP_BASE + "/maintainShareType.jsp");
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    @Before(stages = LifecycleStage.BindingAndValidation)
    public void loadCompanies(){
        if (getContext().getEventName().equals(EVENT_SAVE_SHARETYPES)){
            company = operatingEntityService.getCorporateEntity(getCompanyID());
            dbServices.evictObject(company);
        }

        if (getContext().getEventName().equals(EVENT_ADD_SHARETYPE)){
            shareType = new ShareType();
            shareType.setStatus(Status.Active);
            shareType.setCompany(operatingEntityService.getCorporateEntity(getCompanyID()));
        }

        OwnershipEntitySearchRequest request = new OwnershipEntitySearchRequest();
        request.setType(OwnerEntityType.Company);

        final OwnershipEntitySearchResponse response = operatingEntityService.findOwnershipEntity(request);
        companies = new ArrayList<Party>(response.getDraftParties());
        companies.addAll(response.getActiveParties());
    }

    public List<Party> getCompanies() {
        return companies;
    }

    public ShareType getShareType() {
        return shareType;
    }

    public void setShareType(ShareType shareType) {
        this.shareType = shareType;
    }

    @ValidationMethod(on=EVENT_SAVE_SHARETYPES)
    public void postBindValidation(ValidationErrors errors) {
        Iterator<ShareType> iterable = company.getShareTypes().iterator();

        while (iterable.hasNext()){
            ShareType shareType = iterable.next();
            if (shareType.getShareTotal()==0) {
                if (operatingEntityService.isThereAreAnyActiveOwnershipRecords(shareType)){
                    errors.addGlobalError(new LocalizableError("error.oe.individual.hasActiveShareholding", new String[]{shareType.getShareName()}));
                }
            }
        }

    }

}