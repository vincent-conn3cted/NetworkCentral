package au.com.toyota.nc.webapp.stripes.reports.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import au.com.toyota.nc.common.AbstractUnitTestCase;
import au.com.toyota.nc.common.model.hibernate.Dealer;
import au.com.toyota.nc.common.model.hibernate.LocationType;
import au.com.toyota.nc.webapp.stripes.reports.NetworkSummaryTableEntity;
import org.junit.Test;

import static org.hamcrest.core.Is.is;
import static org.junit.Assert.assertThat;

public class LocationNetworkSummaryComparatorTest extends AbstractUnitTestCase
{
    @Test
    public void should_be_sorted_principal_branches_satellite_others_sorted_alphabetically_in_each()
    {
        // given
        //create a dealer
        Dealer dealer = dealerTestBuilder.create();

        List<NetworkSummaryTableEntity> networkSummaryTableEntityArrayList = new ArrayList<NetworkSummaryTableEntity>();
        //add principal, three branches, three satellites and three others
        networkSummaryTableEntityArrayList.add(new LocationNetworkSummaryTableEntityImpl(
                locationTestBuilder.withDealer(dealer).withLocationType(LocationType.PartsWarehouse).withLocationName("Zulu (4)").create()));
        networkSummaryTableEntityArrayList.add(new LocationNetworkSummaryTableEntityImpl(
                locationTestBuilder.withDealer(dealer).withLocationType(LocationType.PreDelivery).withLocationName("Nelly (4)").create()));
        networkSummaryTableEntityArrayList.add(new LocationNetworkSummaryTableEntityImpl(
                locationTestBuilder.withDealer(dealer).withLocationType(LocationType.VehicleStorage).withLocationName("Alpha (4)").create()));

        networkSummaryTableEntityArrayList.add(new LocationNetworkSummaryTableEntityImpl(
                locationTestBuilder.withDealer(dealer).withLocationType(LocationType.Satellite).withLocationName("Zulu (3)").create()));
        networkSummaryTableEntityArrayList.add(new LocationNetworkSummaryTableEntityImpl(
                locationTestBuilder.withDealer(dealer).withLocationType(LocationType.Satellite).withLocationName("Nelly (3)").create()));
        networkSummaryTableEntityArrayList.add(new LocationNetworkSummaryTableEntityImpl(
                locationTestBuilder.withDealer(dealer).withLocationType(LocationType.Satellite).withLocationName("Alpha (3)").create()));

        networkSummaryTableEntityArrayList.add(new LocationNetworkSummaryTableEntityImpl(
                locationTestBuilder.withDealer(dealer).withLocationType(LocationType.Branch).withLocationName("Zulu (2)").create()));
        networkSummaryTableEntityArrayList.add(new LocationNetworkSummaryTableEntityImpl(
                locationTestBuilder.withDealer(dealer).withLocationType(LocationType.Branch).withLocationName("Nelly (2)").create()));
        networkSummaryTableEntityArrayList.add(new LocationNetworkSummaryTableEntityImpl(
                locationTestBuilder.withDealer(dealer).withLocationType(LocationType.Branch).withLocationName("Alpha (2)").create()));

        networkSummaryTableEntityArrayList.add(new LocationNetworkSummaryTableEntityImpl(
                locationTestBuilder.withDealer(dealer).withLocationType(LocationType.Principal).withLocationName("Alpha (1)").create()));

        // when
        Collections.sort(networkSummaryTableEntityArrayList, new LocationNetworkSummaryComparator());

        // then
        assertThat(((LocationNetworkSummaryTableEntityImpl) networkSummaryTableEntityArrayList.get(0)).getLocation().getLocationName(),
                is("Alpha (1)"));

        assertThat(((LocationNetworkSummaryTableEntityImpl) networkSummaryTableEntityArrayList.get(1)).getLocation().getLocationName(),
                is("Alpha (2)"));
        assertThat(((LocationNetworkSummaryTableEntityImpl) networkSummaryTableEntityArrayList.get(2)).getLocation().getLocationName(),
                is("Nelly (2)"));
        assertThat(((LocationNetworkSummaryTableEntityImpl) networkSummaryTableEntityArrayList.get(3)).getLocation().getLocationName(),
                is("Zulu (2)"));

        assertThat(((LocationNetworkSummaryTableEntityImpl) networkSummaryTableEntityArrayList.get(4)).getLocation().getLocationName(),
                is("Alpha (3)"));
        assertThat(((LocationNetworkSummaryTableEntityImpl) networkSummaryTableEntityArrayList.get(5)).getLocation().getLocationName(),
                is("Nelly (3)"));
        assertThat(((LocationNetworkSummaryTableEntityImpl) networkSummaryTableEntityArrayList.get(6)).getLocation().getLocationName(),
                is("Zulu (3)"));

        assertThat(((LocationNetworkSummaryTableEntityImpl) networkSummaryTableEntityArrayList.get(7)).getLocation().getLocationName(),
                is("Alpha (4)"));
        assertThat(((LocationNetworkSummaryTableEntityImpl) networkSummaryTableEntityArrayList.get(8)).getLocation().getLocationName(),
                is("Nelly (4)"));
        assertThat(((LocationNetworkSummaryTableEntityImpl) networkSummaryTableEntityArrayList.get(9)).getLocation().getLocationName(),
                is("Zulu (4)"));
    }
}
