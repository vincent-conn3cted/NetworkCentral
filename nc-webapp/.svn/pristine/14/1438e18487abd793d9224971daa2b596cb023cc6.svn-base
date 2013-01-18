package au.com.toyota.nc.webapp.dataproxy.impl;

import au.com.toyota.nc.common.model.hibernate.Location;
import au.com.toyota.nc.webapp.dataproxy.AutoSuggestionResolutionFactory;
import au.com.toyota.nc.webapp.stripes.AjaxResolution;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sourceforge.stripes.action.Resolution;
import static org.apache.commons.lang.StringUtils.isBlank;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import java.text.MessageFormat;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Component
public class AutoSuggestionJsonResolutionFactory implements AutoSuggestionResolutionFactory
{
    private static final Logger LOG = Logger.getLogger(AutoSuggestionJsonResolutionFactory.class);
    private static final String PROPERTY_RESULT = "Result";
    private static final String PROPERTY_DEALER_NAME = "dealerName";
    private static final String PROPERTY_LOCATION_NAME = "locationName";

    public Resolution resolveDealerNameSuggestions(List<Location> locations)
    {
        LOG.info(MessageFormat.format("Attempting to construct JSON for [{0}] dealerNames names", locations.size()));
        final Set<String> alreadyFoundNames = new HashSet<String>();
        JSONObject result = new JSONObject();
        JSONArray arrays = new JSONArray();
        for (Location location : locations)
        {
            final String dealerName = location.getDealer().getGeneralInfo().getDealerName();
            LOG.debug(MessageFormat.format("Checking if dealer name [{0}] should be included", dealerName));
            if (!alreadyFoundNames.contains(dealerName))
            {
                LOG.debug(MessageFormat.format("Found that dealer name [{0}] is not added. Adding now", dealerName));
                JSONObject jsonObject = new JSONObject();
                jsonObject.put(PROPERTY_DEALER_NAME, dealerName);
                arrays.put(jsonObject);
                alreadyFoundNames.add(dealerName);
            }
        }
        result.put(PROPERTY_RESULT, arrays);
        return new AjaxResolution(result);
    }

    public Resolution resolveLocationNameSuggestions(List<Location> locations)
    {
        LOG.info(MessageFormat.format("Attempting to construct JSON for [{0}] location names", locations.size()));
        final Set<String> alreadyFoundNames = new HashSet<String>();
        JSONObject result = new JSONObject();
        JSONArray arrays = new JSONArray();
        for (Location location : locations)
        {
            final String locationName = location.getLocationName();
            LOG.debug(MessageFormat.format("Checking if location name [{0}] should be included", locationName));
            if (!alreadyFoundNames.contains(locationName) && !isBlank(locationName))
            {
                LOG.debug(MessageFormat.format("Location name [{0}] is not blank and hasnt already been added. Adding now!", locationName));
                JSONObject jsonObject = new JSONObject();
                jsonObject.put(PROPERTY_LOCATION_NAME, locationName);
                arrays.put(jsonObject);
                alreadyFoundNames.add(locationName);
            }
        }
        result.put(PROPERTY_RESULT, arrays);
        return new AjaxResolution(result);
    }
}
