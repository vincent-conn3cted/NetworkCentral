package au.com.toyota.nc.webapp.stripes.reports.impl;

import java.util.List;

import au.com.toyota.nc.common.AbstractUnitTestCase;
import au.com.toyota.nc.common.model.hibernate.AbstractContact;
import au.com.toyota.nc.common.model.hibernate.Location;
import au.com.toyota.nc.common.model.hibernate.LocationType;
import au.com.toyota.nc.common.model.hibernate.State;
import org.junit.Before;
import org.junit.Test;

import static au.com.toyota.nc.matchers.hamcrest.BlankStringMatcher.blank;
import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

public class LocationNetworkSummaryTableEntityImplUnitTest extends AbstractUnitTestCase
{
    private Location location;
    private LocationNetworkSummaryTableEntityImpl entity;

    @Test
    public void should_have_blank_information_for_counts() throws Exception
    {
        assertThat(entity.getPrincipalAndBranches(), is(blank()));
        assertThat(entity.getDealerships(), is(blank()));
        assertThat(entity.getBranches(), is(blank()));
        assertThat(entity.getSatelliteServices(), is(blank()));
        assertThat(entity.getOtherLocations(), is(blank()));
        assertThat(entity.getMetro(), is(blank()));
        assertThat(entity.getRural(), is(blank()));
    }

    @Test
    public void should_not_have_children() throws Exception
    {
        assertThat(entity.getHasChildren(), is(false));
    }

    @Test
    public void should_return_an_empty_list_of_children() throws Exception
    {
        assertThat(entity.getChildren().size(), is(0));
    }

    @Test
    public void should_be_able_to_retrieve_the_location() throws Exception
    {
        assertThat(entity.getLocation(), is(location));
    }

    @Test
    public void should_get_row_labels_with_all_required_information() throws Exception
    {
        final List<String> rowLabels = entity.getRowLabels();
        final AbstractContact.Address streetAddress = location.getContact().getStreetAddress();
        assertThat(rowLabels.size(), is(7));
        assertThat(rowLabels.get(0), is(location.getType().getDescription() + " (" + streetAddress.getSuburb() + ", " + streetAddress.getState().getLabel().toUpperCase() + ")"));
        assertThat(rowLabels.get(1), is(blank()));
        assertThat(rowLabels.get(2), is(location.getLocationName()));
        assertThat(rowLabels.get(3), is(streetAddress.getAddress1() + " " + streetAddress.getAddress2()));
        assertThat(rowLabels.get(4), is(streetAddress.getSuburb() + " " + streetAddress.getState().getLabel() + " " + streetAddress.getPostCode()));
        assertThat(rowLabels.get(5), is("Phone: " + location.getContact().getPhone()));
        assertThat(rowLabels.get(6), is("Fax: " + location.getContact().getFax()));
    }

    @Test
    public void should_have_location_style_type_specific_to_principal_location() throws Exception
    {
        location.setType(LocationType.Principal);
        assertThat(entity.getStyleName(), is("principalLocationRow"));
    }

    @Test
    public void should_have_no_style_type_if_not_principal_location() throws Exception
    {
        location.setType(LocationType.Branch);
        assertThat(entity.getStyleName(), is("locationRow"));
        location.setType(LocationType.Satellite);
        assertThat(entity.getStyleName(), is("locationRow"));
        location.setType(LocationType.UsedVehicle);
        assertThat(entity.getStyleName(), is("locationRow"));
        location.setType(LocationType.Service);
        assertThat(entity.getStyleName(), is("locationRow"));
        location.setType(LocationType.PartsWarehouse);
        assertThat(entity.getStyleName(), is("locationRow"));
    }

    @Before
    public void setUp() throws Exception
    {
        final AbstractContact.Address streetAddress = addressTestBuilder.
            withAddress1("Jimbos House").
            withAddress2("60 Goosey rd").
            withSuburb("AvenueLand").
            withState(State.ACT).
            withPostCode("4120").
            create();
        location = locationTestBuilder.
            withLocationName("Gooses Point").
            withLocationType(LocationType.ShipToLocation).
            withStreetAddress(streetAddress).
            withPhone("0022 318 231").
            withFax("92382 372").
            create();
        entity = new LocationNetworkSummaryTableEntityImpl(location);
    }
}
