package au.com.toyota.nc.webapp.stripes.ext.converters;

import java.util.Collection;
import java.util.Locale;

import au.com.toyota.nc.common.model.hibernate.LocationType;
import au.com.toyota.nc.common.model.search.CommaSeperatedLocationTypeSearchOption;
import au.com.toyota.nc.common.model.search.LocationTypeSearchOption;
import net.sourceforge.stripes.validation.TypeConverter;
import net.sourceforge.stripes.validation.ValidationError;
import org.apache.commons.lang.StringUtils;

public class LocationTypeSearchOptionsTypeConverter implements TypeConverter<LocationTypeSearchOption>
{
    public void setLocale(Locale locale)
    {
        // Do nothing.  This doesn't use locales.
    }

    public LocationTypeSearchOption convert(String formVal, Class<? extends LocationTypeSearchOption> targetClass, Collection<ValidationError> errors)
    {
        final String[] locationTypeNames = StringUtils.split(formVal, ",");
        LocationType[] locationTypes = new LocationType[locationTypeNames.length];
        for (int i = 0; i < locationTypeNames.length; i++)
        {
            String name = locationTypeNames[i];
            locationTypes[i] = LocationType.valueOf(name);
        }
        return new CommaSeperatedLocationTypeSearchOption(locationTypes);
    }
}