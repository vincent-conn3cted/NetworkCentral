package au.com.toyota.nc.webapp.adapter;

import au.com.toyota.nc.common.AbstractUnitTestCase;
import au.com.toyota.nc.common.model.PMASearchResponse;
import au.com.toyota.nc.common.model.hibernate.PMA;
import net.sf.json.JSONObject;
import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;
import org.junit.Test;

public class PMAJSONAdapterUnitTest extends AbstractUnitTestCase
{
    @Test
    public void can_create_a_json_object_when_no_pma_found() throws Exception
    {
        final PMASearchResponse response = new PMASearchResponse();
        final PMAJSONAdapter pmajsonAdapter = new PMAJSONAdapter(response);
        final JSONObject jsonObject = pmajsonAdapter.toJSONObject();
        assertThat(jsonObject.has("id"), is(false));
        assertThat(jsonObject.has("name"), is(false));
        assertThat(jsonObject.has("code"), is(false));
        assertThat(jsonObject.has("openPMA"), is(false));
        assertThat(jsonObject.has("activeDealerId"), is(false));
        assertThat(jsonObject.has("activeDealerName"), is(false));
    }

    @Test
    public void can_create_a_json_object_with_all_values_populated() throws Exception
    {
        final PMA pma = pmaTestBuilder.create();
        pma.setPmaId(12381L);
        final PMASearchResponse response = new PMASearchResponse();
        response.setPma(pma);
        response.setOpenPMA(Boolean.FALSE);
        response.setActiveDealerId(91293921L);
        response.setActiveDealerName("lkajflas");
        final PMAJSONAdapter pmajsonAdapter = new PMAJSONAdapter(response);
        final JSONObject jsonObject = pmajsonAdapter.toJSONObject();
        assertThat(jsonObject.getLong("id"), is(pma.getPmaId()));
        assertThat(jsonObject.getString("name"), is(pma.getName()));
        assertThat(jsonObject.getString("code"), is(pma.getCode()));
        assertThat(jsonObject.getBoolean("openPMA"), is(Boolean.FALSE));
        assertThat(jsonObject.getLong("activeDealerId"), is(response.getActiveDealerId()));
        assertThat(jsonObject.getString("activeDealerName"), is(response.getActiveDealerName()));
    }
}
