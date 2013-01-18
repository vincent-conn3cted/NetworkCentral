package au.com.toyota.nc.webapp.stripes.reports.impl;

import au.com.toyota.nc.common.model.hibernate.Region;
import au.com.toyota.nc.webapp.stripes.reports.NetworkSummaryTableEntity;

import java.util.Arrays;
import java.util.List;

/**
 * User: Alex Ooi
 * Date: 27/04/2009
 * Time: 12:16:07
 */
public class RegionNetworkSummaryTableEntityImpl extends AbstractNetworkSummaryTableEntity implements NetworkSummaryTableEntity
{
    private final Region region;

    public RegionNetworkSummaryTableEntityImpl(Region region, List<NetworkSummaryTableEntity> regionDealerships)
    {
        super(regionDealerships);
        this.region = region;
        calculateAggregateStatistics(regionDealerships);
    }

    public List<String> getRowLabels()
    {
        return Arrays.asList(region.toString());
    }

}
