package au.com.toyota.nc.webapp.adapter;

import au.com.toyota.nc.common.model.DealerLocationSearchResponse;
import au.com.toyota.nc.common.model.hibernate.Dealer;
import au.com.toyota.nc.common.model.hibernate.Location;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;

/**
 * User: Alex Wibowo
 * Date: 25/11/2008
 * Time: 17:51:03
 */
public class DealerLocationSearchResponseJSONAdapter implements JSONAdapter{
    private static final Logger LOGGER = Logger.getLogger(DealerLocationSearchResponseJSONAdapter.class.getName());
    public static final String PROPERTYNAME_LOCATIONS = "locations";

    protected DealerLocationSearchResponse rsp;

    public DealerLocationSearchResponseJSONAdapter(DealerLocationSearchResponse rsp) {
        this.rsp = rsp;
    }

    public JSONObject toJSONObject(){
        JSONObject result = new JSONObject();
        JSONArray locations = new JSONArray();
        for (Dealer dealer: rsp.getDealers()) {
            if (!dealer.getLocations().isEmpty()) {
                for (Location location : dealer.getLocations()) {
                    JSONObject jsonLocation = new LocationJSONAdapter(location).toJSONObject();
                    locations.put(jsonLocation);
                }
            }else {
                JSONObject jsonLocation = new NullLocationJSONAdapter(dealer).toJSONObject();
                locations.put(jsonLocation);
            }
        }
        result.put(PROPERTYNAME_LOCATIONS, locations);
        return result;
    }


}
