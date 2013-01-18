package au.com.toyota.nc.webapp.stripes.dealerLocations;

import au.com.toyota.nc.common.dealers.exceptions.DealerBulkUpdateException;
import au.com.toyota.nc.common.dealers.exceptions.InvalidDealerException;
import au.com.toyota.nc.common.model.DealerBulkUpdateRequest;
import au.com.toyota.nc.common.model.hibernate.Dealer;
import au.com.toyota.nc.common.model.hibernate.ToyotaFranchise;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidateNestedProperties;
import net.sourceforge.stripes.validation.ValidationErrorHandler;
import net.sourceforge.stripes.validation.ValidationErrors;
import net.sourceforge.stripes.validation.ValidationMethod;
import org.apache.log4j.Logger;

import java.util.Collection;
import java.util.List;

/**
 * Stripes action bean for performing bulk dealer update
 *
 * Date: Jun 14, 2009
 * Time: 12:36:55 PM
 *
 * @author Alex Wibowo
 */
public class DealerBulkUpdateActionBean extends BaseDealerLocationActionBean implements ValidationErrorHandler{
    private static final Logger LOG = Logger.getLogger(DealerBulkUpdateActionBean.class.getName());
    public static final String EVENT_DISPLAY_FORM = "displayBulkUpdateForm";
    public static final String EVENT_UPDATE = "performBulkUpdate";

    @ValidateNestedProperties({
            @Validate(field="selectedId",required = true),
            @Validate(field="sampleDealer.generalInfo.salesDistrict", maxlength = Dealer.GeneralInfo.MAX_SALES_DISTRICT),
            @Validate(field="sampleDealer.generalInfo.operationDistrict", maxlength = Dealer.GeneralInfo.MAX_OPERATION_DISTRICT),
            @Validate(field="sampleDealer.generalInfo.serviceDistrict", maxlength = Dealer.GeneralInfo.MAX_SERVICE_DISTRICT),
            @Validate(field="sampleDealer.awards.yearWon", mask = MASK_YEAR_ONLY)
    })
    private DealerBulkUpdateRequest request;

    private List<Dealer> dealersToBeUpdated;

    private boolean showToyotaWeightGroups;

    private boolean showLexusWeightGroups;
    
    /**
     * Display the form for performing dealer bulk update
     *
     * @return
     */
    @DefaultHandler
    @HandlesEvent(EVENT_DISPLAY_FORM)
    public Resolution displayBulkUpdateForm() throws InvalidDealerException {
        LOG.info("Displaying bulk update form");
        fetchDealersForBulkUpdate();
        return new ForwardResolution(DEALER_JSP_BASE + "/dealerBulkUpdate.jsp");
    }

    /**
     * Perform the bulk update
     */
    @HandlesEvent(EVENT_UPDATE)
    public Resolution performBulkUpdate() throws InvalidDealerException {
        try {
            dealerTopology.bulkUpdate(request);
            addLocalizableGlobalMessage("message.save.success");
            // we do a flash here, so that search parameter is retained after bulk update (i..e displayed in the page)
            return getRedirectResolutionForIds(request.getUniqueDealerIds()).flash(this);
        } catch (DealerBulkUpdateException e) {
            fetchDealersForBulkUpdate();
            addSimpleGlobalError(e.getMessage());
            return context.getSourcePageResolution();
        }
    }
    
    /**
     * Displays the confirmation pop up. 
     */
    @HandlesEvent("showConfirmation")
    public Resolution showConfirmation() throws InvalidDealerException {
    	setShowConfirmation(true);
    	return displayBulkUpdateForm();
    }


    /**
     * @param ids dealer IDs
     * @return RedirectResolution to this action bean, for the page to display bulk update form
     */
    public static RedirectResolution getRedirectResolutionForIds(Collection<Long> ids) {
        RedirectResolution redirectResolution = new RedirectResolution(DealerBulkUpdateActionBean.class);
        int counter=0;
        for (Long id: ids) {
            redirectResolution.addParameter("request.selectedId[" + counter + "]", id);
            counter++;
        }
        return redirectResolution;
    }


    public List<Dealer> getDealersToBeUpdated() {
        return dealersToBeUpdated;
    }

    public void setDealersToBeUpdated(List<Dealer> dealersToBeUpdated) {
        this.dealersToBeUpdated = dealersToBeUpdated;
    }

    public DealerBulkUpdateRequest getRequest() {
        return request;
    }

    public void setRequest(DealerBulkUpdateRequest request) {                                
        this.request = request;
    }


    private void fetchDealersForBulkUpdate() throws InvalidDealerException{
        if (request != null && !request.getUniqueDealerIds().isEmpty()) {
            LOG.debug("Fetching dealers for bulk update");
            dealersToBeUpdated = dealerDBService.fetchDealers(request.getUniqueDealerIds());
            for (Dealer dealer : dealersToBeUpdated) {
                if (ToyotaFranchise.Toyota.equals(dealer.getGeneralInfo().getMainFranchise())) {
                    showToyotaWeightGroups=true;
                }
                if (ToyotaFranchise.Lexus.equals(dealer.getGeneralInfo().getMainFranchise())) {
                    showLexusWeightGroups=true;
                }
            }
            LOG.debug("Finished fetching dealers for bulk update");
        }
    }

    @ValidationMethod(on = EVENT_UPDATE)
    public void validateForBulkUpdateParameters() {
        if (request == null || request.getSampleDealer() == null) {
            LOG.debug("Validation failed for bulk update. Parameters for bulk update were not provided.");
           addSimpleGlobalError(DealerBulkUpdateException.missingParameter().getMessage());
        }
    } 

    public Resolution handleValidationErrors(ValidationErrors errors) throws Exception {
        fetchDealersForBulkUpdate();
        return context.getSourcePageResolution();
    }

    public boolean isShowToyotaWeightGroups() {
        return showToyotaWeightGroups;
    }

    public boolean isShowLexusWeightGroups() {
        return showLexusWeightGroups;
    }
}
