package au.com.toyota.nc.webapp.savedsearch.impl;

import au.com.toyota.nc.common.savedsearch.SavedSearchParameter;
import static org.easymock.EasyMock.expect;
import org.easymock.classextension.EasyMock;
import org.easymock.classextension.IMocksControl;
import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;
import org.junit.Before;
import org.junit.Test;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class SavedSearchParameterFactoryImplUnitTest
{
    private SavedSearchParameterFactoryImpl factory;
    private IMocksControl strictControl;
    private HttpServletRequest request;

    @Before
    public void createFactory()
    {
        factory = new SavedSearchParameterFactoryImpl();

        strictControl = EasyMock.createStrictControl();
        request = strictControl.createMock(HttpServletRequest.class);
    }

    @Test
    public void should_create_saved_search_parameters_for_each_key_value_pair() throws Exception
    {
        final Map<String, String[]> data = new LinkedHashMap<String, String[]>();
        data.put("username", new String[]{"ayqooi"});
        data.put("firstname", new String[]{"bob"});

        final List<SavedSearchParameter> params = doTest(data);

        assertThat(params.size(), is(2));
        assertThat(params.get(0).getKey(), is("username"));
        assertThat(params.get(0).getValue(), is("ayqooi"));
        assertThat(params.get(1).getKey(), is("firstname"));
        assertThat(params.get(1).getValue(), is("bob"));
    }

    @Test
    public void should_exclude_keys_prefixed_with_underscores() throws Exception
    {
        final Map<String, String[]> data = new LinkedHashMap<String, String[]>();
        data.put("username", new String[]{"ayqooi"});
        data.put("_ignoreme", new String[]{"dude"});
        data.put("__ignoremeagain", new String[]{"jim"});

        final List<SavedSearchParameter> params = doTest(data);

        assertThat(params.size(), is(1));
        assertThat(params.get(0).getKey(), is("username"));
        assertThat(params.get(0).getValue(), is("ayqooi"));
    }

    @Test
    public void should_include_a_parameter_for_each_value_of_a_keys_value_array() throws Exception
    {
        final Map<String, String[]> data = new LinkedHashMap<String, String[]>();
        data.put("username[]", new String[]{"ayqooi", "byo", "goose"});

        final List<SavedSearchParameter> params = doTest(data);

        assertThat(params.size(), is(3));
        assertThat(params.get(0).getKey(), is("username[]"));
        assertThat(params.get(0).getValue(), is("ayqooi"));
        assertThat(params.get(1).getKey(), is("username[]"));
        assertThat(params.get(1).getValue(), is("byo"));
        assertThat(params.get(2).getKey(), is("username[]"));
        assertThat(params.get(2).getValue(), is("goose"));
    }

    @Test
    public void should_exclude_blank_values() throws Exception
    {
        final Map<String, String[]> data = new LinkedHashMap<String, String[]>();
        data.put("username[]", new String[]{"jimmy", "", null, "   "});

        final List<SavedSearchParameter> params = doTest(data);

        assertThat(params.size(), is(1));
        assertThat(params.get(0).getKey(), is("username[]"));
        assertThat(params.get(0).getValue(), is("jimmy"));
    }

    private List<SavedSearchParameter> doTest(Map<String, String[]> data)
    {
        expect(request.getParameterMap()).andReturn(data).once();

        strictControl.replay();
        final List<SavedSearchParameter> params = factory.createSavedSearchParameters(request);
        strictControl.verify();
        return params;
    }
}
