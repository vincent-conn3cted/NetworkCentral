package au.com.toyota.nc.webapp.stripes.reports.impl;

import au.com.toyota.nc.webapp.stripes.reports.NetworkSummaryTableEntity;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class NetworkSummaryTotalTableEntity extends AbstractNetworkSummaryTableEntity implements NetworkSummaryTableEntity
{
    public NetworkSummaryTotalTableEntity(List<NetworkSummaryTableEntity> dealershipEntities)
    {
        super(dealershipEntities);
        calculateAggregateStatistics(dealershipEntities);
    }

    @Override
    public List<NetworkSummaryTableEntity> getChildren()
    {
        return Collections.EMPTY_LIST;
    }

    public boolean getHasChildren()
    {
        return false;
    }

    public List<String> getRowLabels()
    {
        return Arrays.asList("Total");
    }
}
