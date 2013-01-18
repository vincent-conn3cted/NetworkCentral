package au.com.toyota.nc.webapp.adapter;

import net.sf.json.JSONObject;
import net.sf.json.JSONArray;
import au.com.toyota.nc.common.model.hibernate.DMSVendor;
import au.com.toyota.nc.common.model.hibernate.DMSProduct;
import au.com.toyota.nc.common.model.hibernate.DMSVendorContact;
import au.com.toyota.nc.common.model.hibernate.DMSContactPerson;

/**
 * User: Alex Wibowo
 * Date: Mar 18, 2009
 * Time: 2:50:44 AM
 */
public class DMSVendorJSONAdapter implements JSONAdapter{
    public static final String PROPERTY_ID = "id";
    public static final String PROPERTY_NAME = "name";
    public static final String PROPERTY_PRODUCTS = "products";
    public static final String PROPERTY_CONTACT_PEOPLE = "contactPeople";


    private DMSVendor vendor;

    public DMSVendorJSONAdapter(DMSVendor vendor) {
        this.vendor = vendor;
    }

    public JSONObject toJSONObject() {
        JSONObject result = new JSONObject();
        result.put(PROPERTY_ID, vendor.getDmsVendorId());
        result.put(PROPERTY_NAME, vendor.getName());

        {
            JSONArray jsonProducts = new JSONArray();
            for (DMSProduct dmsProduct : vendor.getProducts()) {
                jsonProducts.put(new DMSProductJSONAdapter(dmsProduct).toJSONObject());
            }
            result.put(PROPERTY_PRODUCTS, jsonProducts);
        }
        {
            JSONArray jsonContacts  = new JSONArray();
            for (DMSContactPerson contact : vendor.getContacts()) {
                jsonContacts.put(new DMSContactPersonJSONAdapter(contact).toJSONObject());
            }
            result.put(PROPERTY_CONTACT_PEOPLE, jsonContacts);
        }
        return result;
    }
}
