package au.com.toyota.nc.webapp.dataproxy.impl;

import au.com.toyota.nc.common.AbstractUnitTestCase;
import au.com.toyota.nc.common.model.hibernate.Dealer;
import au.com.toyota.nc.common.model.hibernate.Location;
import static au.com.toyota.nc.matchers.hamcrest.BlankStringMatcher.blank;
import au.com.toyota.nc.webapp.stripes.AjaxResolution;
import net.sourceforge.stripes.action.Resolution;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.instanceOf;
import static org.hamcrest.Matchers.not;
import static org.hamcrest.Matchers.nullValue;
import static org.junit.Assert.assertThat;
import org.junit.Before;
import org.junit.Test;

import java.util.Arrays;
import java.util.Collections;

public class AutoSuggestionJsonResolutionFactoryUnitTest extends AbstractUnitTestCase
{
    private AutoSuggestionJsonResolutionFactory factory;

    @Before
    public void createFactory() throws Exception
    {
        factory = new AutoSuggestionJsonResolutionFactory();
    }

    @Test
    public void resolving_dealer_name_should_create_ajax_resolution() throws Exception
    {
        final Resolution resolution = factory.resolveDealerNameSuggestions(Collections.EMPTY_LIST);
        assertThat(resolution, instanceOf(AjaxResolution.class));
    }

    @Test
    public void should_not_include_duplicate_names_for_dealers() throws Exception
    {
        final String dealerName = "Same One";
        final Dealer dealer = dealerTestBuilder.withDealerName(dealerName).create();
        final Location location = locationTestBuilder.withDealer(dealer).create();

        final AjaxResolution resolution = (AjaxResolution) factory.resolveDealerNameSuggestions(Arrays.asList(location, location));
        assertThat(resolution.getJson(), is(not(nullValue())));

        final String jsonString = resolution.getJson().toString();
        assertThat(jsonString, is(not(blank())));
        assertThat(jsonString.lastIndexOf(dealerName), is(jsonString.indexOf(dealerName)));
    }

    @Test
    public void should_include_every_dealer_name_passed_in_for_dealers() throws Exception
    {
        final Dealer dealerOne = dealerTestBuilder.withDealerName("Same One").create();
        final Location locationOne = locationTestBuilder.withDealer(dealerOne).create();

        final Dealer dealerTwo = dealerTestBuilder.withDealerName("Secondish").create();
        final Location locationTwo = locationTestBuilder.withDealer(dealerTwo).create();

        final Dealer dealerThree = dealerTestBuilder.withDealerName("Third").create();
        final Location locationThree = locationTestBuilder.withDealer(dealerThree).create();

        final AjaxResolution resolution = (AjaxResolution) factory.resolveDealerNameSuggestions(Arrays.asList(locationOne, locationTwo, locationThree));
        assertThat(resolution.getJson(), is(not(nullValue())));

        final String jsonString = resolution.getJson().toString();
        assertThat(jsonString, is(not(blank())));
        assertThat(jsonString, containsString(dealerOne.getGeneralInfo().getDealerName()));
        assertThat(jsonString, containsString(dealerTwo.getGeneralInfo().getDealerName()));
        assertThat(jsonString, containsString(dealerThree.getGeneralInfo().getDealerName()));
    }

    @Test
    public void resolving_location_name_should_create_ajax_resolution() throws Exception
    {
        final Resolution resolution = factory.resolveLocationNameSuggestions(Collections.EMPTY_LIST);
        assertThat(resolution, is(instanceOf(AjaxResolution.class)));
    }

    @Test
    public void should_not_include_duplicate_names_for_locations() throws Exception
    {
        final Location location = locationTestBuilder.withLocationName("Same Name").create();

        final AjaxResolution resolution = (AjaxResolution) factory.resolveLocationNameSuggestions(Arrays.asList(location, location, location));
        final String jsonString = resolution.getJson().toString();
        assertThat(jsonString, is(not(blank())));
        assertThat(jsonString.lastIndexOf(location.getLocationName()), is(jsonString.indexOf(location.getLocationName())));
    }

    @Test
    public void should_include_every_location_name_passed_in_for_locations() throws Exception
    {
        final Location locationOne = locationTestBuilder.withLocationName("Same Name").create();
        final Location locationTwo = locationTestBuilder.withLocationName("Nobody Cares anymore").create();
        final Location locationThree = locationTestBuilder.withLocationName("Thirdy").create();

        final AjaxResolution resolution = (AjaxResolution) factory.resolveLocationNameSuggestions(Arrays.asList(locationOne, locationThree, locationTwo));
        final String jsonString = resolution.getJson().toString();
        assertThat(jsonString, is(not(blank())));
        assertThat(jsonString, containsString(locationOne.getLocationName()));
        assertThat(jsonString, containsString(locationTwo.getLocationName()));
        assertThat(jsonString, containsString(locationThree.getLocationName()));
    }

    @Test
    public void should_ignore_locations_which_do_not_have_a_name() throws Exception
    {
        final Location locationOne = locationTestBuilder.withLocationName("Same Name").create();
        final Location withoutName = locationTestBuilder.withLocationName(" ").create();

        final AjaxResolution resolution = (AjaxResolution) factory.resolveLocationNameSuggestions(Arrays.asList(locationOne, withoutName));
        final String jsonString = resolution.getJson().toString();
        assertThat(jsonString, is(not(blank())));
        assertThat(jsonString, containsString(locationOne.getLocationName()));
        assertThat(jsonString.lastIndexOf("locationName"), is(jsonString.indexOf("locationName"))); // only one locationName cos only one should be added
    }
}
