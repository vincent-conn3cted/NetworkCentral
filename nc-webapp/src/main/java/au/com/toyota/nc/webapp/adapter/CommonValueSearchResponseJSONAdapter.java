package au.com.toyota.nc.webapp.adapter;

import au.com.toyota.nc.common.model.hibernate.CommonValue;
import au.com.toyota.nc.common.model.hibernate.CommonValueTypes;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;

import java.util.List;

/**
 * User: Alex Wibowo
 * Date: 5/02/2009
 * Time: 14:52:13
 */
public class CommonValueSearchResponseJSONAdapter implements JSONAdapter {
    private static final Logger LOGGER = Logger.getLogger(CommonValueSearchResponseJSONAdapter.class.getName());

    public static final String PROPERTYNAME_TYPE_NAME = "type";
    public static final String PROPERTYNAME_VALUES = "values";

    private CommonValueTypes type;
    private List<CommonValue> values;

    public CommonValueSearchResponseJSONAdapter(CommonValueTypes type, List<CommonValue> values) {
        this.type=type;
        this.values=values;
    }

    public JSONObject toJSONObject() {
        JSONObject result = new JSONObject();
        result.put(PROPERTYNAME_TYPE_NAME, type.getDisplayName());

        JSONArray arrays = new JSONArray();
        for (CommonValue value : values) {
            arrays.put(new CommonValueJSONAdapter(value).toJSONObject());
        }
        result.put(PROPERTYNAME_VALUES, arrays);
        return result;
    }
}
