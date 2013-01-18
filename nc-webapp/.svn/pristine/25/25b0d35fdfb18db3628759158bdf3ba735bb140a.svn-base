package au.com.toyota.nc.webapp.stripes.dealerLocations;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import net.sf.json.JSON;
import net.sourceforge.stripes.action.Before;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.controller.LifecycleStage;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidateNestedProperties;
import net.sourceforge.stripes.validation.ValidationErrorHandler;
import net.sourceforge.stripes.validation.ValidationErrors;
import net.sourceforge.stripes.validation.ValidationMethod;

import org.apache.log4j.Logger;

import au.com.toyota.nc.common.AbstractNCException;
import au.com.toyota.nc.common.dealers.exceptions.InvalidDealerException;
import au.com.toyota.nc.common.model.DealerLocationSearchRequest;
import au.com.toyota.nc.common.model.DealerLocationSearchRequestRenderer;
import au.com.toyota.nc.common.model.DealerLocationSearchRequestValidationException;
import au.com.toyota.nc.common.model.DealerLocationSearchResponse;
import au.com.toyota.nc.common.model.hibernate.AbstractDocument;
import au.com.toyota.nc.common.model.hibernate.Appointment;
import au.com.toyota.nc.common.model.hibernate.Dealer;
import au.com.toyota.nc.common.model.hibernate.DealerCommittee;
import au.com.toyota.nc.common.model.hibernate.DealerDocument;
import au.com.toyota.nc.common.model.hibernate.DealerOtherProduct;
import au.com.toyota.nc.common.model.hibernate.Location;
import au.com.toyota.nc.common.model.hibernate.OtherProduct;
import au.com.toyota.nc.common.model.hibernate.SpecialCondition;
import au.com.toyota.nc.common.model.hibernate.ToyotaFranchise;
import au.com.toyota.nc.common.savedsearch.SavedSearch;
import au.com.toyota.nc.common.savedsearch.SavedSearchRegistry;
import au.com.toyota.nc.common.savedsearch.SavedSearchType;
import au.com.toyota.nc.webapp.stripes.AjaxResolution;
import au.com.toyota.nc.webapp.stripes.dealerLocations.validators.ManageDealerLocationActionBeanValidator;

import com.toyota.ibus.common.util.Str;

/**
 * Stripes action bean class for managing dealer.
 * There are several important part in this action bean, so please have a read through this javadoc before
 * attempting to do any modification to the class.
 *
 * First of all, the dealer information on the dealer maintenance screen is separated across multiple pages.
 * In addition, some user can access certain information of a dealer, while some other user cant (i.e. depending on the role).
 * The trick that we chose is to pre-load the dealer before the Stripes'  {@link net.sourceforge.stripes.controller.LifecycleStage#BindingAndValidation},
 * using the dealer ID provided in the request parameter. At the end of this pre-loading, the dealer object will live in this Stripes action class,
 * <strong> as well as in Hibernate's level 1 cache (i.e. Hibernate's {@link org.hibernate.Session})</strong>
 *
 * Then, we let Stripes to do the binding. i.e. take whatever value is passed from the JSP to override the value in the dealer set in this
 * action bean.
 *
 * However, Hibernate has the 'automatic dirty checking' facility, which will persist any dirty object in its 1st level session. This is affecting
 * us, because some of the value bound during the Stripes binding process might be invalid - i.e we havent done any business validation to them.
 *
 * To mitigate this problem, we set the object mode to 'readonly'. Any changes made to the dealer object wont be saved to the database by hibernate
 * (i.e. automatic dirty checking is not enabled on the dealer object).
 *
 * Setting the mode to 'readonly' brings us another effect. Any changes made to the object wont be saved by Hibernate, even if we set
 * readonly to false. This is because:
 * <ol>
 *      <li>We set the readonly mode to 'true' immediately after fetching the dealer</li>
 *      <li>Stripes will then bind the values</li>
 * </ol>
 * <strong>Notice the order above.</strong>
 *
 * If we call 'setreadonly' with 'false' at the end of that steps, and then ask hibernate to save, Hibernate wont persist the changes,
 * because from Hibernate's perspective, there are no changes applied to the object. i.e. it doesnt keep track changes to the object
 * when readonly mode is set to true. Hibernate is being smart ass here.
 *
 * The trick to this problem, is to evict the object from the Hibernate session. (hence call to {@link au.com.toyota.nc.common.services.DBServices#clearCache()}
 * inside {@link #doSave()} ). This will make Hibernate to 'not know anything about this object so far', and have to check manually.
 *
 * The clearCache() method is also called due to the reason mentioned in the doSave() method.
 *
 * User: Alex Wibowo
 * Date: 2/02/2009
 * Time: 21:33:45
 */
public class ManageDealerLocationActionBean extends BaseManageDealerLocationActionBean<DealerDocument> implements ValidationErrorHandler
{
    private static final Logger LOG = Logger.getLogger(ManageDealerLocationActionBean.class);

    public static final String EVENT_DISPLAY_SEARCH = "displaySearchPage";
    public static final String EVENT_DISPLAY_SEARCH_FOR_EDIT = "displaySearchPageForEdit";
    public static final String EVENT_SEARCH_DEALER = "searchDealer";
    public static final String EVENT_SELECT_DEALER_FOR_BULK_UPDATE = "selectDealersForBulkUpdate";

    public static final String EVENT_CREATE_DEALER = "createDealer";
    public static final String EVENT_DISPLAY_CREATE_NEW_DEALER = "newDealer";
    public static final String EVENT_VIEW_DEALER = "viewDealer";
    public static final String EVENT_EDIT_DEALER = "editDealer";
    public static final String EVENT_DISPLAY_LOADED_DEALER = "displayLoadedDealer";
    public static final String EVENT_VERIFY_SAP_CODE = "verifySAPCode";

    public static final String REQUEST_PARAM_DEALER_ID = "dealer.dealerId";

    @ValidateNestedProperties({
        /** General info validations **/
        @Validate(field="generalInfo.dealerCode", maxlength = Dealer.GeneralInfo.MAX_DEALER_CODE),
        @Validate(field="generalInfo.sapDealerCode", maxlength = Dealer.GeneralInfo.MAX_SAP_DEALER_CODE),
        @Validate(field="generalInfo.partsDealerCode", maxlength = Dealer.GeneralInfo.MAX_PARTS_DEALER_CODE),
        @Validate(field="generalInfo.dealerName", maxlength = Dealer.GeneralInfo.MAX_DEALER_NAME),
        @Validate(field="generalInfo.motorDealerLicenseNumber", maxlength = Dealer.GeneralInfo.MAX_MOTOR_DEALER_LICENSE_NUMBER),
        @Validate(field="generalInfo.cessationReason", maxlength = Dealer.GeneralInfo.MAX_CESSATION_REASON),
        @Validate(field="generalInfo.salesDistrict", maxlength = Dealer.GeneralInfo.MAX_SALES_DISTRICT),
        @Validate(field="generalInfo.operationDistrict", maxlength = Dealer.GeneralInfo.MAX_OPERATION_DISTRICT),
        @Validate(field="generalInfo.serviceDistrict", maxlength = Dealer.GeneralInfo.MAX_SERVICE_DISTRICT),
        @Validate(field="generalInfo.note", maxlength = Dealer.GeneralInfo.MAX_NOTE),
        /** Customer Service Info validations **/
        @Validate(field="customerServiceInfo.dealerWarrantyCode", maxlength = Dealer.CustomerServiceInfo.MAX_DEALER_WARRANTY_CODE),
        /** Financial Info validations **/
        @Validate(field="financialInfo.tfsAccountManager", maxlength = Dealer.FinancialInfo.MAX_TFS_ACCOUNT_MANAGER),
        @Validate(field="financialInfo.autoReleaseNumber", maxlength = Dealer.FinancialInfo.MAX_AUTO_RELEASE_NUMBER),
        /** System Info validations **/
        @Validate(field="systemInfo.coinContact", maxlength = Dealer.SystemInfo.MAX_COIN_CONTACT),
        @Validate(field="systemInfo.coinRouterDetails", maxlength = Dealer.SystemInfo.MAX_COIN_ROUTER_DETAILS),
        @Validate(field="systemInfo.contactType", maxlength = Dealer.SystemInfo.MAX_CONTACT_TYPE),
        @Validate(field="systemInfo.coinBandwidth", maxlength = Dealer.SystemInfo.MAX_COIN_BANDWIDTH),
        @Validate(field="systemInfo.connectionSpeed", maxlength = Dealer.SystemInfo.MAX_CONNECTION_SPEED),
        @Validate(field="systemInfo.loginPrefix", maxlength = Dealer.SystemInfo.MAX_LOGIN_PREFIX),
        @Validate(field="systemInfo.itSystemDetails", maxlength = Dealer.SystemInfo.MAX_IT_SYSTEM_DETAILS),
        /** Ownership info validations **/
        @Validate(field="ownershipInfo.dpPercentageEquity", mask="[0-9]{1,3}(\\.[0-9]{0,2})?", minvalue = 0, maxvalue = 100),                    // maximum of 3 integer, and 2 decimal points
        /** Dealer agreement validations **/
        @Validate(field="agreement.renewalTerm", maxlength = Dealer.DealerAgreement.MAX_RENEWAL_TERM),
        @Validate(field="agreement.timeInDealership",minvalue = 0,maxvalue = 999, maxlength = 3),
        /** Dealer Committee validations **/
        @Validate(field="committees.memberName", maxlength = DealerCommittee.MAX_MEMBER_NAME),
        @Validate(field="committees.role", maxlength = DealerCommittee.MAX_ROLE),
        /** Special conditions validation **/
        @Validate(field="specialConditions.number", maxlength = SpecialCondition.MAX_NUMBER),
        @Validate(field="specialConditions.details", maxlength = SpecialCondition.MAX_DETAILS),
        @Validate(field="specialConditions.regionalManagerResponsible", maxlength = SpecialCondition.MAX_REGIONAL_MANAGER_RESPONSIBLE),
        @Validate(field="specialConditions.comments", maxlength = SpecialCondition.MAX_COMMENTS),
        /**  Awards Validation **/
        @Validate(field="awards.yearWon", mask = MASK_YEAR_ONLY),
        /** Document validation **/
        @Validate(field="document.documentName", maxlength = AbstractDocument.MAX_DOCUMENT_NAME),
        @Validate(field="document.url", maxlength = AbstractDocument.MAX_URL)
    })
    private Dealer dealer;

    protected DealerLocationSearchRequest searchReq;
    protected DealerLocationSearchResponse searchRsp;

    protected List<Location> searchLocations;

    private String dealerSAPCode;

    @SpringBean
    private DealerLocationSearchRequestRenderer searchReqRenderer;

    @SpringBean
    private SavedSearchRegistry savedSearchRegistry;

    @SpringBean
    private ManageDealerLocationActionBeanValidator actionBeanValidator;

    /**
     * Indication on creating new dealer
     */
    private Boolean showAsCreatePage;

    @Validate(on = EVENT_SELECT_DEALER_FOR_BULK_UPDATE, required = true)
    private List<Long> dealerIdsForBulkUpdate = new ArrayList<Long>();
    public static final String PROP_DEALERIDS_FOR_BULK_UPDATE = "dealerIdsForBulkUpdate";


    private static final Map<String, String> TAB_TO_PAGE_MAPPING = new HashMap<String, String>();

    static {
        TAB_TO_PAGE_MAPPING.put(EVENT_SHOW_GENERAL_INFORMATION,
                DEALER_JSP_BASE + "/generalInfo/updateGeneralInformation.jsp");
        TAB_TO_PAGE_MAPPING.put(EVENT_SHOW_TMCA_INFORMATION,
                DEALER_JSP_BASE + "/tmcaInfo/updateTMCAInformation.jsp");
        TAB_TO_PAGE_MAPPING.put(EVENT_SHOW_LEGAL_INFORMATION,
                DEALER_JSP_BASE + "/legalInfo/updateLegalInformation.jsp");
        TAB_TO_PAGE_MAPPING.put(EVENT_SHOW_AWARDS_INFORMATION,
                DEALER_JSP_BASE + "/awardsInfo/updateAwardsInformation.jsp");
        TAB_TO_PAGE_MAPPING.put(EVENT_SHOW_IDENTIFICATION_NUMBERS_INFORMATION,
                DEALER_JSP_BASE + "/identificationInfo/updateIdentificationNumbersInformation.jsp");
        TAB_TO_PAGE_MAPPING.put(EVENT_SHOW_SYSTEM_INFORMATION,
                DEALER_JSP_BASE + "/systemInfo/updateSystemInformation.jsp");
        TAB_TO_PAGE_MAPPING.put(EVENT_SHOW_MARKETING_INFORMATION,
                DEALER_JSP_BASE + "/marketingInfo/updateMarketingInformation.jsp");
        TAB_TO_PAGE_MAPPING.put(EVENT_SHOW_FILES_INFORMATION,
                DEALER_JSP_BASE + "/filesInfo/updateFilesInformation.jsp");
        TAB_TO_PAGE_MAPPING.put(EVENT_SHOW_LOCATION_INFORMATION,
                DEALER_JSP_BASE + "/locationInfo/updateLocationInformation.jsp");
    }

    protected Map<String, String> getTabToPageMapping() {
        return TAB_TO_PAGE_MAPPING;
    }


    /**
     * Display page for normal dealer/location search
     */
    @DefaultHandler
    @HandlesEvent(EVENT_DISPLAY_SEARCH)
    public Resolution displaySearchPage() {
        searchReq = DealerLocationSearchRequest.createSearchRequestForViewing(context.getUserRole());
        showAsReadOnly = Boolean.TRUE;
        return new ForwardResolution(DEALER_JSP_BASE + "/searchDealer.jsp");
    }

    @HandlesEvent(EVENT_SELECT_DEALER_FOR_BULK_UPDATE)
    public Resolution selectDealersForBulkUpdate(){
        return DealerBulkUpdateActionBean.getRedirectResolutionForIds(dealerIdsForBulkUpdate);
    }

    @HandlesEvent("displaySavedSearches")
    public Resolution displaySavedSearches()
    {
        return new ForwardResolution(DEALER_JSP_BASE + "/savedDealerSearches.jsp");
    }

    /**
     * Display page for dealer/location search for editing
     */
    @HandlesEvent(EVENT_DISPLAY_SEARCH_FOR_EDIT)
    public Resolution displaySearchPageForEdit(){
        searchReq = DealerLocationSearchRequest.createSearchRequestForEdit(context.getUserRole());
        showAsReadOnly = Boolean.FALSE;
        return new ForwardResolution(DEALER_JSP_BASE + "/searchDealer.jsp");
    }

    /**
     * Display search result page
     */
    @HandlesEvent(EVENT_SEARCH_DEALER)
    public Resolution searchDealer() {
        searchLocations = locationDealerSearchService.findLocationForRole(searchReq, context.getUserRole());
        return new ForwardResolution(DEALER_JSP_BASE + "/searchDealerResult.jsp")
                .addParameter("searchReq.searchForEdit", searchReq.getSearchForEdit());
    }

    /**
     * View dealer. The actual dealer loading is done at {@link #fetchDealer()}
     */
    @HandlesEvent(EVENT_VIEW_DEALER)
    public Resolution viewDealer() throws Exception {
        LOG.info(MessageFormat.format("Viewing dealer with id [{0}]", dealer.getDealerId()));
        setShowAsReadOnly(true);
        return showGeneralInformation();
    }

    /**
     * Edit dealer. The actual dealer loading is done at {@link #fetchDealer}
     */
    @HandlesEvent(EVENT_EDIT_DEALER)
    public Resolution editDealer() throws Exception{
        LOG.info(MessageFormat.format("Editing dealer with id [{0}]", dealer.getDealerId()));

        return showGeneralInformation();
    }

    @HandlesEvent(EVENT_VERIFY_SAP_CODE)
    public Resolution verifySAPCode() {
        JSON jsonObject = sapCodeVerifier.verifySAPDealerAsJSON(dealerSAPCode);
        return new AjaxResolution(jsonObject);
    }

    //--------------------------- Dealer creation ------------------------------------------------
    @HandlesEvent(EVENT_DISPLAY_CREATE_NEW_DEALER)
    public Resolution newDealer() {
        showAsCreatePage=Boolean.TRUE;
        return new ForwardResolution(TAB_TO_PAGE_MAPPING.get(EVENT_SHOW_GENERAL_INFORMATION));
    }


    @HandlesEvent(EVENT_CREATE_DEALER)
    public Resolution createDealer()
    {
        LOG.info(MessageFormat.format("Creating a dealer [{0}]", dealer));
        Resolution forwardResolution;
        try
        {
            dealer = dealerTopology.createDealer(dealer);
            LOG.debug(MessageFormat.format("Successfully created dealer [{0}]", dealer));

            forwardResolution = new RedirectResolution(this.getClass(), EVENT_EDIT_DEALER)
                    .addParameter("dealer.dealerId", dealer.getDealerId());
        }
        catch (InvalidDealerException e)
        {
            LOG.info(MessageFormat.format("Failed to create dealer with error [{0}]", e.getMessage()));
            forwardResolution = context.getSourcePageResolution();
        }
        return forwardResolution;
    }

    @HandlesEvent(EVENT_SCHEDULE_ACTIVATION)
    public Resolution scheduleActivation()
    {
        try
        {
            doSave();
            final Resolution resolution = new ForwardResolution(DealerActivationDeactivationActionBean.class, EVENT_SCHEDULE_ACTIVATION);
            return resolution;
        }
        catch (AbstractNCException e)
        {
            addSimpleGlobalError(e.getMessage());
            return context.getSourcePageResolution();
        }
    }

    @HandlesEvent(EVENT_ACTIVATE)
    public Resolution activate()
    {
        try
        {
            doSave();
            final Resolution resolution = new ForwardResolution(DealerActivationDeactivationActionBean.class, EVENT_ACTIVATE);
            return resolution;
        }
        catch (AbstractNCException e)
        {
            addSimpleGlobalError(e.getMessage());
            return context.getSourcePageResolution();
        }
    }

    @HandlesEvent(EVENT_SCHEDULE_DEACTIVATION)
    public Resolution scheduleDeactivation()
    {
        try
        {
            doSave();
            final Resolution resolution = new ForwardResolution(DealerActivationDeactivationActionBean.class, EVENT_SCHEDULE_DEACTIVATION);
            return resolution;
        }
        catch (AbstractNCException e)
        {
            addSimpleGlobalError(e.getMessage());
            return context.getSourcePageResolution();
        }
    }

    @HandlesEvent(EVENT_DEACTIVATE)
    public Resolution deactivate()
    {
        try
        {
            doSave();
            final Resolution resolution = new ForwardResolution(DealerActivationDeactivationActionBean.class, EVENT_DEACTIVATE);
            return resolution;
        }
        catch (AbstractNCException e)
        {
            addSimpleGlobalError(e.getMessage());
            return context.getSourcePageResolution();
        }
    }

    /**
     * Perform database save/update
     *
     * @see #fetchDealer()
     * @throws Exception
     */
    protected void doSave() throws AbstractNCException {
        try
        {
            if (hasToSave()) {
                    // Because of OSIV pattern, Hibernate's session is going to be bound to the thread. Unfortunately, the UI needs dealer information
                // to be separated across different screen, so we do this by fetching the dealer prior to Stripes binding lifecycle. (See fetchDealer() method).
                // Unfortunately (again), with OSIV, this means that the object will live in the session at the end of the fetchDealer() operation.
                // In the UI, some operations require that we attach children to the dealer, by setting the child's PK directly.  E.g.:
                // 1. fetchDealer() will fetch the parent with a child
                // 2. Stripes binding mechanism will override the child's PK with another child's PK (if we are swapping the child)
                // 3. We ask hibernate to save this new relationship.
                //
                // The problem with OSIV, is that the child on step no.1 already exist in Hibernate session (since the session is bound to the thread), and since
                // that session is not closed until the last stage (i..e exiting the filter), changing the child's ID (in step 2), will make Hibernate scream.
                // This wasnt a problem, if we are not using OSIV, because  fetchDealer() and this updateDealer() method will each open (new) hibernate session.
                // Hence, Hibernate will treat them as different object
                //
                // The hack is to clear Hibernate's session L1 cache between these two operations, so that hibernate wont recognize them as the same child.
                //TODO: ideally we just want to evict the dealer. But see the same error message on ManageLocationActionBean.
                // Even though the error didnt happen for dealer, I just do the same (clearCache()) to be save..
                dbServices.clearCache();
                dealer = dealerTopology.updateDealer(dealer);
            }
        }
        catch (AbstractNCException e)
        {
            LOG.debug(MessageFormat.format("Found exception [{0}] saving Dealer [{1}]. Reloading dealer and re-rendering page", e.getMessage(), dealer));
            dealer = dealerDBService.fetchDealer(dealer.getDealerId()); // to avoid lazy initialization exception
            throw e;
        }
    }

    /**
     * We fetch the dealer prior to binding process, since each of the dealer tab only have partial information on the dealer,
     * and we will overwrite whatever value is passed in from the request during the binding process.
     * So the process is as follows:
     * <ol>
     *      <li> Pre-binding cycle: Retrieve the dealer  (this method)</li>
     *      <li>
     *              Binding & validation cycle: Stripes perform binding process. Whatever value is passed in from the request (partial info
     *              about the dealer) will overwrite the value of the dealer properties fetched in the pre-binding cycle
     *      </li>
     *      <li> Pre-event handling cycle: updateDealer() At this stage, we update the database </li>
     *      <li> Event handling cycle:  depending on the event, we return the resolution to the correct tab </li>
     *      <li> Resolution execution cycle: displays the correct tab </li>
     * </ol>
     */
    @Before(stages = LifecycleStage.BindingAndValidation)
    public void fetchDealer() {
        // Overriden method
        String dealerIdStr = context.getRequest().getParameter(REQUEST_PARAM_DEALER_ID);
        try {
            if (!Str.isEmpty(dealerIdStr)) {
                LOG.info(MessageFormat.format("Dealer ID is present as [{0}], trying to bind to action bean", dealerIdStr));
                if (hasToSave()){
                    dealer = dealerDBService.fetchDealerAndRenewAllAssociations(Long.parseLong(context.getRequest().getParameter(REQUEST_PARAM_DEALER_ID)));
                }else{
                    dealer = dealerDBService.fetchDealer(Long.parseLong(context.getRequest().getParameter(REQUEST_PARAM_DEALER_ID)));
                }
                overrideWriteAccessAsNecessary();

                /**
                 * Set the fetched dealer to be read only. This is because Stripes might bind invalid value to the dealer, which passes the Stripes validation,
                 * but will fail more complicated validation later on (involving SAP, etc). Because we bind the object here, the object will live in  Hibernate session
                 * throughout the whole request (due to OSIV). The trick is to set the object to be read only, to prevent automatic-dirty-checking by Hibernate to
                 * persist the changes on the object to the database. All save must be done explicitly by calling save.
                 */
                dbServices.setReadOnly(dealer);
            }
        } catch (InvalidDealerException e) {
            LOG.info(MessageFormat.format("Dealer ID [{0}] is not present in database", dealerIdStr));
        }
    }

    protected boolean isUserAllowedToMaintainEntity() {
        return dealerSecurityContext.canUserMaintainDealer(dealer, context.getUserDetails(), context.getUserRole());
    }

    protected Object getManagedEntity() {
        return dealer;
    }

    /**
     * On switching between tabs, we need to pass in several variables:
     * <ul>
     *      <li>Last tab shown: this is needed, as on saving / changing dealer status, we need to display the last page being shown.</li>
     *      <li>Show as read only: this is needed, as the page will enquire whether to render as viewable / editable page</li>
     *      <li>Current dealer ID being edited: this is needed, as we need to fetch the dealer on switching to different tab</li>
     * </ul>
     * @param lastTabShown the last tab shown
     * @return parameter map
     */
    protected Map<String, Object> getParametersOnTabSwitch(String lastTabShown) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put(REQUEST_LAST_TAB_SHOWN, lastTabShown);
        params.put(REQUEST_READ_ONLY_MODE, getShowAsReadOnly());
        params.put(REQUEST_PARAM_DEALER_ID, dealer.getDealerId());
        return params;
    }

    public List<ToyotaFranchise> getPossibleSecondaryToyotaFranchise() {
        if (dealer == null || dealer.getGeneralInfo().getMainFranchise()==null) {
            return super.getAllToyotaFranchise();
        }else{
            List<ToyotaFranchise> allToyotaFranchise = super.getAllToyotaFranchise();
            ToyotaFranchise mainFranchise = dealer.getGeneralInfo().getMainFranchise();
            allToyotaFranchise.remove(mainFranchise);
            return allToyotaFranchise;
        }
    }

    /**
     * We do these validations here, instead of annotating the dealer property with the validate annotation, because:
     * <ul>
     *      <li> We fetch the dealer property prior to binding & validation lifecycle</li>
     *      <li>You might think that both 'dealerName' & 'mainFranchise' should exist (i.e. populated) in the dealer property prior
     *     to Stripes doing the validation</li>
     *      <li> This is not the case. Stripes validation works against the request parameter, and not the bean property. So even though
     *     the bean is populated (via interception), the parameters wont always contain the dealer's name & mainFranchise (e.g. if
     *     we navigate from TMCA tab)</li>
     *     <li>With custom validation, on the other hand,  is done after the binding lifecycle. So we can be sure if the incoming request
     *      has overriden any of the dealer property.</li>
     * </ul>
     *
     * @see net.sourceforge.stripes.controller.DefaultActionBeanPropertyBinder#bind(net.sourceforge.stripes.action.ActionBean, net.sourceforge.stripes.action.ActionBeanContext, boolean)
     * @see net.sourceforge.stripes.controller.DefaultActionBeanPropertyBinder#validateRequiredFields(java.util.Map, net.sourceforge.stripes.action.ActionBean, net.sourceforge.stripes.validation.ValidationErrors)
     */
    @ValidationMethod(on = {
        EVENT_SHOW_GENERAL_INFORMATION, EVENT_SHOW_TMCA_INFORMATION, EVENT_SHOW_LEGAL_INFORMATION,
         EVENT_SHOW_AWARDS_INFORMATION, EVENT_SHOW_IDENTIFICATION_NUMBERS_INFORMATION,
            EVENT_SHOW_SYSTEM_INFORMATION, EVENT_SHOW_MARKETING_INFORMATION,  EVENT_SHOW_FILES_INFORMATION,
            EVENT_CREATE_DEALER, EVENT_SAVE
    })
    public void ensureDealerNameAndMainFranchise() {
        actionBeanValidator.validateDealerNameAndFranchise(dealer, getContext());
    }


    /**
     * Validating special conditions
     */
    @ValidationMethod
    public void validateSpecialConditions() {
        if (!isReadOnly()&& isLastTabShown(EVENT_SHOW_LEGAL_INFORMATION) && dealer.hasSpecialCondition()) {
            actionBeanValidator.validateSpecialConditions(dealer, getContext());
        }
    }

    /**
     * Validating dealer committee
     */
    @ValidationMethod
    public void validateDealerCommittee(){
        if (!isReadOnly() && isLastTabShown(EVENT_SHOW_TMCA_INFORMATION) && dealer.getCommittees() != null) {
            actionBeanValidator.validateDealerCommittee(dealer, getContext());
        }
   }

    /**
     * Validating subscription
     */
    @ValidationMethod
    public void validateSubscription(){
        if (!isReadOnly() && isLastTabShown(EVENT_SHOW_MARKETING_INFORMATION) && dealer.getMarketingSubscription() != null) {
            actionBeanValidator.validateSubscription(dealer, getContext());
        }
    }



    /**
     * Perform search validation
     */
    @ValidationMethod(on={EVENT_SEARCH_DEALER})
    public void validateSearch(){
        LOG.debug("Validating dealer location search");
        try {
            searchReq.validate();
        } catch (DealerLocationSearchRequestValidationException e) {
            addSimpleGlobalError(e.getMessage());
        }
    }

    public Dealer getDealer()
    {
        return dealer;
    }

    public void setDealer(Dealer dealer)
    {
        this.dealer = dealer;
    }

    protected Object getDocumentOwner(){
        return getDealer();
    }

    public DealerLocationSearchResponse getSearchRsp() {
        return searchRsp;
    }

    public void setSearchRsp(DealerLocationSearchResponse searchRsp) {
        this.searchRsp = searchRsp;
    }

    public DealerLocationSearchRequest getSearchReq()
     {
         return searchReq;
     }

     public void setSearchReq(DealerLocationSearchRequest searchReq)
     {
         this.searchReq = searchReq;
     }

    public String getSearchReqForRendering(){
        return    searchReqRenderer.render(searchReq);
    }

    public Boolean getShowAsCreatePage() {
        return showAsCreatePage;
    }

    public void setShowAsCreatePage(Boolean showAsCreatePage) {
        this.showAsCreatePage = showAsCreatePage;
    }

    public String getDealerSAPCode() {
        return dealerSAPCode;
    }

    public void setDealerSAPCode(String dealerSAPCode) {
        this.dealerSAPCode = dealerSAPCode;
    }

    public boolean isHasSavedSearches()
    {
        return getSavedSearches().size() > 0;
    }

    public List<SavedSearch> getSavedSearches()
    {
        return savedSearchRegistry.getAllFor(SavedSearchType.LOCATION, getContext().getLoginId());
    }

    public int getSavedSearchesSize()
    {
        return getSavedSearches().size();
    }

    public List<Long> getDealerIdsForBulkUpdate() {
        return dealerIdsForBulkUpdate;
    }

    public void setDealerIdsForBulkUpdate(List<Long> dealerIdsForBulkUpdate) {
        this.dealerIdsForBulkUpdate = dealerIdsForBulkUpdate;
    }

    public List<OtherProduct> getAllOtherProductIncludingSelectedDisabled()
    {
        final LinkedHashSet orderedHashSet = new LinkedHashSet();
        orderedHashSet.addAll(getAllOtherProduct());
        for (DealerOtherProduct dealerOtherProduct : getDealer().getOtherProducts())
        {
            orderedHashSet.add(dealerOtherProduct.getType());
        }
        return new ArrayList<OtherProduct>(orderedHashSet);
    }

    protected void documentUploadValidationFailedCallback() throws InvalidDealerException {
          dealer = dealerDBService.fetchDealerAndRenewAllAssociations(dealer.getDealerId());
    }

    public Resolution handleValidationErrors(ValidationErrors errors) throws Exception {
        if (context.isInAnyEvents(EVENT_SELECT_DEALER_FOR_BULK_UPDATE)){
            LOG.debug("Validation error while performing dealer selection for bulk update.");
            // This is required, otherwise on validation error (user didnt select any dealer, for example), the page will be empty (no dealers)
            searchLocations = locationDealerSearchService.findLocationForRole(searchReq,context.getUserRole());
        }else if (context.isInAnyEvents(EVENT_UPLOAD_DOCUMENT)) {
            LOG.debug("Validation error while performing dealer document upload");
            documentUploadValidationFailedCallback();
        }
        return context.getSourcePageResolution();
    }

    protected boolean hasToRenewAllAssociationsOnFetch() {
        return !showAsReadOnly && (userSwitchBetweenTabs() || userPerformSave());
    }

    public List<Location> getSearchLocations()
    {
        return searchLocations;
    }

    public List<Location> getAllowedLocationsForDealer()
    {
        final DealerLocationSearchRequest request = new DealerLocationSearchRequest();
        request.setDealerId(getDealer().getDealerId());
        request.setLocationStatus(getAllowedStatusSearchParameter());
        request.setDealerStatus(getAllowedStatusSearchParameter());
        return locationDealerSearchService.findLocationForRole(request, getContext().getUserRole());
    }

    // should only be called when dealer is active... so safe to assume has ID
    public Set<String> getDeActivatableDealersStaffNames() throws InvalidDealerException
    {
        final Set<String> staffNames = new HashSet<String>();
        if(getDealer() != null)
        {
            Dealer dealer = getDealer();
            dealer = dealerDBService.fetchDealer(dealer.getDealerId()); // required to reload cos of NC-584 ... lazy initialization exception otherwise with appointments!!
            for (Location location : dealer.getActiveLocations())
            {
                for (Appointment appointment : location.getActiveAppointments())
                {
                    staffNames.add(appointment.getPerson().getFullName());
                }
            }
        }
        return staffNames;
    }
    
    /**
     * Get the actual username from the toyota LDAP using the T/K number or the dealer name.  
     * @return The actual name from e-Dir
     */
    public String getLastMaintainedUserNameFromLDAP() {
    	return getLastMaintainedUserName(dealer);
    }
}
