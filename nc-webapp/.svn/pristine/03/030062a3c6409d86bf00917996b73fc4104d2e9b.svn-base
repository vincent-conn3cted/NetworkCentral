package au.com.toyota.nc.webapp.adapter;

import au.com.toyota.nc.common.model.hibernate.Dealer;
import au.com.toyota.nc.common.model.hibernate.Location;
import org.apache.log4j.Logger;

/**
 * User: Alex Wibowo
 * Date: 23/02/2009
 * Time: 1:40:33 PM
 */
public class NullLocationJSONAdapter extends LocationJSONAdapter{
    private static final Logger LOG = Logger.getLogger(NullLocationJSONAdapter.class.getName());

    public NullLocationJSONAdapter(Dealer dealer) {
        super(new Location());
        location.setDealer(dealer);
    }

}
