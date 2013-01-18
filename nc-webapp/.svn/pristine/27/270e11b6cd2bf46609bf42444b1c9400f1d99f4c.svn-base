package au.com.toyota.nc.webapp.stripes.dealerLocations;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSON;
import net.sourceforge.stripes.action.Before;
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

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import au.com.toyota.nc.common.AbstractNCException;
import au.com.toyota.nc.common.locations.LocationValidator;
import au.com.toyota.nc.common.locations.exceptions.AddLocationException;
import au.com.toyota.nc.common.locations.exceptions.InvalidLocationException;
import au.com.toyota.nc.common.model.CreateLocationRequest;
import au.com.toyota.nc.common.model.hibernate.AbstractContact;
import au.com.toyota.nc.common.model.hibernate.AbstractDocument;
import au.com.toyota.nc.common.model.hibernate.Dealer;
import au.com.toyota.nc.common.model.hibernate.Location;
import au.com.toyota.nc.common.model.hibernate.LocationDocument;
import au.com.toyota.nc.common.model.hibernate.LocationSharedFacility;
import au.com.toyota.nc.common.staff.exceptions.AppointmentNotFoundException;
import au.com.toyota.nc.webapp.stripes.AjaxResolution;
import au.com.toyota.nc.webapp.stripes.ext.converters.PhoneNumberConverter;

/**
 * See javadoc on {@link au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean}
 * Same explanation applies to this action bean.
 * 
 * User: Alex Wibowo
 * Date: Apr 8, 2009
 * Time: 2:41:56 PM
 */
public class ManageLocationActionBean extends BaseManageDealerLocationActionBean<LocationDocument> implements ValidationErrorHandler{
    private static final Logger LOG = Logger.getLogger(ManageLocationActionBean.class.getName());


    public static final String EVENT_DISPLAY_CREATE_NEW_LOCATION = "newLocation";
    public static final String EVENT_VIEW = "viewLocation";
    public static final String EVENT_EDIT = "editLocation";
    public static final String EVENT_VERIFY_SAP_CODE = "verifySAPCode";
    public static final String EVENT_SHOW_SUPPORT_LOCATION = "showSupportLocation";
    

    public static final String REQUEST_PARAM_LOCATION_ID = "location.locationId";

   private CreateLocationRequest createLocationRequest;

    // A hack to make Stripes invoke the newLocation() event handler
    private String  newLocation;


    private String locationSAPCode;
    private String dealerSAPCode;

    @ValidateNestedProperties({
           @Validate(field="locationName", maxlength = Location.MAX_LOCATION_NAME),
           @Validate(field="reportingName", maxlength = Location.MAX_REPORTING_NAME),
           @Validate(field="branchCode", maxlength = Location.MAX_BRANCH_CODE),
           @Validate(field="sapCode", maxlength = Location.MAX_SAP_CODE),
           @Validate(field="partsBranchCode", maxlength = Location.MAX_PARTS_BRANCH_CODE),
           @Validate(field="multisiteCode", maxlength = Location.MAX_MULTI_SIDE_CODE),
           @Validate(field="dasoDealerCode", maxlength = Location.MAX_DASO_DEALER_CODE),
           @Validate(field="dasoPartsCode", maxlength = Location.MAX_DASO_PARTS_CODE),
           @Validate(field="note", maxlength = Location.MAX_NOTE),
            /** Parts Delivery **/
           @Validate(field="partsDelivery.address", maxlength = Location.LocationDelivery.MAX_DELIVERY_ADDRESS),
           @Validate(field="partsDelivery.instructions", maxlength = Location.LocationDelivery.MAX_DELIVERY_INSTRUCTIONS),
           @Validate(field="partsDelivery.fromTime", mask = MASK_TIME, maxlength = 5),
            @Validate(field="partsDelivery.toTime", mask = MASK_TIME, maxlength = 5),
            /** Vehicles Delivery **/
           @Validate(field="vehiclesDelivery.address", maxlength = Location.LocationDelivery.MAX_DELIVERY_ADDRESS),
           @Validate(field="vehiclesDelivery.instructions", maxlength = Location.LocationDelivery.MAX_DELIVERY_INSTRUCTIONS),
           @Validate(field="vehiclesDelivery.fromTime", mask = MASK_TIME, maxlength = 5),
           @Validate(field="vehiclesDelivery.toTime", mask = MASK_TIME, maxlength = 5),
            /** Street Address **/
           @Validate(field="contact.streetAddress.address1", maxlength = AbstractContact.Address.MAX_ADDRESS1),
           @Validate(field="contact.streetAddress.address2", maxlength = AbstractContact.Address.MAX_ADDRESS2),
           @Validate(field="contact.streetAddress.suburb", maxlength = AbstractContact.Address.MAX_SUBURB),
           @Validate(field="contact.streetAddress.postCode", maxlength = AbstractContact.Address.MAX_POSTCODE),
            /** PO BOX Address **/
            @Validate(field="contact.poBoxAddress.address1", maxlength = AbstractContact.Address.MAX_POBOX_ADDRESS),
           @Validate(field="contact.poBoxAddress.address2", maxlength = AbstractContact.Address.MAX_ADDRESS2),
           @Validate(field="contact.poBoxAddress.suburb", maxlength = AbstractContact.Address.MAX_SUBURB),
           @Validate(field="contact.poBoxAddress.postCode", maxlength = AbstractContact.Address.MAX_POSTCODE),
            /** Postal Address **/
            @Validate(field="contact.postalAddress.address1", maxlength = AbstractContact.Address.MAX_ADDRESS1),
           @Validate(field="contact.postalAddress.address2", maxlength = AbstractContact.Address.MAX_ADDRESS2),
           @Validate(field="contact.postalAddress.suburb", maxlength = AbstractContact.Address.MAX_SUBURB),
           @Validate(field="contact.postalAddress.postCode", maxlength = AbstractContact.Address.MAX_POSTCODE),
            /** Contact details **/
            @Validate(field="contact.shortDial", maxlength = AbstractContact.MAX_SHORT_DIAL),
            @Validate(field="contact.regionalSpeedDial", maxlength = AbstractContact.MAX_REGIONAL_DIAL),
            @Validate(field="contact.fax", maxlength = AbstractContact.MAX_FAX, required=false, converter = PhoneNumberConverter.class),
            @Validate(field="contact.email", maxlength = AbstractContact.MAX_EMAIL),
            @Validate(field="contact.website", maxlength = AbstractContact.MAX_WEBSITE),
            @Validate(field="contact.phone", maxlength = AbstractContact.MAX_PHONE, required=false, converter = PhoneNumberConverter.class),
            @Validate(field="contact.salesEmail", maxlength = AbstractContact.MAX_EMAIL),
            @Validate(field="contact.serviceEmail", maxlength = AbstractContact.MAX_EMAIL),
            @Validate(field="contact.partsEmail", maxlength = AbstractContact.MAX_EMAIL),
            @Validate(field="contact.csEmail", maxlength = AbstractContact.MAX_EMAIL),
            @Validate(field="contact.serviceUrl", maxlength = AbstractContact.MAX_SERVICE_URL),

            /** Showroom Capacity **/
            @Validate(field="showroomCapacityInfo.area", maxlength = Location.ShowroomCapacityInfo.MAX_SHOWROOM_AREA),
            @Validate(field="showroomCapacityInfo.displayVehicles", maxlength = Location.ShowroomCapacityInfo.MAX_SHOWROOM_DISPLAY_VEHICLES),

            /** New Vehicle Capacity **/
            @Validate(field="newVehicleCapacityInfo.customerParking", maxlength = Location.NewVehicleCapacityInfo.MAX_CUSTOMER_PARKING),
            @Validate(field="newVehicleCapacityInfo.demonstratorParking", maxlength = Location.NewVehicleCapacityInfo.MAX_DEMONSTRATOR_PARKING),
            @Validate(field="newVehicleCapacityInfo.undercoverBay", maxlength = Location.NewVehicleCapacityInfo.MAX_UNDERCOVER_BAYS),
            @Validate(field="newVehicleCapacityInfo.externalDisplaySpaces", maxlength = Location.NewVehicleCapacityInfo.MAX_EXTERNAL_SPACES),
            @Validate(field="newVehicleCapacityInfo.storageArea", maxlength = Location.NewVehicleCapacityInfo.MAX_STORAGE_AREA),

            /** Used Vehicle Capacity **/
            @Validate(field="usedVehicleCapacityInfo.storageArea", maxlength = Location.UsedVehicleCapacityInfo.MAX_STORAGE_AREA),
            @Validate(field="usedVehicleCapacityInfo.externalDisplaySpaces", maxlength = Location.NewVehicleCapacityInfo.MAX_EXTERNAL_SPACES),
            @Validate(field="usedVehicleCapacityInfo.customerParking", maxlength = Location.NewVehicleCapacityInfo.MAX_CUSTOMER_PARKING),

            @Validate(field="cessationReason", maxlength = Location.MAX_CESSATION_REASON),

            /** Documents **/
            @Validate(field="document.documentName", maxlength = AbstractDocument.MAX_DOCUMENT_NAME),
            @Validate(field="document.url", maxlength = AbstractDocument.MAX_URL),

            /** Shared Facility **/
            @Validate(field="sharedFacilities.sharedOther", maxlength = LocationSharedFacility.MAX_SHARED_OTHER),

            @Validate(field="destinationCode", maxlength = Location.MAX_DESTINATION_CODE)
    })
    private Location location;

    @SpringBean
    private LocationValidator locationValidator;

    private static final Map<String, String> TAB_TO_PAGE_MAPPING  = new HashMap<String,String>();

    static {
        TAB_TO_PAGE_MAPPING.put(EVENT_SHOW_GENERAL_INFORMATION,
                LOCATION_JSP_BASE + "/generalInfo/updateGeneralInformation.jsp");
        TAB_TO_PAGE_MAPPING.put(EVENT_SHOW_TMCA_INFORMATION,
                LOCATION_JSP_BASE + "/tmcaInfo/updateTMCAInformation.jsp");
        TAB_TO_PAGE_MAPPING.put(EVENT_SHOW_STAFF_INFORMATION,
                LOCATION_JSP_BASE + "/staffInfo/show.jsp");
        TAB_TO_PAGE_MAPPING.put(EVENT_SHOW_AWARDS_INFORMATION,
                LOCATION_JSP_BASE + "/awardsInfo/updateAwardsInformation.jsp");
        TAB_TO_PAGE_MAPPING.put(EVENT_SHOW_IDENTIFICATION_NUMBERS_INFORMATION,
                LOCATION_JSP_BASE + "/identificationInfo/updateIdentificationNumbersInformation.jsp");
        TAB_TO_PAGE_MAPPING.put(EVENT_SHOW_SYSTEM_INFORMATION,
                LOCATION_JSP_BASE + "/systemInfo/updateSystemInformation.jsp");
        TAB_TO_PAGE_MAPPING.put(EVENT_SHOW_MARKETING_INFORMATION,
                LOCATION_JSP_BASE + "/marketingInfo/updateMarketingInformation.jsp");
        TAB_TO_PAGE_MAPPING.put(EVENT_SHOW_FILES_INFORMATION,
                LOCATION_JSP_BASE + "/filesInfo/updateFilesInformation.jsp");
        TAB_TO_PAGE_MAPPING.put(EVENT_SHOW_SUPPORT_LOCATION,
                LOCATION_JSP_BASE + "/supportLocation/updateServiceLocation.jsp");
    }

    protected Map<String, String> getTabToPageMapping() {
        return TAB_TO_PAGE_MAPPING;
    }

        /**
     * Perform database save/update
     *
     * @see #fetchLocation()
     * @throws Exception
     */
    protected void doSave() throws AbstractNCException{
        if (hasToSave()) {
           // Because of OSIV pattern, Hibernate's session is going to be bound to the thread. Unfortunately, the UI needs location information
            // to be separated across different screen, so we do this by fetching the location prior to Stripes binding lifecycle. (See fetchLocation() method).
            // Unfortunately (again), with OSIV, this means that the object will live in the session at the end of the fetchLocation() operation.
            // In the UI, some operations require that we attach children to the dealer, by setting the child's PK directly.  E.g.:
            // 1. fetchLocation() will fetch the parent with a child
            // 2. Stripes binding mechanism will override the child's PK with another child's PK (if we are swapping the child)
            // 3. We ask hibernate to save this new relationship.
            //
            // The problem with OSIV, is that the child on step no.1 already exist in Hibernate session (since the session is bound to the thread), and since
            // that session is not closed until the last stage (i..e exiting the filter), changing the child's ID (in step 2), will make Hibernate scream.
            // This wasnt a problem, if we are not using OSIV, because  fetchDealer() and this updateDealer() method will each open (new) hibernate session.
            // Hence, Hibernate will treat them as different object
            //
            // The hack is to clear Hibernate's session L1 cache between these two operations, so that hibernate wont recognize them as the same child.

            /**
             * <Jul 13, 2009 5:38:45 PM EST> <Error> <HTTP> <BEA-101017> <[weblogic.servlet.internal.WebAppServletContext@1477868 - appName: 'au.com.toyota.nc.nc-webapp', nam
e: 'au.com.toyota.nc.nc-webapp-VERSION', context-path: '/apps/nc'] Root cause of ServletException.
org.springframework.orm.hibernate3.HibernateSystemException: a different object with the same identifier value was already associated with the session: [au.com
.toyota.nc.common.model.hibernate.Location#1]; nested exception is org.hibernate.NonUniqueObjectException: a different object with the same identifier value wa
s already associated with the session: [au.com.toyota.nc.common.model.hibernate.Location#1]
        at org.springframework.orm.hibernate3.SessionFactoryUtils.convertHibernateAccessException(SessionFactoryUtils.java:676)
        at org.springframework.orm.hibernate3.HibernateTransactionManager.convertHibernateAccessException(HibernateTransactionManager.java:789)
        at org.springframework.orm.hibernate3.HibernateTransactionManager.doCommit(HibernateTransactionManager.java:663)
        at org.springframework.transaction.support.AbstractPlatformTransactionManager.processCommit(AbstractPlatformTransactionManager.java:732)
        at org.springframework.transaction.support.AbstractPlatformTransactionManager.commit(AbstractPlatformTransactionManager.java:701)
        Truncated. see log file for complete stacktrace
org.hibernate.NonUniqueObjectException: a different object with the same identifier value was already associated with the session: [au.com.toyota.nc.common.mod
el.hibernate.Location#1]
        at org.hibernate.engine.StatefulPersistenceContext.checkUniqueness(StatefulPersistenceContext.java:590)
        at org.hibernate.event.def.DefaultSaveOrUpdateEventListener.performUpdate(DefaultSaveOrUpdateEventListener.java:284)
        at org.hibernate.event.def.DefaultSaveOrUpdateEventListener.entityIsDetached(DefaultSaveOrUpdateEventListener.java:223)
        at org.hibernate.event.def.DefaultSaveOrUpdateEventListener.performSaveOrUpdate(DefaultSaveOrUpdateEventListener.java:89)
        at org.hibernate.event.def.DefaultSaveOrUpdateEventListener.onSaveOrUpdate(DefaultSaveOrUpdateEventListener.java:70)
        Truncated. see log file for complete stacktrace
             */
            // TODO: ideally we want to evict just the location.. but I saw   Hibernate spewing the error above. Somehow same instance of the location
            // already exist in the session, even though I've evicted this instance. So there must be another instance!
           // Turns out that the object in the session is from the dealer tree. Dealer has collection of location, and dealer sits in Hibernate session (as a result from
            // search)... :(
            dbServices.clearCache();
            location = locationTopology.update(location);
        }
    }


    /**
     *  Displays the page to create new location, depending on the location type.
     */
    @HandlesEvent(EVENT_DISPLAY_CREATE_NEW_LOCATION)
    public Resolution newLocation() throws Exception{
        LOG.info("Displaying new location creation page..");

        try {
            locationDBService.validateAddingLocationForDealer(createLocationRequest);
        } catch (AddLocationException e) {
            addSimpleGlobalError(e.getMessage());
            return context.getSourcePageResolution();
        }

        Dealer dealer = dealerDBService.fetchDealer(createLocationRequest.getDealerId());
        location = Location.createLocationForDealer(createLocationRequest.getLocationType(), dealer);

        if(createLocationRequest.getLocationType().isSupportLocation()) {
            setLastTabShown(EVENT_SHOW_SUPPORT_LOCATION);
            return new ForwardResolution(LOCATION_JSP_BASE + "/supportLocation/updateServiceLocation.jsp");
        }else{
            setLastTabShown(EVENT_SHOW_GENERAL_INFORMATION);
            return new ForwardResolution(LOCATION_JSP_BASE + "/generalInfo/updateGeneralInformation.jsp");
        }
    }

    /**
     * View Location
     */
    @HandlesEvent(EVENT_VIEW)
    public Resolution view() throws Exception{
        LOG.info(MessageFormat.format("Viewing location with id [{0}]", location.getLocationId()));
        setShowAsReadOnly(true);

        if (location.getType().isSupportLocation()) {
            return showSupportLocation();
        }else{
            return showGeneralInformation();
        }
    }

      /**
     * Edit a location. The actual location loading is done at {@link #fetchLocation()}.
     */
    @HandlesEvent(EVENT_EDIT)
    public Resolution edit()  throws Exception{
        LOG.info(MessageFormat.format("Editing location with id [{0}]", location.getLocationId()));

        if (location.getType().isSupportLocation()) {
            return showSupportLocation();
        }else{
            return showGeneralInformation();
        }
    }

    @HandlesEvent(EVENT_VERIFY_SAP_CODE)
    public Resolution verifySAPCode() {
        JSON result = sapCodeVerifier.verifySAPLocationAsJSON(dealerSAPCode, locationSAPCode);
        return new AjaxResolution(result);
    }


    //-------------------------------- TAB NAVIGATIONS -------------------------------------------
    /**
     * Show the support location information. Support location doesnt have any other tabs. So we
     * dont need to worry about saving the locatoin, since we wont need to switch between tabs.
     * 
     * @return
     */
    @HandlesEvent(EVENT_SHOW_SUPPORT_LOCATION)
    public Resolution showSupportLocation() {
        return new RedirectResolution(this.getClass(), EVENT_DISPLAY_TAB)
                .addParameters(getParametersOnTabSwitch(EVENT_SHOW_SUPPORT_LOCATION)).flash(this);
    }

    @HandlesEvent(EVENT_SCHEDULE_ACTIVATION)
    public Resolution scheduleActivation()
    {
        try
        {
            doSave();
            final Resolution resolution = new ForwardResolution(LocationActivationDeactivationActionBean.class, EVENT_SCHEDULE_ACTIVATION);
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
            final Resolution resolution = new ForwardResolution(LocationActivationDeactivationActionBean.class, EVENT_ACTIVATE);
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
            final Resolution resolution = new ForwardResolution(LocationActivationDeactivationActionBean.class, EVENT_SCHEDULE_DEACTIVATION);
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
            final Resolution resolution = new ForwardResolution(LocationActivationDeactivationActionBean.class, EVENT_DEACTIVATE);
            return resolution;
        }
        catch (AbstractNCException e)
        {
            addSimpleGlobalError(e.getMessage());
            return context.getSourcePageResolution();
        }
    }

    /**
     * We fetch the location prior to binding process, since each of the location tab only have partial information on the location,
     * and we will overwrite whatever value is passed in from the request during the binding process.
     */
    @Before(stages = LifecycleStage.BindingAndValidation)
    public void fetchLocation() {
        String locationIdStr = context.getRequest().getParameter(REQUEST_PARAM_LOCATION_ID);
        try {
            if (!StringUtils.isEmpty(locationIdStr)) {
                LOG.info(MessageFormat.format("Location ID is present as [{0}], trying to bind to action bean", locationIdStr));
                if (hasToSave()) {
                    location = locationDBService.fetchLocationAndRenewAllAssociations(Long.parseLong(locationIdStr));
                }else{
                    location = locationDBService.fetchLocation(Long.parseLong(locationIdStr));
                }
                overrideWriteAccessAsNecessary();

                /**
                 * Set the fetched location to be read only. This is because Stripes might bind invalid value to the location, which passes the Stripes validation,
                 * but will fail more complicated validation later on (involving SAP, etc). Because we bind the object here, the object will live in  Hibernate session
                 * throughout the whole request (due to OSIV). The trick is to set the object to be read only, to prevent automatic-dirty-checking by Hibernate to
                 * persist the changes on the object to the database. All save must be done explicitly by calling save.
                 */
                dbServices.setReadOnly(location);
            }
        } catch (InvalidLocationException e) {
            LOG.info(MessageFormat.format("Location ID [{0}] is not present in database", locationIdStr));
        }
    }


     public boolean isUserAllowedToMaintainEntity() {
        return locationSecurityContext.canUserMaintainLocation(location, context.getUserDetails(), context.getUserRole());
    }

    protected Object getManagedEntity() {
        return location;
    }

    /**
     * We do these validations here, instead of annotating the location property with the validate annotation, because:
     * <ul>
     *      <li> We fetch the location property prior to binding & validation lifecycle</li>
     *      <li>You might think that 'dealerName' should exist (i.e. populated) in the dealer property prior
     *     to Stripes doing the validation</li>
     *      <li> This is not the case. Stripes validation works against the request parameter, and not the bean property. So even though
     *     the bean is populated (via interception), the parameters wont always contain the location's name (e.g. if
     *     we navigate from TMCA tab)</li>
     *     <li>With custom validation, on the other hand,  is done after the binding lifecycle. So we can be sure if the incoming request
     *      has overriden any of the location property.</li>
     * </ul>
     *
     * @see net.sourceforge.stripes.controller.DefaultActionBeanPropertyBinder#bind(net.sourceforge.stripes.action.ActionBean, net.sourceforge.stripes.action.ActionBeanContext, boolean)
     * @see net.sourceforge.stripes.controller.DefaultActionBeanPropertyBinder#validateRequiredFields(java.util.Map, net.sourceforge.stripes.action.ActionBean, net.sourceforge.stripes.validation.ValidationErrors)
     */
    @ValidationMethod(on={
            EVENT_SHOW_GENERAL_INFORMATION, EVENT_SHOW_TMCA_INFORMATION, EVENT_SHOW_LEGAL_INFORMATION, EVENT_SHOW_STAFF_INFORMATION,  
            EVENT_SHOW_AWARDS_INFORMATION, EVENT_SHOW_IDENTIFICATION_NUMBERS_INFORMATION,
            EVENT_SHOW_SYSTEM_INFORMATION, EVENT_SHOW_MARKETING_INFORMATION,  EVENT_SHOW_FILES_INFORMATION,
            EVENT_SAVE
    })
    public void ensureLocationNameExists() {
        LOG.info("Validating location name");
        if (StringUtils.isBlank(this.location.getLocationName())) {
            addLocalizableValidationError("location.locationName","validation.required.valueNotPresent");
        }
    }

/*
  TODO: confirm that this is no longer needed, after we set the readonly on the location
   @After(stages = LifecycleStage.CustomValidation)
    public void interceptErrorCustomValidation() {
        if (!context.getValidationErrors().isEmpty()) {
            // On validation error, we want to clear the cache, since the object might be 'half baked', and we dont want that to happen! Otherwise
            // hibernate will complain with all the restrictions..
            dbServices.evictObject(location);
        }
    }*/

    protected Map<String, Object> getParametersOnTabSwitch(String lastTabShown){
          Map<String, Object> params = new HashMap<String, Object>();
        params.put(REQUEST_LAST_TAB_SHOWN, lastTabShown);
        params.put(REQUEST_READ_ONLY_MODE, getShowAsReadOnly());
        params.put(REQUEST_PARAM_LOCATION_ID, location.getLocationId());
        return params;
    }

    public CreateLocationRequest getCreateLocationRequest() {
        return createLocationRequest;
    }

    public void setCreateLocationRequest(CreateLocationRequest createLocationRequest) {
        this.createLocationRequest = createLocationRequest;
    }

    public String getNewLocation() {
        return newLocation;
    }

    public void setNewLocation(String newLocation) {
        this.newLocation = newLocation;
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

     protected Object getDocumentOwner() {
        return getLocation();
    }

    public String getLocationSAPCode() {
        return locationSAPCode;
    }

    public void setLocationSAPCode(String locationSAPCode) {
        this.locationSAPCode = locationSAPCode;
    }

    public String getDealerSAPCode() {
        return dealerSAPCode;
    }

    public void setDealerSAPCode(String dealerSAPCode) {
        this.dealerSAPCode = dealerSAPCode;
    }

    protected void documentUploadValidationFailedCallback() throws Exception {
        location = locationDBService.fetchLocationAndRenewAllAssociations(location.getLocationId());
    }

    public Resolution handleValidationErrors(ValidationErrors errors) throws Exception {
        if (context.isInAnyEvents(EVENT_UPLOAD_DOCUMENT)) {
            LOG.debug("Validation error while performing location document upload");
            documentUploadValidationFailedCallback();
        }
        return context.getSourcePageResolution();
    }

    public boolean getUserSharesSameDealerAsLocation() throws AppointmentNotFoundException
    {
        final Dealer loggedInUsersDealer = getLoggedInUsersAppointment().getDealer();
        return getLocation().getDealer().equals(loggedInUsersDealer);
    }
    
    /**
     * Get the actual username from the toyota LDAP using the T/K number or the dealer name.  
     * @return The actual name from e-Dir
     */
    public String getLastMaintainedUserNameFromLDAP() {
    	return getLastMaintainedUserName(location);
    }

}
