package au.com.toyota.nc.webapp.stripes.dealerLocations;

import au.com.toyota.nc.common.AbstractNCException;
import au.com.toyota.nc.common.model.hibernate.AbstractDocument;
import au.com.toyota.nc.common.model.hibernate.DocumentType;
import au.com.toyota.nc.common.security.dealer.ManageDealerSecurityContext;
import au.com.toyota.nc.common.security.location.ManageLocationSecurityContext;
import au.com.toyota.nc.webapp.dataproxy.SAPCodeVerifier;
import net.sourceforge.stripes.action.FileBean;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.validation.ValidationErrorHandler;
import net.sourceforge.stripes.validation.ValidationMethod;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.text.MessageFormat;
import java.util.Date;
import java.util.Map;

/**
 * User: Alex Wibowo
 * Date: 3/02/2009
 * Time: 10:08:47
 */
public abstract class BaseManageDealerLocationActionBean<M extends AbstractDocument> extends BaseDealerLocationActionBean implements ValidationErrorHandler {
    private static final Logger LOG = Logger.getLogger(BaseManageDealerLocationActionBean.class.getName());

    public static final String EVENT_SAVE = "save";
    public static final String EVENT_DISPLAY_TAB = "displayTab";

    public static final String EVENT_SHOW_GENERAL_INFORMATION = "showGeneralInformation";
    public static final String EVENT_SHOW_TMCA_INFORMATION = "showTMCAInformation";
    public static final String EVENT_SHOW_STAFF_INFORMATION = "showStaffInformation";
    public static final String EVENT_SHOW_LEGAL_INFORMATION = "showLegalInformation";
    public static final String EVENT_SHOW_AWARDS_INFORMATION = "showAwardsInformation";
    public static final String EVENT_SHOW_IDENTIFICATION_NUMBERS_INFORMATION = "showIdNoInformation";
    public static final String EVENT_SHOW_SYSTEM_INFORMATION = "showSystemInformation";
    public static final String EVENT_SHOW_MARKETING_INFORMATION = "showMarketingInformation";
    public static final String EVENT_SHOW_FILES_INFORMATION = "showFilesInformation";
    public static final String EVENT_SHOW_LOCATION_INFORMATION = "showLocationInformation";

    public static final String EVENT_UPLOAD_DOCUMENT = "upload";
    public static final String EVENT_REMOVE_DOCUMENT = "removeDocument";
    public static final String EVENT_RETRIEVE_DOCUMENT = "retrieveDocument";



    private static final String[] CHANGE_TAB_EVENTS =
            new String[]{
                    EVENT_SHOW_GENERAL_INFORMATION, EVENT_SHOW_TMCA_INFORMATION, EVENT_SHOW_LEGAL_INFORMATION, EVENT_SHOW_STAFF_INFORMATION,
                    EVENT_SHOW_AWARDS_INFORMATION, EVENT_SHOW_IDENTIFICATION_NUMBERS_INFORMATION,EVENT_SHOW_SYSTEM_INFORMATION,
                    EVENT_SHOW_MARKETING_INFORMATION, EVENT_SHOW_FILES_INFORMATION, EVENT_SHOW_LOCATION_INFORMATION
            };

    public static final String REQUEST_LAST_TAB_SHOWN = "lastTabShown";
    public static final String REQUEST_READ_ONLY_MODE= "showAsReadOnly";

    protected String lastTabShown;


    protected M document;
    protected FileBean file;


    // A hack to make Stripes invoke the upload() event handler
    protected String upload;


    @SpringBean
    protected SAPCodeVerifier sapCodeVerifier;

    @SpringBean
    protected ManageDealerSecurityContext dealerSecurityContext;

    @SpringBean
    protected ManageLocationSecurityContext locationSecurityContext;


    public String getLastTabShown() {
          return lastTabShown;
      }

    /**
     * @param tab tab name
     * @return <code>true</code> if the last tab shown is equal to the parameter, <code>false</code> otherwise
     */
    protected boolean  isLastTabShown(String tab) {
        return tab.equals(getLastTabShown());
    }

      public void setLastTabShown(String lastTabShown) {
          this.lastTabShown = lastTabShown;
      }


    protected boolean isReadOnly(){
        return Boolean.TRUE.equals(getShowAsReadOnly());
    }

     /**
     * Decide whether or not save operation is to be performed. Save is to be performed when editing  (i.e. not in read-only mode),
     * and on either change tab event, or save event.
     *
     * @return whether or not database save is to be performed
     */
    protected  boolean hasToSave(){
        return !showAsReadOnly && (userSwitchBetweenTabs() || userPerformSave() || changingStatus());
    }

    private boolean changingStatus()
    {
        return context.isInAnyEvents(CHANGE_STATUS_EVENTS);
    }

    /**
     * Check if user is switching between tabs
     * @return <code>true</code> if user has just switched between tabs, <code>false</code> otherwise
     */
    protected boolean userSwitchBetweenTabs() {
        return context.isInAnyEvents(CHANGE_TAB_EVENTS);
    }

    /**
     * Check if user has performed save operation
     * @return <code>true</code> if user has just performed save operation, <code>false</code> otherwise
     */
    protected boolean userPerformSave(){
        return   EVENT_SAVE.equals(context.getEventName());
    }

    /**
     * Get the parameters that need to be passed on during tab switch
     * @param lastTabShown the destination tab
     * @return mapping of parameters that need to be passed during tab switch
     */
    protected abstract Map<String, Object> getParametersOnTabSwitch(String lastTabShown);

    /**
     * @return mapping from tab name to page location
     */
    protected abstract Map<String,String> getTabToPageMapping();

   /**
     * Perform database save/update
     *
     * @throws AbstractNCException exception thrown during the saving
     */
    protected abstract void doSave()throws AbstractNCException;


    /**
     * Check if the logged in user is allowed to do maintenance on the entity being maintained.
     * i.e. if user is allowed to do update.
     * @return <code>true</code> if user is allowed to maintain entity, <code>false</code> otherwise
     */
    protected abstract boolean isUserAllowedToMaintainEntity();


    /**
     * Some users can only maintain certain dealer/location. E.g. regional users can only do dealer/location maintenance for
     * the same region that he's allocated to. This interception is to override the non-readony attempt to maintain
     * those dealers/location.
     * The attempt might be for various reason:
     * <ul>
     *      <li>User trying to bind 'showAsReadOnly' as false in the URL </li>
     *      <li>
     *             User tries to view the dealer/location from 'manage'  dealer/location. (normal situation), where
     *            searching doesnt really restrict the dealer/location from being returned as search result, but we should
     *            override the  'write' mode to 'view' mode
     *      </li>
     * </ul>
     */
    protected  void overrideWriteAccessAsNecessary() {
        if (getManagedEntity() != null && !showAsReadOnly) {
            LOG.debug(MessageFormat.format("ShowAsReadOnly has been flagged as 'false'. Checking if logged in user really has edit access to the entity [{0}] being managed.", getManagedEntity()));
            setShowAsReadOnly(!isUserAllowedToMaintainEntity());
        }
    }

    /**
     * @return the entity being managed, either a dealer / location instance
     */
    protected abstract Object getManagedEntity();


    /**
     * Save the current editing dealer/location. After saving, we redirect to the last tab shown.
     *
     * @return Resolution to the last tab being shown prior to this event
     */
    @HandlesEvent(EVENT_SAVE)
    public Resolution save(){
        LOG.info("Saving..");
        try {
            doSave();
            return new RedirectResolution(this.getClass(), EVENT_DISPLAY_TAB)
                    .addParameters(getParametersOnTabSwitch(getLastTabShown()));
        } catch (AbstractNCException e) {
            addSimpleGlobalError(e.getMessage());
            return context.getSourcePageResolution();
        }
    }

    /**
     * Remove document with the given id
     */
    @HandlesEvent(EVENT_REMOVE_DOCUMENT)
    public Resolution removeDocument(){
        LOG.info(MessageFormat.format("Deleting document with id [{0}]", document.getDocumentId()));
        documentServices.deleteDocument(document.getDocumentId());
        return new RedirectResolution(this.getClass(), EVENT_SHOW_FILES_INFORMATION)
                .addParameters(getParametersOnTabSwitch(getLastTabShown()));
    }

    /**
     * @return {@link DocumentStreamingResolution} for document with the given id
     */
    @HandlesEvent(EVENT_RETRIEVE_DOCUMENT)
    public Resolution retrieveDocument() throws IOException, SQLException {
        LOG.info(MessageFormat.format("Retrieving document with id [{0}]", document.getDocumentId()));
        AbstractDocument abstractDocument = documentServices.getDocument(document.getDocumentId());
        return new DocumentStreamingResolution(abstractDocument, abstractDocument.getFile().getBinaryStream());
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



    //-------------------------------- TAB NAVIGATIONS -------------------------------------------
    @HandlesEvent(EVENT_SHOW_GENERAL_INFORMATION)
    public Resolution showGeneralInformation(){
            return new RedirectResolution(this.getClass(), EVENT_DISPLAY_TAB)
                    .addParameters(getParametersOnTabSwitch(EVENT_SHOW_GENERAL_INFORMATION));
    }

    @HandlesEvent(EVENT_SHOW_TMCA_INFORMATION)
    public Resolution showTMCAInformation(){
            return new RedirectResolution(this.getClass(), EVENT_DISPLAY_TAB)
                    .addParameters(getParametersOnTabSwitch(EVENT_SHOW_TMCA_INFORMATION));
    }

    @HandlesEvent(EVENT_SHOW_LEGAL_INFORMATION)
    public Resolution showLegalInformation(){
            return new RedirectResolution(this.getClass(), EVENT_DISPLAY_TAB)
                    .addParameters(getParametersOnTabSwitch(EVENT_SHOW_LEGAL_INFORMATION));
    }

    @HandlesEvent(EVENT_SHOW_STAFF_INFORMATION)
    public Resolution showStaffInformation(){
            return new RedirectResolution(this.getClass(), EVENT_DISPLAY_TAB)
                    .addParameters(getParametersOnTabSwitch(EVENT_SHOW_STAFF_INFORMATION));
    }

    @HandlesEvent(EVENT_SHOW_AWARDS_INFORMATION)
    public Resolution showAwardsInformation(){
            return new RedirectResolution(this.getClass(), EVENT_DISPLAY_TAB)
                    .addParameters(getParametersOnTabSwitch(EVENT_SHOW_AWARDS_INFORMATION));
    }

    @HandlesEvent(EVENT_SHOW_IDENTIFICATION_NUMBERS_INFORMATION)
    public Resolution showIdentificationNumbersInformation(){
            return new RedirectResolution(this.getClass(), EVENT_DISPLAY_TAB)
                    .addParameters(getParametersOnTabSwitch(EVENT_SHOW_IDENTIFICATION_NUMBERS_INFORMATION));
    }

    //---------------------------- DOCUMENT FUNCTIONS -----------------------------------------------------
    /**
     * Upload document
     */
    @HandlesEvent(EVENT_UPLOAD_DOCUMENT)
    public Resolution upload() throws IOException {
        LOG.info("Uploading new document");

        InputStream is = null;
        if (DocumentType.FILE.equals(document.getDocumentType())) {
            is = file.getInputStream();
            document.setFile(is);
            document.setFileName(file.getFileName());
            document.setFileContentType(file.getContentType());
        }

        document.setOwner(getDocumentOwner());
        documentServices.saveDocument(document);

        // Note that these operations (close / delete) has to be performed after the service call, otherwise you'll get Io read error (inputstream already closed!)
        if (is != null) {
            is.close();
        }
        if (file!=null){
            file.delete();
        }

        return new RedirectResolution(this.getClass(), EVENT_SHOW_FILES_INFORMATION)
                .addParameters(getParametersOnTabSwitch(getLastTabShown()));
    }

    @HandlesEvent(EVENT_SHOW_SYSTEM_INFORMATION)
    public Resolution showSystemInformation(){
            return new RedirectResolution(this.getClass(), EVENT_DISPLAY_TAB)
                    .addParameters(getParametersOnTabSwitch(EVENT_SHOW_SYSTEM_INFORMATION));
    }

    @HandlesEvent(EVENT_SHOW_MARKETING_INFORMATION)
    public Resolution showMarketingInformation(){
            return new RedirectResolution(this.getClass(), EVENT_DISPLAY_TAB)
                    .addParameters(getParametersOnTabSwitch(EVENT_SHOW_MARKETING_INFORMATION));
    }

    @HandlesEvent(EVENT_SHOW_FILES_INFORMATION)
    public Resolution showFilesInformation(){
            return new RedirectResolution(this.getClass(), EVENT_DISPLAY_TAB)
                    .addParameters(getParametersOnTabSwitch(EVENT_SHOW_FILES_INFORMATION));
    }

    @HandlesEvent(EVENT_SHOW_LOCATION_INFORMATION)
    public Resolution showLocationinformation(){
            return new RedirectResolution(this.getClass(), EVENT_DISPLAY_TAB)
                    .addParameters(getParametersOnTabSwitch(EVENT_SHOW_LOCATION_INFORMATION));
    }

    @HandlesEvent(EVENT_DISPLAY_TAB)
    public Resolution displayTab() {
        String lastTabShown = context.getRequest().getParameter(REQUEST_LAST_TAB_SHOWN);
        setLastTabShown(lastTabShown);

        // This serves as a guard against user setting 'showAsReadOnly'.
        overrideWriteAccessAsNecessary();

        return new ForwardResolution(getTabToPageMapping().get(lastTabShown));
    }

      /**
     * Validation on uploading document
     */
    @ValidationMethod(on={EVENT_UPLOAD_DOCUMENT})
    public void validateFileUpload() throws Exception {
        LOG.debug("Validating document upload");

        if (StringUtils.isEmpty(document.getDocumentName())) {
            addLocalizableValidationError("document.documentName","validation.required.valueNotPresent");
        }

      if (DocumentType.FILE.equals(document.getDocumentType())) {
            if (file == null) {
                addLocalizableValidationError("file", "validation.required.valueNotPresent");
            }
        }else if (DocumentType.URL.equals(document.getDocumentType())) {
            if (StringUtils.isEmpty(document.getUrl())) {
                addLocalizableValidationError("document.url", "validation.required.valueNotPresent");
            }
        }
    }


    public FileBean getFile() {
        return file;
    }

    public void setFile(FileBean file) {
        this.file = file;
    }

     public String getUpload() {
        return upload;
    }

    public void setUpload(String upload) {
        this.upload = upload;
    }

    public M getDocument() {
        return document;
    }

    public void setDocument(M document) {
        this.document = document;
    }

    /**
     * Called on error during file upload validation
     * @throws Exception
     */
    protected abstract void documentUploadValidationFailedCallback() throws Exception;

    /**
     * Get the document owner, on document upload
     * @return
     */
    protected abstract Object  getDocumentOwner();
}
