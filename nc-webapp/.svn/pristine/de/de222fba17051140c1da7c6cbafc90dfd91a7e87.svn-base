package au.com.toyota.nc.webapp.stripes.ext.converters;

import java.util.Collection;
import java.util.Locale;

import au.com.toyota.nc.common.model.hibernate.Region;
import au.com.toyota.nc.common.model.search.EnumeratedRegionSearchOption;
import au.com.toyota.nc.common.model.search.NationalRegionsSearchOption;
import au.com.toyota.nc.common.model.search.RegionSearchOption;
import net.sourceforge.stripes.validation.TypeConverter;
import net.sourceforge.stripes.validation.ValidationError;

public class RegionSearchOptionsTypeConverter implements TypeConverter<RegionSearchOption>
{
    public void setLocale(Locale locale)
    {
        // Do nothing.  This doesn't use locales.
    }

    public RegionSearchOption convert(String regionValue, Class<? extends RegionSearchOption> aClass, Collection<ValidationError> errors)
    {
        RegionSearchOption regionSearchOption = new NationalRegionsSearchOption();
        if (!regionSearchOption.getId().equals(regionValue))
        {
            regionSearchOption = new EnumeratedRegionSearchOption(Region.valueOf(regionValue));
        }
        return regionSearchOption;
    }
}
