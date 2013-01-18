package au.com.toyota.nc.webapp.adapter;

import au.com.toyota.nc.common.model.PMASearchResponse;
import au.com.toyota.nc.common.model.hibernate.PMA;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;

/**
 * User: Alex Wibowo
 * Date: 6/02/2009
 * Time: 15:47:59
 */
public class PMAJSONAdapter implements JSONAdapter{
    private static final Logger LOGGER = Logger.getLogger(PMAJSONAdapter.class.getName());

    public static final String PROPERTY_ID = "id";
    public static final String PROPERTY_NAME = "name";
    public static final String PROPERTY_CODE = "code";

    private PMASearchResponse pmaSearchResponse;

    public PMAJSONAdapter(PMASearchResponse pmaSearchResponse) {
        this.pmaSearchResponse = pmaSearchResponse;
    }

    public JSONObject toJSONObject() {
        JSONObject result = new JSONObject();
        final PMA pma = pmaSearchResponse.getPma();
        if(pma != null)
        {
            result.put(PROPERTY_ID, pma.getPmaId());
            result.put(PROPERTY_CODE, pma.getCode());
            result.put(PROPERTY_NAME, pma.getName());
        }
        result.put("openPMA", pmaSearchResponse.getOpenPMA());
        result.put("activeDealerId", pmaSearchResponse.getActiveDealerId());
        result.put("activeDealerName", pmaSearchResponse.getActiveDealerName());
        return result;
    }
}
