package au.com.toyota.nc.webapp.adapter;

import au.com.toyota.nc.common.model.hibernate.CommonValue;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;

/**
 * User: Alex Wibowo
 * Date: 5/02/2009
 * Time: 14:25:09
 */
public class CommonValueJSONAdapter implements JSONAdapter {
    private static final Logger LOGGER = Logger.getLogger(CommonValueJSONAdapter.class.getName());

    public static final String PROPERTYNAME_VALUE = "value";
    public static final String PROPERTYNAME_ID = "id";
    public static final String PROPERTYNAME_TYPE = "type";

    private CommonValue val;

    public CommonValueJSONAdapter(CommonValue val) {
        this.val=val;
    }

    public JSONObject toJSONObject() {
        JSONObject result = new JSONObject();
        result.put(PROPERTYNAME_ID, val.getCommonValueId());
        result.put(PROPERTYNAME_VALUE, val.getValue());
        result.put(PROPERTYNAME_TYPE, val.getType());
        return result;  
    }
}
