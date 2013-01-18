package au.com.toyota.nc.webapp.adapter;

import au.com.toyota.nc.common.model.hibernate.DealerStaff;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;

/**
 * User: Alex Wibowo
 * Date: 20/11/2008
 * Time: 17:28:53
 */
public class DealerStaffJSONAdapter implements JSONAdapter{
    private static final Logger LOGGER = Logger.getLogger(DealerStaffJSONAdapter.class.getName());
    public static final String PROPERTY_DEALER_STAFF_NO = "dealerStaffNo";
    public static final String PROPERTY_FIRSTNAME = "firstname";
    public static final String PROPERTY_SURNAME = "surname";
    public static final String PROPERTY_DOB = "dob";
    public static final String PROPERTY_DEALER_NAME = "dealerName";
    public static final String PROPERTY_PRIMARY_LOCATION_ID = "primaryLocationId";
    public static final String PROPERTY_PRIMARY_LOCATION_SUBURB = "primaryLocationSuburb";
    public static final String PROPERTY_PRIMARY_LOCATION_NAME = "primaryLocationName";
    public static final String PROPERTY_PRIMARY_POSITION = "primaryPosition";
    public static final String PROPERTY_TELEPHONE = "telephone";

    private DealerStaff user;

    public DealerStaffJSONAdapter(DealerStaff user) {
        this.user = user;
    }

    public JSONObject toJSONObject(){
        JSONObject result = new JSONObject();
        result.put(PROPERTY_DEALER_STAFF_NO, user.getPersonId());
        result.put(PROPERTY_FIRSTNAME,user.getFirstname());
        result.put(PROPERTY_SURNAME,user.getSurname());
        result.put(PROPERTY_DOB, user.getDob()); //TODO: format
//        result.put(PROPERTY_DEALER_NAME, user.getPrimaryAppointment().getLocation().getDealer().getGeneralInfo().getDealerName());
//        result.put(PROPERTY_PRIMARY_LOCATION_ID, user.getPrimaryAppointment().getLocation().getLocationId());
//        result.put(PROPERTY_PRIMARY_LOCATION_SUBURB, user.getPrimaryPosition().getLocation().getLocationName());
//        result.put(PROPERTY_PRIMARY_LOCATION_NAME, user.getPrimaryAppointment().getLocation().getLocationName());
//        result.put(PROPERTY_PRIMARY_POSITION, user.getPrimaryAppointment().getPosition().getDescription());
       /* result.put(PROPERTY_DEPARTMENT_NUMBER,user.getDepartmentNumber());
        result.put(PROPERTY_POSITION,user.getPosition());
        result.put(PROPERTY_DIVISION,user.getDivision());*/
//        result.put(PROPERTY_TELEPHONE,user.getTelephone());
        return result;
    }
}
