package au.com.toyota.nc.webapp.stripes.reports.impl;

import java.util.Comparator;

import au.com.toyota.nc.common.model.hibernate.Location;
import au.com.toyota.nc.common.model.hibernate.LocationType;
import au.com.toyota.nc.webapp.stripes.reports.NetworkSummaryTableEntity;

public class LocationNetworkSummaryComparator implements Comparator<NetworkSummaryTableEntity>
{
    public int compare(NetworkSummaryTableEntity o1, NetworkSummaryTableEntity o2)
    {
        final Location locationOne = ((LocationNetworkSummaryTableEntityImpl) o1).getLocation();
        final Location locationTwo = ((LocationNetworkSummaryTableEntityImpl) o2).getLocation();

        String locationOneCode = orderPrefix(locationOne.getType()) + locationOne.getLocationName();
        String locationTwoCode = orderPrefix(locationTwo.getType()) + locationTwo.getLocationName();

        return locationOneCode.compareToIgnoreCase(locationTwoCode);
    }

    private String orderPrefix(LocationType locationType)
    {
        switch (locationType)
        {
            case Principal:
                return "a";

            case Branch:
                return "b";

            case Satellite:
                return "c";

            default:
                return "d";
        }
    }
}
