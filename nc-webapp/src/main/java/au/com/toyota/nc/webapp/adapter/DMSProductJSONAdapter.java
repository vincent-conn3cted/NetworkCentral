package au.com.toyota.nc.webapp.adapter;

import net.sf.json.JSONObject;
import au.com.toyota.nc.common.model.hibernate.DMSProduct;

/**
 * User: Alex Wibowo
 * Date: Mar 18, 2009
 * Time: 2:50:53 AM
 */
public class DMSProductJSONAdapter implements JSONAdapter{

    public static final String PROPERTY_ID = "id";
    public static final String PROPERTY_NAME = "name";
    
    private DMSProduct product;

    public DMSProductJSONAdapter(DMSProduct product) {
        this.product = product;
    }

    public JSONObject toJSONObject() {
        JSONObject result = new JSONObject();
        result.put(PROPERTY_ID,product.getDmsProductId());
        result.put(PROPERTY_NAME,product.getName());
        return result;
    }
}
