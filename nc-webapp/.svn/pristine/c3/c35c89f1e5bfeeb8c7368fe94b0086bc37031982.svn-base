package au.com.toyota.nc.webapp.stripes.reports.impl;

import au.com.toyota.nc.common.AbstractUnitTestCase;
import au.com.toyota.nc.common.model.hibernate.Region;
import au.com.toyota.nc.common.model.hibernate.State;
import au.com.toyota.nc.webapp.stripes.reports.NetworkSummaryTableEntity;
import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;
import org.junit.Test;

import static java.util.Arrays.asList;
import static java.util.Collections.EMPTY_LIST;

public class NetworkSummaryTotalTableEntityUnitTest extends AbstractUnitTestCase
{
    @Test
    public void can_return_the_correct_row_label() throws Exception
    {
        final NetworkSummaryTotalTableEntity entity = new NetworkSummaryTotalTableEntity(EMPTY_LIST);
        assertThat(entity.getRowLabels().size(), is(1));
        assertThat(entity.getRowLabels().get(0), is("Total"));
    }

    @Test
    public void can_aggregate_all_column_counts_for_dealer_entities() throws Exception
    {
        final NetworkSummaryTableEntity childOne = new DealerNetworkSummaryTableEntityImpl(dealerTestBuilder.withMetroFlag(true).create(), 10, 5, 15, 20);
        final NetworkSummaryTableEntity childTwo = new DealerNetworkSummaryTableEntityImpl(dealerTestBuilder.withMetroFlag(false).create(), 50, 10, 5, 60);
        final NetworkSummaryTableEntity childThree = new DealerNetworkSummaryTableEntityImpl(dealerTestBuilder.withMetroFlag(false).create(), 1, 1, 1, 1);
        final NetworkSummaryTotalTableEntity entity = new NetworkSummaryTotalTableEntity(asList(
                childOne, childTwo, childThree
        ));

        assertThat(entity.getPrincipalAndBranches(), is("61"));
        assertThat(entity.getBranches(), is("16"));
        assertThat(entity.getSatelliteServices(), is("21"));
        assertThat(entity.getOtherLocations(), is("81"));
        assertThat(entity.getMetro(), is("1"));
        assertThat(entity.getRural(), is("2"));
    }

    @Test
    public void should_not_add_any_counts_for_location_entities() throws Exception
    {
        final NetworkSummaryTableEntity childOne = new LocationNetworkSummaryTableEntityImpl(locationTestBuilder.create());
        final NetworkSummaryTableEntity childTwo = new LocationNetworkSummaryTableEntityImpl(locationTestBuilder.create());
        final NetworkSummaryTableEntity childThree = new LocationNetworkSummaryTableEntityImpl(locationTestBuilder.create());
        final NetworkSummaryTotalTableEntity entity = new NetworkSummaryTotalTableEntity(asList(
                childOne, childTwo, childThree
        ));

        assertThat(entity.getPrincipalAndBranches(), is("0"));
        assertThat(entity.getBranches(), is("0"));
        assertThat(entity.getSatelliteServices(), is("0"));
        assertThat(entity.getOtherLocations(), is("0"));
        assertThat(entity.getMetro(), is("0"));
        assertThat(entity.getRural(), is("0"));
    }

    @Test
    public void should_aggregate_all_types_of_table_entity_types() throws Exception
    {
        final NetworkSummaryTableEntity dealerChild = new DealerNetworkSummaryTableEntityImpl(dealerTestBuilder.withMetroFlag(true).create(), 10, 5, 15, 20);
        final NetworkSummaryTableEntity locationChild = new LocationNetworkSummaryTableEntityImpl(locationTestBuilder.create());
        final NetworkSummaryTableEntity regionChild = new RegionNetworkSummaryTableEntityImpl(Region.Eastern, asList(dealerChild));
        final NetworkSummaryTableEntity stateChild = new StateNetworkSummaryTableEntityImpl(State.ACT, asList(dealerChild));
        final NetworkSummaryTotalTableEntity entity = new NetworkSummaryTotalTableEntity(asList(
                dealerChild, locationChild, regionChild, stateChild
        ));

        assertThat(entity.getPrincipalAndBranches(), is("30"));
        assertThat(entity.getBranches(), is("15"));
        assertThat(entity.getSatelliteServices(), is("45"));
        assertThat(entity.getOtherLocations(), is("60"));
        assertThat(entity.getMetro(), is("3"));
        assertThat(entity.getRural(), is("0"));
    }

    @Test
    public void should_indicate_that_there_are_no_children_regardless_of_children_present_as_total_row_never_needs_expansion() throws Exception
    {
        final NetworkSummaryTableEntity dealerChild = new DealerNetworkSummaryTableEntityImpl(dealerTestBuilder.withMetroFlag(true).create(), 10, 5, 15, 20);
        final NetworkSummaryTableEntity locationChild = new LocationNetworkSummaryTableEntityImpl(locationTestBuilder.create());
        final NetworkSummaryTableEntity regionChild = new RegionNetworkSummaryTableEntityImpl(Region.Eastern, asList(dealerChild));
        final NetworkSummaryTableEntity stateChild = new StateNetworkSummaryTableEntityImpl(State.ACT, asList(dealerChild));
        final NetworkSummaryTotalTableEntity entity = new NetworkSummaryTotalTableEntity(asList(
                dealerChild, locationChild, regionChild, stateChild
        ));

        assertThat(entity.getHasChildren(), is(false));
        assertThat(entity.getChildren().size(), is(0));
    }
}
