package au.com.toyota.nc.webapp.search.dealer;

import java.util.List;

import au.com.toyota.nc.common.AbstractUnitTestCase;
import au.com.toyota.nc.common.model.hibernate.LocationType;
import au.com.toyota.nc.common.model.search.LocationTypeSearchOption;
import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

public class LocationTypeSearchOptionsFactoryTestUnitTest extends AbstractUnitTestCase
{
    @Test
    public void should_return_the_required_location_type_search_options() throws Exception
    {
        List<LocationTypeSearchOption> options = LocationTypeSearchOptionsFactory.createSearchOptions();
        assertThat(options.size(), is(11));
        assertThat(options.get(0).getDescription(), is(LocationType.Principal.getDescription()));
        assertThat(options.get(1).getDescription(), is(LocationType.Branch.getDescription()));
        assertThat(options.get(2).getDescription(), is("Principal and Branch"));
        assertThat(options.get(3).getDescription(), is(LocationType.Satellite.getDescription()));
        assertThat(options.get(4).getDescription(), is(LocationType.Service.getDescription()));
        assertThat(options.get(5).getDescription(), is(LocationType.PartsWarehouse.getDescription()));
        assertThat(options.get(6).getDescription(), is(LocationType.PreDelivery.getDescription()));
        assertThat(options.get(7).getDescription(), is(LocationType.UsedVehicle.getDescription()));
        assertThat(options.get(8).getDescription(), is(LocationType.VehicleStorage.getDescription()));
        assertThat(options.get(9).getDescription(), is(LocationType.ShipToLocation.getDescription()));
        assertThat(options.get(10).getDescription(), is(LocationType.PartsSalesFacility.getDescription()));
    }

}
