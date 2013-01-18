package au.com.toyota.nc.webapp.adapter;

import au.com.toyota.nc.common.model.DealerStaffSearchResponse;
import au.com.toyota.nc.common.model.hibernate.DealerStaff;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;

/**
 * User: Alex Wibowo
 * Date: 20/11/2008
 * Time: 17:25:21
 */
public class DealerStaffSearchResponseJSONAdapter implements JSONAdapter{
    private static final Logger LOGGER = Logger.getLogger(DealerStaffSearchResponseJSONAdapter.class.getName());
    public static final String PROPERTY_USERS = "users";

    protected DealerStaffSearchResponse rsp;

    public DealerStaffSearchResponseJSONAdapter(DealerStaffSearchResponse rsp) {
        this.rsp = rsp;
    }

    public JSONObject toJSONObject(){
        JSONObject result = new JSONObject();
        JSONArray users = new JSONArray();
        for (DealerStaff dealerStaff : rsp.getUsers()) {
            JSONObject jsonDealershipUser = new DealerStaffJSONAdapter(dealerStaff).toJSONObject();
            users.put(jsonDealershipUser);
        }
        result.put(PROPERTY_USERS, users);
        return result;
    }

}
