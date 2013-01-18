package au.com.toyota.nc.webapp.stripes.ext.converters;

import java.util.Collections;
import java.util.List;

import au.com.toyota.nc.common.AbstractUnitTestCase;
import au.com.toyota.nc.common.model.hibernate.LocationType;
import au.com.toyota.nc.common.model.search.CommaSeperatedLocationTypeSearchOption;
import au.com.toyota.nc.common.model.search.LocationTypeSearchOption;
import org.junit.Test;

import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.is;
import static org.junit.Assert.assertThat;

public class LocationTypeSearchOptionsTypeConverterUnitTest extends AbstractUnitTestCase
{
    @Test
    public void should_convert_location_type_strings_to_a_location_type_search_option() throws Exception
    {
        final LocationTypeSearchOptionsTypeConverter typeConverter = new LocationTypeSearchOptionsTypeConverter();
        final String httpString = LocationType.Principal.name() + ","
            + LocationType.UsedVehicle + ","
            + LocationType.Service + ","
            + LocationType.Branch + ","
            + LocationType.PartsWarehouse.name();
        final LocationTypeSearchOption option = typeConverter.convert(httpString, CommaSeperatedLocationTypeSearchOption.class, Collections.EMPTY_LIST);

        final List<LocationType> locationTypes = option.getLocationTypes();
        assertThat(locationTypes.size(), is(5));
        assertThat(locationTypes, hasItem(LocationType.Principal));
        assertThat(locationTypes, hasItem(LocationType.PartsWarehouse));
        assertThat(locationTypes, hasItem(LocationType.UsedVehicle));
        assertThat(locationTypes, hasItem(LocationType.Service));
        assertThat(locationTypes, hasItem(LocationType.Branch));
    }

}
