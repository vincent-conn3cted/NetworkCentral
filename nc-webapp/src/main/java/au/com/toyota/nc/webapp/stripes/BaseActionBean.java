package au.com.toyota.nc.webapp.stripes;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import net.sourceforge.stripes.action.ActionBean;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.integration.spring.SpringHelper;
import net.sourceforge.stripes.validation.ValidationError;
import net.sourceforge.stripes.validation.ValidationErrors;

import org.apache.log4j.Logger;

import au.com.toyota.isd.common.ldap.model.User;
import au.com.toyota.nc.common.auth.UserRepository;
import au.com.toyota.nc.common.batch.DealerChangeoverTopology;
import au.com.toyota.nc.common.comparartors.GenericComparator;
import au.com.toyota.nc.common.dealers.DealerDBService;
import au.com.toyota.nc.common.dealers.DealerSapService;
import au.com.toyota.nc.common.dealers.DealerTopology;
import au.com.toyota.nc.common.dealers.PMAService;
import au.com.toyota.nc.common.dealers.group.GroupServices;
import au.com.toyota.nc.common.dealers.users.UsersDealerService;
import au.com.toyota.nc.common.documents.DocumentServices;
import au.com.toyota.nc.common.locations.LocationDBService;
import au.com.toyota.nc.common.locations.LocationDealerSearchService;
import au.com.toyota.nc.common.locations.LocationSapService;
import au.com.toyota.nc.common.locations.LocationTopology;
import au.com.toyota.nc.common.model.OwnershipEntitySearchRequest;
import au.com.toyota.nc.common.model.OwnershipEntitySearchResponse;
import au.com.toyota.nc.common.model.PersistentEntity;
import au.com.toyota.nc.common.model.hibernate.Appointment;
import au.com.toyota.nc.common.model.hibernate.AwardLevel;
import au.com.toyota.nc.common.model.hibernate.AwardName;
import au.com.toyota.nc.common.model.hibernate.BusinessImprovement;
import au.com.toyota.nc.common.model.hibernate.Committee;
import au.com.toyota.nc.common.model.hibernate.Company;
import au.com.toyota.nc.common.model.hibernate.CompanyStructure;
import au.com.toyota.nc.common.model.hibernate.DMSVendor;
import au.com.toyota.nc.common.model.hibernate.Dealer;
import au.com.toyota.nc.common.model.hibernate.DealerPrefix;
import au.com.toyota.nc.common.model.hibernate.DocumentType;
import au.com.toyota.nc.common.model.hibernate.FinanceCompany;
import au.com.toyota.nc.common.model.hibernate.FinancialBenchmarkType;
import au.com.toyota.nc.common.model.hibernate.FranchiseCodeEvent;
import au.com.toyota.nc.common.model.hibernate.Group;
import au.com.toyota.nc.common.model.hibernate.ITConnectionType;
import au.com.toyota.nc.common.model.hibernate.LexusWeightGroupValues;
import au.com.toyota.nc.common.model.hibernate.LocationType;
import au.com.toyota.nc.common.model.hibernate.MarketingSubscriptionType;
import au.com.toyota.nc.common.model.hibernate.OtherFranchiseType;
import au.com.toyota.nc.common.model.hibernate.OtherProduct;
import au.com.toyota.nc.common.model.hibernate.PMA;
import au.com.toyota.nc.common.model.hibernate.Party;
import au.com.toyota.nc.common.model.hibernate.Region;
import au.com.toyota.nc.common.model.hibernate.ServiceType;
import au.com.toyota.nc.common.model.hibernate.SpecialConditionStatus;
import au.com.toyota.nc.common.model.hibernate.SpecialConditionType;
import au.com.toyota.nc.common.model.hibernate.SubPMA;
import au.com.toyota.nc.common.model.hibernate.TMCADivision;
import au.com.toyota.nc.common.model.hibernate.TMCAStaff;
import au.com.toyota.nc.common.model.hibernate.ToyotaFranchise;
import au.com.toyota.nc.common.model.hibernate.ToyotaWeightGroupValues;
import au.com.toyota.nc.common.model.hibernate.WeightGroupType;
import au.com.toyota.nc.common.ownerentity.OperatingEntityService;
import au.com.toyota.nc.common.security.NCRole;
import au.com.toyota.nc.common.services.DBServices;
import au.com.toyota.nc.common.services.DMSVendorServices;
import au.com.toyota.nc.common.services.MasterTableServices;
import au.com.toyota.nc.common.staff.AppointmentServices;
import au.com.toyota.nc.common.staff.AppointmentTopology;
import au.com.toyota.nc.common.staff.PositionService;
import au.com.toyota.nc.common.staff.StaffServices;
import au.com.toyota.nc.common.staff.StaffTopology;
import au.com.toyota.nc.common.staff.exceptions.AppointmentNotFoundException;
import au.com.toyota.nc.common.utils.LdapLookupHelper;
import au.com.toyota.nc.common.utils.NCConstants;
import au.com.toyota.nc.common.utils.urls.NetworkCentralLinksConfiguration;

/**
 * Base class for all action beans, following the layer supertype pattern (A type that acts as the supertype for all
 * types in its layer).
 * The setContext() method follows the template method pattern, where subclasses can hook in any logic they want
 * executed at setContext()-time via overriding the preBind() method.
 *
 * User: Alex Wibowo
 * Date: 19/09/2008
 * Time: 11:11:05
 */
public class BaseActionBean implements ActionBean {
    private static final Logger LOG = Logger.getLogger(BaseActionBean.class.getName());

    public static final String MASK_PHONE = "[0-9]{2} [0-9]{4} [0-9]{4}";
    public static final String MASK_MOBILE = "[0-9]{4} [0-9]{3} [0-9]{3}";
    public static final String MASK_ACN = "[0-9]{3} [0-9]{3} [0-9]{3}";
    public static final String MASK_ABN = "[0-9]{2} [0-9]{3} [0-9]{3} [0-9]{3}";
    public static final String MASK_POSTCODE = "[0-9]{4}";
    public static final String MASK_EMAIL = "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";
    public static final String MASK_NUMERIC_ONLY = "^\\d{1,20}$";
    public static final String MASK_CHARACTERS_ONLY = "^\\D{1,200}$";
    public static final String MASK_YEAR_ONLY = "[0-9]{4}";
    public static final String MASK_TIME = "^([ 01]?[0-9]|[2][0-3])(:[0-5][0-9])$";

//    public static final String MASK_WEBSITE = "[0-9]{2}x[0-9]{4}-[0-9]{4}";
    protected static String RETURN_TO="returnTo";
    private String returnTo;

    protected static final ThreadLocal<SimpleDateFormat> DATE_FORMATTER = new ThreadLocal<SimpleDateFormat>()
    {
        protected SimpleDateFormat initialValue()
        {
            return new SimpleDateFormat(NCConstants.FORMAT_DD_MM_YYYY_HH_mm);
        }
    };

    protected NCActionBeanContext context;

    @SpringBean
    protected UsersDealerService usersDealerService;

    @SpringBean
    protected DBServices dbServices;

    @SpringBean
    protected MasterTableServices masterTableServices;

    @SpringBean
    protected AppointmentServices appointmentServices;

    @SpringBean
    protected PositionService positionService;

    @SpringBean
    protected PMAService pmaService;

    @SpringBean
    protected DealerDBService dealerDBService;

    @SpringBean
    protected LocationDealerSearchService locationDealerSearchService;

    @SpringBean
    protected DealerSapService dealerSAPService;

    @SpringBean
    protected DealerTopology dealerTopology;

    @SpringBean
    protected LocationDBService locationDBService;

    @SpringBean
    protected LocationSapService locationSAPService;

    @SpringBean
    protected LocationTopology locationTopology;

    @SpringBean
    protected AppointmentTopology appointmentTopology;

    @SpringBean
    protected StaffServices staffServices;

    @SpringBean
    protected StaffTopology staffTopology;

    @SpringBean
    protected GroupServices groupServices;

    @SpringBean
    protected DMSVendorServices dmsVendorServices;

    @SpringBean
    protected DocumentServices documentServices;

    @SpringBean
    protected DealerChangeoverTopology dealerChangeoverTopology;

    @SpringBean
    protected OperatingEntityService operatingEntityService;

    @SpringBean
    private NetworkCentralLinksConfiguration linksConfiguration;

    @SpringBean
    protected UserRepository userRepository;
    
    @SpringBean
    protected LdapLookupHelper ldapLookupHelper;

    protected static final String JSP_BASE = "/WEB-INF/jsp/nc";
    
    // set if conformation pop up needs to be displayed.
    private boolean showConfirmation;

    public NetworkCentralLinksConfiguration getLinksConfiguration()
    {
        return linksConfiguration;
    }

    public void setContext(ActionBeanContext context) {
        this.context = (NCActionBeanContext) context;
        SpringHelper.injectBeans(this.context, context.getServletContext());
        preBind();
    }

    public NCActionBeanContext getContext() {
        return context;
    }


    /**
      * Default implementation does nothing.  Override this method if you
      * need to execute any additional logic that would normally take place in
      * the setContext() method, if this layer supertype wasn't "hogging" it.
      */
    protected void preBind() {
    }

    public String getContextPath() {
        return getContext().getRequest().getContextPath();
    }

    public List<FinanceCompany> getAllFinanceCompanies() {
        return masterTableServices.findAllActive(FinanceCompany.class);
    }

    public List<ToyotaWeightGroupValues> getAllToyotaWeightGroupValues(){
        return masterTableServices.findAllActive(ToyotaWeightGroupValues.class);
    }

    public List<LexusWeightGroupValues> getAllLexusWeightGroupValues() {
        return masterTableServices.findAllActive(LexusWeightGroupValues.class);
    }

    public List<CompanyStructure> getAllCompanyStructures() {
        return Arrays.asList(CompanyStructure.values());
    }

    public List<BusinessImprovement> getAllBusinessImprovements() {
        return masterTableServices.findAllActive(BusinessImprovement.class);
    }

    public List<FinancialBenchmarkType> getAllFinancialBenchmark() {
        return masterTableServices.findAllActive(FinancialBenchmarkType.class);
    }

    public List<ToyotaFranchise> getAllToyotaFranchise() {
        List<ToyotaFranchise> result = new ArrayList<ToyotaFranchise>();
        result.addAll(Arrays.asList(ToyotaFranchise.values()));
        return result;
    }

    public List<SubPMA> getAllSubPMA() {
        return masterTableServices.findAllActive(SubPMA.class);
    }

    public List<OtherFranchiseType> getAllOtherFranchise() {
        return masterTableServices.findAllActive(OtherFranchiseType.class);
    }

    public List<OtherProduct> getAllOtherProduct() {
        return masterTableServices.findAllActive(OtherProduct.class);
    }

    public List<Committee> getAllCommittees() {
        return masterTableServices.findAllActive(Committee.class);
    }

    public List<AwardLevel> getAllAwardLevel(){
        return masterTableServices.findAllActive(AwardLevel.class);
    }

    public List<AwardName> getAllAwardName() {
        return masterTableServices.findAllActive(AwardName.class);
    }

    public List<ServiceType> getAllServiceType() {
        return masterTableServices.findAllActive(ServiceType.class);
    }

    public List<ITConnectionType> getAllITConnectionType() {
        return masterTableServices.findAllActive(ITConnectionType.class);
    }

    public List<MarketingSubscriptionType> getAllMarketingSubscriptionType() {
        return masterTableServices.findAllActive(MarketingSubscriptionType.class);
    }

    public List<DealerPrefix> getAllDealerPrefix() {
        return masterTableServices.findAllActive(DealerPrefix.class);
    }

    public List<SpecialConditionType> getAllSpecialConditions() {
        return Arrays.asList(SpecialConditionType.values());
    }

    public List<Company> getAllCompany() {
        OwnershipEntitySearchResponse response = operatingEntityService.findOwnershipEntity(OwnershipEntitySearchRequest.createSearchForActiveCompany());
        List<Company> result = new ArrayList<Company>();
        for (Party party : response.getParty()) {
            result.add((Company) party);
        }
        return result;
    }

    public List<SpecialConditionStatus> getAllSpecialConditionStatus() {
        return Arrays.asList(SpecialConditionStatus.values());
    }

    public List<TMCADivision> getAllTMCADivision() {
        return Arrays.asList(TMCADivision.values());
    }

    public List<DocumentType> getAllDocumentType() {
        return Arrays.asList(DocumentType.values());
    }

    public List<Dealer> getAllDealers(){
        return dealerDBService.getAllDealers();
    }

    public List<WeightGroupType> getToyotaWeightGroup(){
        return WeightGroupType.getToyotaWeightGroup();
    }

    public List<WeightGroupType> getLexusWeightGroup(){
        return WeightGroupType.getLexusWeightGroup();
    }

    public List<DMSVendor> getAllVendors(){
         return dmsVendorServices.getAllDMSVendors().getVendors();
     }

    public List<DMSVendor> getAllActiveVendors(){
         return dmsVendorServices.getAllActive();
     }

    public List<FranchiseCodeEvent> getAllFranchiseCodeEvent() {
        return masterTableServices.findAllActive(FranchiseCodeEvent.class);
    }

    public List<LocationType> getAllLocationTypes(){
        return Arrays.asList(LocationType.values());
    }

    public List<PMA> getAllPMA(){
        return pmaService.getAllPMA();
    }

    public List<TMCAStaff> getAllTMCAStaff(){
    	List<TMCAStaff> tmcaStaffList = staffServices.getAllTMCAStaff().getStaffs(); 
        sortStaffListByFullName(tmcaStaffList);
        return tmcaStaffList; 
    }

    public List<Group> getAllGroups(){
        return groupServices.getAll().getGroups();
    }

    public List<Group> getAllActiveGroups()
    {
        return groupServices.getAllActive();
    }

    /**
     * Add localizable validation error message
     *
     * @param field the field in error
     * @param messageKey error message key in Stripes resources
     * @param params parameter to the message in the Stripes resources
     */
    public void addLocalizableValidationError(String field, String messageKey, Object... params){
        getContext().addLocalizableValidationError(field,messageKey, params);
    }

    /**
     * Add localizable global error
     *
     * @param messageKey error message key in Stripes resource
     * @param params     parameter to the message in the Stripes resources
     */
    public void addLocalizableGlobalError(String messageKey, Object... params) {
        getContext().addLocalizableGlobalError(messageKey, params);
    }


    /**
     * Add localizable global warning
     *
     * @param messageKey warning message key in Stripes resource
     * @param params parameter to the message in the Stripes resource
     */
    public void addLocalizableGlobalWarning(String messageKey, Object... params) {
        getContext().addLocalizableGlobalWarning(messageKey, params);
    }

    /**
     * Add simple global warning
     *
     * @param message warning message
     */
    public void addSimpleGlobalWarning(String message) {
        getContext().addSimpleGlobalWarning(message);
    }


    /**
     * Convert the given {@link ValidationErrors} object to global warnings. This method is used
     * as a workaround where we are supposed to have the error after redirect. Stripes doesnt
     * store the ValidationErrors object in FlashScope (hence, not available after a RedirectResolution)
     *
     * @param errors errors object
     */
    public void convertToSimpleGlobalWarning(ValidationErrors errors) {
       for (List<ValidationError> validationErrors : errors.values()) {
            for (ValidationError validationError : validationErrors) {
                addSimpleGlobalWarning(validationError.getMessage(context.getLocale()));
            }
        }
    }


    /**
     * Add simple validation error message
     *
     * @param field the field in error
     * @param message error message
     * @param params parameter to the error message
     */
    public void addSimpleValidationError(String field, String message, Object... params){
        getContext().addSimpleValidationError(field, message, params);
    }

    /**
     * Add simple global error
     *
     * @param errorMessage error message
     * @param params parameter to the error message
     */
    public void addSimpleGlobalError(String errorMessage, Object... params) {
        getContext().addSimpleGlobalError(errorMessage, params);
    }

    /**
     * Add localizable global message
     *
     * @param messageKey message key in Stripes resources
     * @param params parameter to the message in the Stripes resources
     */
    public void addLocalizableGlobalMessage(String messageKey, Object... params) {
        getContext().addLocalizableGlobalMessage(messageKey, params);
    }

    /**
     * Add simple global message
     *
     * @param message the message
     * @param params parameters to the message
     */
    public void addSimpleGlobalMessage(String message, Object... params) {
        getContext().addSimpleGlobalMessage(message, params);
    }

    protected void populateUserDetails(){
        LOG.info("Setting user details");
        Principal userPrincipal = getContext().getRequest().getUserPrincipal();
        User user = userRepository.fetchUser(userPrincipal.getName());
        getContext().setUserDetails(user);
    }

    /**
     * Check if the login details has not been recorded ({@link NCActionBeanContext#getUserDetails()} returns <code>null</code>)
     * @return <code>true</codeE> if login details is not present, <code>false</code> otherwise
     */
    protected boolean isLoginDetailsPresent() {
        return getContext().getUserDetails() != null;
    }

    public boolean isToyotaDealer(){
        //TODO: put logic here to determine whether toyota dealer/not
        return true;
    }

    public boolean isLexusDealer(){
        //TODO: put logic here to determine whether lexus dealer/not
        return false;
    }

    public void setAppointmentTopology(AppointmentTopology appointmentTopology)
    {
        this.appointmentTopology = appointmentTopology;
    }

    protected String getReturn(){
        if (getContext().getRequest().getParameter(RETURN_TO).equals("")) return null;
        else return getContext().getRequest().getParameter(RETURN_TO);
    }

    public String getReturnTo() {
        return returnTo;
    }

    public void setReturnTo(String returnTo) {
        this.returnTo = returnTo;
    }


    protected String formatDate(Date date)
    {
        return DATE_FORMATTER.get().format(date);
    }

    public Appointment getLoggedInUsersAppointment() throws AppointmentNotFoundException
    {
        return appointmentServices.fetchAppointmentForUsercode(getContext().getUserDetails().getCn());
    }

    public List<Dealer> getEligibleDealerships()
    {
        return usersDealerService.getEligibleDealershipsFor(getContext().getUserDetails(), getContext().getUserRole());
    }

    public Region getUsersRegion()
    {
        return Region.getRegionForUser(getContext().getUserDetails());
    }
    
    /**
     * Get the actual username from the toyota LDAP using the T/K number or the dealer name.  
     * @return The actual name from e-Dir
     */
    public String getLastMaintainedUserName(PersistentEntity persistentObject) {
    	return ldapLookupHelper.findEmployeeByPIN(persistentObject.getUserCn());
    }
    
    /**
     * Check if the logged in user can see the last maintained footer.
     * @return true if footer can be displayed otherwise false.
     */
    public boolean isFooterDisplayable() {
    	NCRole role =  (NCRole) context.getSession().getAttribute(NCConstants.SESSION_KEY_USER_ROLE);
    	return role.isRoleInViewerGroup();
    }

	public boolean isShowConfirmation() {
		return showConfirmation;
	}

	public void setShowConfirmation(boolean showConfirmation) {
		this.showConfirmation = showConfirmation;
	}
	
	public void sortStaffListByFullName(List<TMCAStaff> tmcaStaffList) 
    {
    	if(tmcaStaffList == null)
    		return;
    	
    	Collections.sort(tmcaStaffList, new GenericComparator<TMCAStaff>("fullName", true));
	}
	
}
