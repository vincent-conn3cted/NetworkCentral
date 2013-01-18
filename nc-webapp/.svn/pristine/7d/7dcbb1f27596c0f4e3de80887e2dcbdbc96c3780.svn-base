package au.com.toyota.nc.webapp.search.staff;

import java.util.ArrayList;
import java.util.List;

import au.com.toyota.nc.common.model.hibernate.Region;
import au.com.toyota.nc.common.model.search.EnumeratedRegionSearchOption;
import au.com.toyota.nc.common.model.search.NationalRegionsSearchOption;
import au.com.toyota.nc.common.model.search.RegionSearchOption;

public class RegionSearchOptionsFactory
{
    public static List<RegionSearchOption> createSearchOptions()
    {
        final List<RegionSearchOption> options = new ArrayList<RegionSearchOption>();
        options.add(new NationalRegionsSearchOption());
        for (Region region : Region.values())
        {
            options.add(new EnumeratedRegionSearchOption(region));
        }
        return options;
    }

}
