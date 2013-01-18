package au.com.toyota.nc.webapp.stripes.dealerLocations;

import au.com.toyota.nc.common.model.DealerLocationSearchRequest;
import au.com.toyota.nc.common.model.hibernate.Location;
import au.com.toyota.nc.webapp.dataproxy.AutoSuggestionResolutionFactory;
import net.sourceforge.stripes.action.Before;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.controller.LifecycleStage;
import net.sourceforge.stripes.integration.spring.SpringBean;

import java.util.List;

public class SearchDealerLocationActionBean extends BaseDealerLocationActionBean
{
    public static final String EVENT_SEARCH_DEALER_NAME = "searchDealerName";
    public static final String EVENT_SEARCH_LOCATION_NAME = "searchLocationName";

    @SpringBean
    private AutoSuggestionResolutionFactory autoSuggestionResolutionFactory;

    private DealerLocationSearchRequest request;

    @HandlesEvent(EVENT_SEARCH_DEALER_NAME)
    public Resolution ajaxSearchDealerName()
    {
        final List<Location> locations = locationDealerSearchService.findLocationForRole(request, context.getUserRole());
        return autoSuggestionResolutionFactory.resolveDealerNameSuggestions(locations);
    }

    @HandlesEvent(EVENT_SEARCH_LOCATION_NAME)
    public Resolution ajaxSearchLocationName()
    {
        final List<Location> locations = locationDealerSearchService.findLocationForRole(request, context.getUserRole());
        return autoSuggestionResolutionFactory.resolveLocationNameSuggestions(locations);
    }

    @Before(stages = LifecycleStage.EventHandling)
    public void ensureAllowedStatusSearchParametersSet()
    {
        request.setDealerStatus(getAllowedStatusSearchParameter());
        request.setLocationStatus(getAllowedStatusSearchParameter());
    }

    public DealerLocationSearchRequest getRequest()
    {
        return request;
    }

    public void setRequest(DealerLocationSearchRequest request)
    {
        this.request = request;
    }

}
