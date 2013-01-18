package au.com.toyota.nc.webapp.stripes.ownershipEntity;

import au.com.toyota.nc.common.model.hibernate.*;
import net.sourceforge.stripes.action.Before;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.controller.LifecycleStage;
import net.sourceforge.stripes.validation.ValidateNestedProperties;
import net.sourceforge.stripes.validation.Validate;
import org.apache.log4j.Logger;

import javax.servlet.http.HttpSession;

/**
 * User: Deepthi Fernando
 * Date: 24/03/2009
 * Time: 11:25:27 AM
 */
public class ManageShareholdingActionBean extends OwnershipEntityActionBean {
    private static final Logger LOG = Logger.getLogger(ManageShareholdingActionBean.class.getName());

    public static final String EVENT_DISPLAY_SHAREHOLDING = "displayShareholding";
    public static final String EVENT_SAVE_SHAREHOLDING = "saveShareholding";
    public static final String EVENT_SEARCH_COMPANY_OWNED = "searchCompany";
    public static final String EVENT_ADD_COMPANY_OWNED = "addCompany";
    public static final String EVENT_SHARE_TYPE_ADD = "addShareType";

    public static final String EVENT_SEARCH_OWNER_ENTITY = "searchOwnerEntity";
    public static final String EVENT_ADD_COMPANY_OWNER = "addCompanyOwner";
    public static final String EVENT_ADD_INDIVIDUAL_OWNER = "addIndividualOwner";

    @ValidateNestedProperties({
        @Validate(field="numShares", required=true, minvalue = 1, maxlength = 12,mask = MASK_NUMERIC_ONLY, on = {EVENT_SAVE_SHAREHOLDING})
    })
    private AbstractShareholding abstractShareholding;
    private Company ownedCompany;
    private Company ownerCompany;
    private Individual ownerIndividual;
    private Boolean dealerPrincipleDisabled;

    @DefaultHandler
    @HandlesEvent(EVENT_DISPLAY_SHAREHOLDING)
    public Resolution displayShareType() {
        assignFromSession();
        return new ForwardResolution(OWNERSHIP_JSP_BASE + "/maintainShareholding.jsp");
    }

    @HandlesEvent(EVENT_ADD_INDIVIDUAL_OWNER)
    public Resolution addIndividualOwner() {
        return new ForwardResolution(ManageIndividualEntityActionBean.class, ManageIndividualEntityActionBean.EVENT_ADD_OWNER_INDIVIDUAL);
    }

    @HandlesEvent(EVENT_ADD_COMPANY_OWNER)
    public Resolution addCompanyOwner() {
        ForwardResolution resolution = new ForwardResolution(ManageCorporateEntityActionBean.class, ManageCorporateEntityActionBean.EVENT_ADD_OWNER_COMPANY);
        return resolution;
    }

    @HandlesEvent(EVENT_SEARCH_OWNER_ENTITY)
    public Resolution searchOwnerEntity() {
        return new ForwardResolution(OwnershipEntitySearchActionBean.class, OwnershipEntitySearchActionBean.EVENT_SEARCH_OWNER_ENTITY);
    }

    @HandlesEvent(EVENT_SEARCH_COMPANY_OWNED)
    public Resolution searchCompany() {
        ForwardResolution forward =new ForwardResolution(OwnershipEntitySearchActionBean.class, OwnershipEntitySearchActionBean.EVENT_SEARCH_OWNED_ENTITY);
        return forward;
    }

    @HandlesEvent(EVENT_SAVE_SHAREHOLDING)
    public Resolution saveShareholding() {
        abstractShareholding = operatingEntityService.saveShareholding(abstractShareholding);
//        resetSession();
        return new ForwardResolution(OWNERSHIP_JSP_BASE + "/maintainShareholding.jsp");
    }

    @HandlesEvent(EVENT_ADD_COMPANY_OWNED)
    public Resolution addCompany() {
        ForwardResolution resolution = new ForwardResolution(ManageCorporateEntityActionBean.class, ManageCorporateEntityActionBean.EVENT_ADD_OWNED_COMPANY);
        return resolution;
    }

    @HandlesEvent(EVENT_SHARE_TYPE_ADD)
    public Resolution addShareType() {
        assignFromSession();
        ForwardResolution forward = new ForwardResolution(ManageShareTypeActionBean.class, ManageShareTypeActionBean.EVENT_DISPLAY_SHARETYPE);
        if (getOwnedCompany()!=null)  forward.addParameter(COMPANY, getOwnedCompany().getId());
        forward.addParameter(RETURN_TO, ABSTRACT_SHAREHOLDING);
        return forward;
    }


    @Before(stages = LifecycleStage.BindingAndValidation)
    public void loadShareType(){
        assignFromSession();
        if (getContext().getEventName().equals(EVENT_SAVE_SHAREHOLDING)){
            // create relevent shareholding instance depends on weather user has selected owner company or owner individual
            if (ownerCompany!=null){
                abstractShareholding = new CompanyShareholding();
                ((CompanyShareholding)abstractShareholding).setCorporateShareholder(ownerCompany);
                abstractShareholding.setCompany(ownedCompany);
            } else if (ownerIndividual!=null){
                abstractShareholding = new IndividualShareholding();
                ((IndividualShareholding)abstractShareholding).setIndividual(ownerIndividual);
                abstractShareholding.setCompany(ownedCompany);
            }else{
                addLocalizableValidationError("abstractShareholding.owner", "error.oe.sharehloding.invalidownertype");
                return;
            }

            if (getContext().getRequest().getParameter("abstractShareholding.shareType.shareTypeId").trim().length()==0){
                addLocalizableValidationError("abstractShareholding.shareType", "error.oe.sharehloding.sharetype.notselected");
            }else{
                abstractShareholding.setShareType(operatingEntityService.getShareType(new Long(getContext().getRequest().getParameter("abstractShareholding.shareType.shareTypeId"))));
                abstractShareholding.setStatus(Status.Active);
            }
        }
    }

    public AbstractShareholding getAbstractShareholding() {
        return abstractShareholding;
    }

    public void setAbstractShareholding(AbstractShareholding abstractShareholding) {
        this.abstractShareholding = abstractShareholding;
    }

    public Company getOwnedCompany() {
        return ownedCompany;
    }

    public void setOwnedCompany(Company ownedCompany) {
        this.ownedCompany = ownedCompany;
    }

    public Company getOwnerCompany() {
        return ownerCompany;
    }

    public void setOwnerCompany(Company ownerCompany) {
        this.ownerCompany = ownerCompany;
    }

    public Individual getOwnerIndividual() {
        return ownerIndividual;
    }

    public void setOwnerIndividual(Individual ownerIndividual) {
        this.ownerIndividual = ownerIndividual;
    }

    // provide jsp to enabled or disable dealer principle check box 
    public Boolean getDealerPrincipleDisabled() {
        if (ownedCompany==null || ownerIndividual==null){
            return Boolean.TRUE;
        }

        if (ownerIndividual.getDealerStaff()==null){
            return Boolean.TRUE;
        }
        
        return Boolean.FALSE;

    }

    // provide jsp to enabled or disable dealer principle check box
    public void setDealerPrincipleDisabled(Boolean aBoolean) {
        // do nothing
        dealerPrincipleDisabled = aBoolean;
    }


    private void assignFromSession(){
        HttpSession session = getContext().getRequest().getSession(true);
        abstractShareholding = (AbstractShareholding)session.getAttribute(ABSTRACT_SHAREHOLDING);

        if (session.getAttribute(OWNED_COMPANY)!=null) ownedCompany = operatingEntityService.getCorporateEntity(((Company)session.getAttribute(OWNED_COMPANY)).getId());
        if (session.getAttribute(OWNER_COMPANY)!=null) ownerCompany = operatingEntityService.getCorporateEntity(((Company)session.getAttribute(OWNER_COMPANY)).getId());
        if (session.getAttribute(OWNER_INDIVIDUAL)!=null) ownerIndividual = operatingEntityService.getIndividualShareholder(((Individual)session.getAttribute(OWNER_INDIVIDUAL)).getId());
    }

    private void resetSession(){
        HttpSession session = getContext().getRequest().getSession(true);
        session.removeAttribute(ABSTRACT_SHAREHOLDING);
        session.removeAttribute(OWNED_COMPANY);
        session.removeAttribute(OWNER_COMPANY);
        session.removeAttribute(OWNER_INDIVIDUAL);
    }



}