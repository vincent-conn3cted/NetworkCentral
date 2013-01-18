package au.com.toyota.nc.webapp.savedsearch.impl;

import au.com.toyota.nc.common.savedsearch.SavedSearchParameter;
import au.com.toyota.nc.webapp.savedsearch.SavedSearchParameterFactory;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Component
public class SavedSearchParameterFactoryImpl implements SavedSearchParameterFactory
{
    public List<SavedSearchParameter> createSavedSearchParameters(HttpServletRequest request)
    {
        final List<SavedSearchParameter> parameters = new ArrayList<SavedSearchParameter>();
        for (Map.Entry entry : (Set<Map.Entry>) request.getParameterMap().entrySet())
        {
            final String key = entry.getKey().toString();
            if (isKeyValid(key))
            {
                parameters.addAll(createParametersFromKey(entry, key));
            }
        }
        return parameters;
    }

    private List<SavedSearchParameter> createParametersFromKey(Map.Entry entry, String key)
    {
        List<SavedSearchParameter> parameters = new ArrayList<SavedSearchParameter>();
        final String[] values = (String[]) entry.getValue();
        for (String value : values)
        {
            if (isValueValid(value))
            {
                final SavedSearchParameter param = new SavedSearchParameter(key, value);
                parameters.add(param);
            }
        }
        return parameters;
    }

    private boolean isKeyValid(String key)
    {
        return !key.startsWith("_");
    }

    private boolean isValueValid(String value)
    {
        return !StringUtils.isBlank(value);
    }
}
