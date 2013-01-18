package au.com.toyota.nc.webapp.stripes.reports.impl;

import au.com.toyota.nc.common.model.hibernate.State;
import au.com.toyota.nc.webapp.stripes.reports.NetworkSummaryTableEntity;

import java.util.Arrays;
import java.util.List;

/**
 * User: Alex Ooi
 * Date: 27/04/2009
 * Time: 11:56:26
 */
public class StateNetworkSummaryTableEntityImpl extends AbstractNetworkSummaryTableEntity implements NetworkSummaryTableEntity
{
    private final State state;

    public StateNetworkSummaryTableEntityImpl(State state, List<NetworkSummaryTableEntity> stateDealerships)
    {
        super(stateDealerships);
        this.state = state;
        calculateAggregateStatistics(stateDealerships);
    }

    public List<String> getRowLabels()
    {
        return Arrays.asList(state.getDescription());
    }

}
