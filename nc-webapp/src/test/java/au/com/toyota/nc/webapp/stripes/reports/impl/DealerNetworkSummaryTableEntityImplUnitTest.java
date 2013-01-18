package au.com.toyota.nc.webapp.stripes.reports.impl;

import java.util.Collections;
import java.util.List;

import au.com.toyota.nc.common.AbstractUnitTestCase;
import au.com.toyota.nc.common.model.hibernate.Dealer;
import au.com.toyota.nc.common.model.hibernate.Location;
import au.com.toyota.nc.common.model.hibernate.LocationType;
import au.com.toyota.nc.common.model.hibernate.Status;
import au.com.toyota.nc.webapp.stripes.reports.NetworkSummaryTableEntity;
import org.junit.Before;
import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

public class DealerNetworkSummaryTableEntityImplUnitTest extends AbstractUnitTestCase
{
    private Location inactiveLocation;
    private Location draftLocation;

    private Location principalLocation;

    private Location andesLocation;
    private Location boozersLocation;
    private Location mojoLocation;
    private Location shedLocation;
    private Location umbrellaLocation;

    private DealerNetworkSummaryTableEntityImpl entity;

    private Dealer dealer;

    @Test
    public void should_not_return_non_active_locations_as_children() throws Exception
    {
        final List<NetworkSummaryTableEntity> children = entity.getChildren();
        assertThat(children.contains(inactiveLocation), is(false));
        assertThat(children.contains(draftLocation), is(false));
    }

    @Test
    public void should_return_principal_location_at_the_top_of_the_list() throws Exception
    {
        Collections.shuffle(dealer.getLocations());
        final List children = entity.getChildren();
        assertThat(getLocationAt(0, children), is(principalLocation));
    }

    @Test
    public void should_return_other_locations_in_alphabetical_order_ignoring_case() throws Exception
    {
        Collections.shuffle(dealer.getLocations());
        final List children = entity.getChildren();
        assertThat(getLocationAt(1, children), is(umbrellaLocation));   // Branch
        assertThat(getLocationAt(2, children), is(shedLocation));       // Satellite
        assertThat(getLocationAt(3, children), is(andesLocation));      /// Others...
        assertThat(getLocationAt(4, children), is(boozersLocation));
        assertThat(getLocationAt(5, children), is(mojoLocation));
    }

    @Test
    public void the_rows_label_should_return_the_dealers_name_and_dealer_code_and_pma_name() throws Exception
    {
        final String pmaName = "gladstone";
        final String dealerName = "Timbuctoo Hotel";
        final String dealerCode = "827341";
        dealer.getGeneralInfo().setDealerName(dealerName);
        dealer.getGeneralInfo().setDealerCode(dealerCode);
        dealer.getGeneralInfo().setPma(pmaTestBuilder.withName(pmaName).create());

        final List<String> labels = entity.getRowLabels();
        assertThat(labels.size(), is(1));
        assertThat(labels.get(0), is(dealerName + " (" + pmaName.toUpperCase() + ", " + dealerCode + ")"));
    }

    private Location getLocationAt(final int index, List children)
    {
        return ((LocationNetworkSummaryTableEntityImpl) children.get(index)).getLocation();
    }

    @Before
    public void setUp() throws Exception
    {
        dealer = dealerTestBuilder.withNoLocations().create();

        principalLocation = locationTestBuilder.withDealer(dealer).
            withLocationName("zeebra").
            withLocationType(LocationType.Principal).
            withStatus(Status.Active).create();

        andesLocation = locationTestBuilder.withDealer(dealer).
            withLocationName("andes").
            withLocationType(LocationType.UsedVehicle).
            withStatus(Status.Active).create();
        boozersLocation = locationTestBuilder.withDealer(dealer).
            withLocationName("Boozers").
            withLocationType(LocationType.PreDelivery).
            withStatus(Status.Active).create();
        mojoLocation = locationTestBuilder.withDealer(dealer).
            withLocationName("Mojo").
            withLocationType(LocationType.Service).
            withStatus(Status.Active).create();
        shedLocation = locationTestBuilder.withDealer(dealer).
            withLocationName("shed").
            withLocationType(LocationType.Satellite).
            withStatus(Status.Active).create();
        umbrellaLocation = locationTestBuilder.withDealer(dealer).
            withLocationName("umbrella").
            withLocationType(LocationType.Branch).
            withStatus(Status.Active).create();

        inactiveLocation = locationTestBuilder.withDealer(dealer).
            withLocationName("Inactive").
            withLocationType(LocationType.Satellite).
            withStatus(Status.Inactive).create();
        draftLocation = locationTestBuilder.withDealer(dealer).
            withLocationName("drafty").
            withLocationType(LocationType.UsedVehicle).
            withStatus(Status.Draft).create();

        entity = new DealerNetworkSummaryTableEntityImpl(dealer, 0, 0, 0, 0);
    }
}
