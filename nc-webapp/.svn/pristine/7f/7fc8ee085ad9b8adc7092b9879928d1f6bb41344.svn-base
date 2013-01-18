package au.com.toyota.nc.webapp.adapter;

import net.sf.json.JSONObject;
import au.com.toyota.nc.common.model.hibernate.DMSContactPerson;

/**
 * User: Alex Wibowo
 * Date: Mar 21, 2009
 * Time: 2:10:16 AM
 */
public class DMSContactPersonJSONAdapter implements JSONAdapter{

    public static final String PROPERTY_ID = "id";
    public static final String PROPERTY_NAME = "name";
    public static final String PROPERTY_CONTACT = "contact";

    private DMSContactPerson contactPerson;

    public DMSContactPersonJSONAdapter(DMSContactPerson contactPerson) {
        this.contactPerson = contactPerson;
    }

    public JSONObject toJSONObject() {
        JSONObject result = new JSONObject();
        result.put(PROPERTY_ID, contactPerson.getDmsContactPersonId());
        result.put(PROPERTY_NAME, contactPerson.getName());
        result.put(PROPERTY_CONTACT, ContactJSONAdapterFactory.createAdapter(contactPerson.getContact()).toJSONObject());
        return result;
    }
}
