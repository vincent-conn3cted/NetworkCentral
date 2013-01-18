package au.com.toyota.nc.webapp.stripes.ownershipEntity;

import au.com.toyota.nc.common.model.OwnershipEntitySearchRequest;
import au.com.toyota.nc.common.model.OwnershipEntitySearchResponse;
import au.com.toyota.nc.common.model.hibernate.OwnerEntityType;
import au.com.toyota.nc.common.model.hibernate.Status;
import au.com.toyota.nc.common.model.hibernate.Company;
import au.com.toyota.nc.common.model.hibernate.Individual;
import au.com.toyota.nc.common.ownerentity.OperatingEntityService;
import au.com.toyota.nc.webapp.decorator.RequestDecorator;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;
import net.sourceforge.stripes.action.*;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.controller.LifecycleStage;
import org.apache.log4j.Logger;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;

/**
 * User: Deepthi Fernando
 * Date: 17/02/2009
 * Time: 11:19:32 AM
 */
public class OwnershipEntitySearchActionBean extends OwnershipEntityActionBean implements RequestDecorator {
    private static final Logger LOG = Logger.getLogger(OwnershipEntitySearchActionBean.class.getName());

    public static final String EVENT_SEARCH = "search";
    public static final String EVENT_SEARCH_OWNER_ENTITY = "searchOwner";
    public static final String EVENT_SEARCH_OWNED_ENTITY = "searchOwned";

    public static final String EVENT_SELECT_COMPANY_OWNED = "selectCompanyOwned";
    public static final String EVENT_SELECT_INDIVIDUAL_OWNER = "selectIndividualOwner";
    public static final String EVENT_SELECT_COMPANY_OWNER = "selectCompanyOwner";

    
    private OwnershipEntitySearchRequest searchReq = new OwnershipEntitySearchRequest();
    private OwnershipEntitySearchResponse searchRsp;
    private Company company;
    private Individual individual;

    public OwnershipEntitySearchResponse getSearchRsp() {
        return searchRsp;
    }

    public void setSearchRsp(OwnershipEntitySearchResponse searchRsp) {
        this.searchRsp = searchRsp;
    }

    public OwnershipEntitySearchRequest getSearchReq() {
        return searchReq;
    }

    public void setSearchReq(OwnershipEntitySearchRequest searchReq) {
        this.searchReq = searchReq;
    }

    @DefaultHandler
    public Resolution displayMenu(){
        return new ForwardResolution(OWNERSHIP_JSP_BASE + "/ownershipEntityMenu.jsp");
    }

    @HandlesEvent(EVENT_SEARCH)
    public Resolution search() {
        if (isValidate(getSearchReq())){
            searchRsp = operatingEntityService.findOwnershipEntity(getSearchReq());
            setReturnTo(getReturn());
            return new ForwardResolution(OWNERSHIP_JSP_BASE + "/ownershipEntityResults.jsp");
        }else{
            return new ForwardResolution(OWNERSHIP_JSP_BASE + "/ownershipEntityMenu.jsp");
        }
    }

    @HandlesEvent(EVENT_SEARCH_OWNED_ENTITY)
    public Resolution searchOwned() {
        searchReq.setType(OwnerEntityType.Company);
        searchReq.setStatus(Status.Active);
        setReturnTo(OWNED_COMPANY);
//        searchRsp = operatingEntityService.findOwnershipEntity(request);
        return new ForwardResolution(OWNERSHIP_JSP_BASE + "/ownershipEntityMenu.jsp");
    }

    @HandlesEvent(EVENT_SELECT_COMPANY_OWNED)
    public Resolution selectCompanyOwned() {
        HttpSession session = getHttpSession();
        session.setAttribute(OWNED_COMPANY, operatingEntityService.getCorporateEntity(getCompany().getId()));
        return new ForwardResolution(ManageShareholdingActionBean.class, ManageShareholdingActionBean.EVENT_DISPLAY_SHAREHOLDING);
    }

    @HandlesEvent(EVENT_SELECT_INDIVIDUAL_OWNER)
    public Resolution selectIndividualOwner() {
        HttpSession session = getHttpSession();
        // making sure only individual is selected
        session.removeAttribute(OWNER_COMPANY);
        session.setAttribute(OWNER_INDIVIDUAL, operatingEntityService.getIndividualShareholder(getIndividualID()));
        return new ForwardResolution(ManageShareholdingActionBean.class, ManageShareholdingActionBean.EVENT_DISPLAY_SHAREHOLDING);
    }

    @HandlesEvent(EVENT_SELECT_COMPANY_OWNER)
    public Resolution selectCompanyOwner() {
        HttpSession session = getHttpSession();
        // making sure only company is selected
        session.removeAttribute(OWNER_INDIVIDUAL);
        session.setAttribute(OWNER_COMPANY,  operatingEntityService.getCorporateEntity(getCompany().getId()));
        return new ForwardResolution(ManageShareholdingActionBean.class, ManageShareholdingActionBean.EVENT_DISPLAY_SHAREHOLDING);
    }

    @HandlesEvent(EVENT_SEARCH_OWNER_ENTITY)
    public Resolution searchOwner() {
        searchReq.setStatus(Status.Active);
        setReturnTo(OWNER_COMPANY);
//        searchRsp = operatingEntityService.findOwnershipEntity(request);
        return new ForwardResolution(OWNERSHIP_JSP_BASE + "/ownershipEntityMenu.jsp");
    }

/*

    @Before(LifecycleStage.BindingAndValidation)    
    public void checkValues(){
        HttpServletRequest request = getContext().getRequest();

        System.out.println(request.getParameterNames());

    }
    @After(LifecycleStage.BindingAndValidation)    
    public void checkValues1(){
        HttpServletRequest request = getContext().getRequest();

        System.out.println(request.getParameterNames());

    }

*/
    private boolean isValidate(OwnershipEntitySearchRequest searchReq){
        if (searchReq.getName()==null && searchReq.getStatus()==null && searchReq.getType()==null){
            addLocalizableGlobalError("error.oe.searchvalidator");
            return false;
        }else{
            return true;
        }
    }

    public Object getRequestForDecoration() {
        return searchReq;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public Individual getIndividual() {
        return individual;
    }

    public void setIndividual(Individual individual) {
        this.individual = individual;
    }
}
