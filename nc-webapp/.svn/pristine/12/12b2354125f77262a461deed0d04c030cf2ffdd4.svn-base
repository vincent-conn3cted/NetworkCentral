package au.com.toyota.nc.webapp.search.dealer;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import au.com.toyota.nc.common.model.hibernate.LocationType;
import au.com.toyota.nc.common.model.search.CommaSeperatedLocationTypeSearchOption;
import au.com.toyota.nc.common.model.search.LocationTypeSearchOption;

public class LocationTypeSearchOptionsFactory
{
    public static List<LocationTypeSearchOption> createSearchOptions()
    {
        final List<LocationTypeSearchOption> options = new ArrayList<LocationTypeSearchOption>();

        // Add Principal and Branch
        options.add(new CommaSeperatedLocationTypeSearchOption(LocationType.Principal));
        options.add(new CommaSeperatedLocationTypeSearchOption(LocationType.Branch));
        options.add(new CommaSeperatedLocationTypeSearchOption(LocationType.Principal, LocationType.Branch));

        // Add the rest
        List<LocationType> locationTypes = new ArrayList<LocationType>(Arrays.asList(LocationType.values()));
        locationTypes.remove(LocationType.Principal);
        locationTypes.remove(LocationType.Branch);
        for (LocationType locationType : locationTypes) {
            options.add(new CommaSeperatedLocationTypeSearchOption(locationType));
        }

        return options;
    }
}
