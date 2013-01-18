package au.com.toyota.nc.webapp.adapter;

import net.sf.json.JSONObject;
import au.com.toyota.nc.common.model.hibernate.AbstractContact;

/**
 * User: Alex Wibowo
 * Date: Mar 18, 2009
 * Time: 2:59:16 AM
 */
public class ContactJSONAdapter implements JSONAdapter{
    public static final String PROPERTY_ID = "id";
    public static final String PROPERTY_STREET_ADDRESS1 = "streetAddress1";
    public static final String PROPERTY_STREET_ADDRESS2 = "streetAddress2";
    public static final String PROPERTY_STREET_SUBURB = "streetSuburb";
    public static final String PROPERTY_STREET_STATE = "streetState";
    public static final String PROPERTY_PHONE = "phone";
    public static final String PROPERTY_MOBILE = "mobile";
    public static final String PROPERTY_FAX = "fax";
    public static final String PROPERTY_EMAIL = "email";
    public static final String PROPERTY_SHORT_DIAL= "shortDial";

    private AbstractContact contact;

    public ContactJSONAdapter(AbstractContact contact) {
        this.contact = contact;
    }

    public JSONObject toJSONObject() {
        JSONObject result = new JSONObject();
        result.put(PROPERTY_ID, contact.getContactId());
        if (contact.getStreetAddress() != null) {
            result.put(PROPERTY_STREET_ADDRESS1,
                    contact.getStreetAddress().getAddress1());
            result.put(PROPERTY_STREET_ADDRESS2,
                    contact.getStreetAddress().getAddress2());
            result.put(PROPERTY_STREET_STATE, contact.getStreetAddress().getState());
            result.put(PROPERTY_STREET_SUBURB, contact.getStreetAddress().getSuburb());
        }
        result.put(PROPERTY_MOBILE, contact.getMobile());
        result.put(PROPERTY_FAX, contact.getFax());
        result.put(PROPERTY_EMAIL, contact.getEmail());
        result.put(PROPERTY_PHONE, contact.getPhone());
        result.put(PROPERTY_SHORT_DIAL, contact.getShortDial());
        return result;
    }
}
