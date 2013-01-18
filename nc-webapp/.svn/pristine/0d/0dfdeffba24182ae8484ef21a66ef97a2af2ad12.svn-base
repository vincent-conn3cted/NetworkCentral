package au.com.toyota.nc.webapp.stripes.savedsearch;

import au.com.toyota.nc.common.savedsearch.SavedSearch;
import au.com.toyota.nc.common.savedsearch.SavedSearchParameter;
import au.com.toyota.nc.common.savedsearch.SavedSearchRegistry;
import au.com.toyota.nc.common.savedsearch.exceptions.SavedSearchRegistrationException;
import au.com.toyota.nc.webapp.savedsearch.SavedSearchParameterFactory;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;
import au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean;
import au.com.toyota.nc.webapp.stripes.staff.DealerStaffSearchActionBean;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidateNestedProperties;

import java.util.List;

public class SaveSearchActionBean extends BaseActionBean
{
    @SpringBean
    private SavedSearchRegistry savedSearchRegistry;

    @SpringBean
    private SavedSearchParameterFactory savedSearchParameterFactory;

    @ValidateNestedProperties(
            @Validate(field = "name", required = true, on = {"saveLocationSaveSearchLabel", "saveStaffSaveSearchLabel", "overwriteLocationSaveSearchLabel"})
    )
    private SavedSearch savedSearch;

    @HandlesEvent("showLocationSaveSearchLabel")
    public Resolution showLocationSaveSearchLabel()
    {
        return new ForwardResolution(JSP_BASE + "/savedsearch/locationSaveSearchLabel.jsp");
    }

    @HandlesEvent("showStaffSaveSearchLabel")
    public Resolution showStaffSaveSearchLabel()
    {
        return new ForwardResolution(JSP_BASE + "/savedsearch/staffSaveSearchLabel.jsp");
    }

    @HandlesEvent("saveLocationSaveSearchLabel")
    public Resolution saveLocationSaveSearchLabel()
    {
        return doSaveSearchLabel("saveSearchSuccess.jsp", "locationSaveSearchOverwrite.jsp");
    }

    @HandlesEvent("saveStaffSaveSearchLabel")
    public Resolution saveStaffSaveSearchLabel()
    {
        return doSaveSearchLabel("saveSearchSuccess.jsp", "staffSaveSearchOverwrite.jsp");
    }

    @HandlesEvent("overwriteLocationSaveSearchLabel")
    public Resolution overwriteLocationSaveSearchLabel()
    {
        addSearchParameters();
        savedSearchRegistry.update(savedSearch, getContext().getLoginId());
        return new ForwardResolution(JSP_BASE + "/savedsearch/saveSearchSuccess.jsp");
    }

    @HandlesEvent("deleteSavedLocationSearch")
    public Resolution deleteSavedLocationSearch()
    {
        savedSearchRegistry.delete(getSavedSearch().getSavedSearchId());
        return new RedirectResolution(ManageDealerLocationActionBean.class, "displaySavedSearches");
    }

    @HandlesEvent("deleteSavedDealerStaffSearch")
    public Resolution deleteSavedDealerStaffSearch()
    {
        savedSearchRegistry.delete(getSavedSearch().getSavedSearchId());
        return new RedirectResolution(DealerStaffSearchActionBean.class, "displaySavedSearches");
    }

    private Resolution doSaveSearchLabel(final String successPage, final String overwritePage)
    {
        try
        {
            addSearchParameters();
            savedSearchRegistry.create(savedSearch, getContext().getLoginId());
            return new ForwardResolution(JSP_BASE + "/savedsearch/" + successPage);
        }
        catch (SavedSearchRegistrationException e)
        {
            addSimpleGlobalError(e.getMessage());
            return new ForwardResolution(JSP_BASE + "/savedsearch/" + overwritePage);
        }
    }

    private void addSearchParameters()
    {
        final List<SavedSearchParameter> searchParameters = savedSearchParameterFactory.createSavedSearchParameters(getContext().getRequest());
        for (SavedSearchParameter searchParameter : searchParameters)
        {
            savedSearch.addParameter(searchParameter);
        }
    }

    public SavedSearch getSavedSearch()
    {
        return savedSearch;
    }

    public void setSavedSearch(SavedSearch savedSearch)
    {
        this.savedSearch = savedSearch;
    }
}
