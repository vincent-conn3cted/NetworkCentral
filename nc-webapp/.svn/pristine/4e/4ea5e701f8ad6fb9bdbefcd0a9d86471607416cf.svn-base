package au.com.toyota.nc.webapp.adapter;

import org.apache.log4j.Logger;
import au.com.toyota.nc.webapp.adapter.JSONAdapter;
import au.com.toyota.nc.common.model.hibernate.TMCAStaff;
import net.sf.json.JSONObject;
import net.sf.json.JSONArray;

/**
 * {@link JSONAdapter} for {@link TMCAStaff}
 * <p/>
 * User: Alex Wibowo
 * Date: 04/03/2009
 * Time: 4:52:16 PM
 */
public class TMCAStaffJSONAdapter implements JSONAdapter {
    private static final Logger LOG = Logger.getLogger(TMCAStaffJSONAdapter.class.getName());

    public static final String PROPERTY_FIRSTNAME = "firstname";
    public static final String PROPERTY_SURNAME = "surname";
    public static final String PROPERTY_TMCAPIN = "tmcapin";
    public static final String PROPERTY_CONTACT = "contact";

    private TMCAStaff staff;

    public TMCAStaffJSONAdapter(TMCAStaff staff) {
        this.staff = staff;
    }

    public JSONObject toJSONObject() {
        JSONObject result = new JSONObject();
        result.put(PROPERTY_FIRSTNAME, staff.getFirstname());
        result.put(PROPERTY_SURNAME, staff.getSurname());
        result.put(PROPERTY_TMCAPIN, staff.getTmcaPIN());

        result.put(PROPERTY_CONTACT, new ContactJSONAdapter(staff.getContact()).toJSONObject());        
        return result;
    }
}
