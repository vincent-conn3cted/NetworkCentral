package au.com.toyota.nc.webapp.savedsearch;

import au.com.toyota.nc.common.savedsearch.SavedSearchParameter;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface SavedSearchParameterFactory
{
    public List<SavedSearchParameter> createSavedSearchParameters(HttpServletRequest request);
}
