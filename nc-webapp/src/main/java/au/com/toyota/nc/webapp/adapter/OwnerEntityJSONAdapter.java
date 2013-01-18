package au.com.toyota.nc.webapp.adapter;

import au.com.toyota.nc.common.model.hibernate.Location;


import net.sf.json.JSONObject;

/**
 * User: Alex Wibowo
 * Date: 25/11/2008
 * Time: 17:47:20
 */
public class OwnerEntityJSONAdapter implements JSONAdapter{

    public static final String PROPERTY_LOCATION_NAME = "locationName";
    public static final String PROPERTY_LOCATION_TYPE = "locationType";
    public static final String PROPERTY_SUBURB = "suburb";
    public static final String PROPERTY_STATE = "state";
    public static final String PROPERTY_TELEPHONE = "telephone";
    public static final String PROPERTY_SHORT_DIAL = "shortDial";

    public static final String PROPERTY_DEALER_ID = "dealerId";
    public static final String PROPERTY_DEALER_NAME = "dealerName";
    public static final String PROPERTY_DEALER_CODE = "dealerCode";
    public static final String PROPERTY_SAP_DEALER_CODE = "sapDealerCode";
    public static final String PROPERTY_REGION = "region";
    public static final String PROPERTY_PMA = "pma";
    public static final String PROPERTY_SHAREHOLDER = "shareHolder";


    private Location location;

    public OwnerEntityJSONAdapter(Location location) {
        this.location = location;
    }

    public JSONObject toJSONObject(){
        JSONObject result = new JSONObject();
        result.put(PROPERTY_LOCATION_NAME, location.getLocationName());
        result.put(PROPERTY_LOCATION_TYPE, location.getType());
        result.put(PROPERTY_SUBURB, location.getContact().getStreetAddress().getSuburb());
        result.put(PROPERTY_STATE, location.getContact().getStreetAddress().getState());
        result.put(PROPERTY_TELEPHONE, location.getContact().getPhone());
        result.put(PROPERTY_SHORT_DIAL, location.getContact().getShortDial());


        result.put(PROPERTY_DEALER_ID, location.getDealer().getDealerId());
        result.put(PROPERTY_DEALER_CODE, location.getDealer().getGeneralInfo().getDealerCode());
        result.put(PROPERTY_DEALER_NAME, location.getDealer().getGeneralInfo().getDealerName());
        result.put(PROPERTY_SAP_DEALER_CODE, location.getDealer().getGeneralInfo().getSapDealerCode());
        result.put(PROPERTY_REGION, location.getDealer().getGeneralInfo().getRegion());
        result.put(PROPERTY_PMA, location.getDealer().getGeneralInfo().getPma().getName());

        return result;
    }
}