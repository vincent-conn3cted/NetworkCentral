package au.com.toyota.nc.webapp.adapter;

import au.com.toyota.nc.common.model.hibernate.AbstractContact;

/**
 * User: Alex Wibowo
 * Date: Mar 18, 2009
 * Time: 4:04:05 AM
 */
public class ContactJSONAdapterFactory {

    public static ContactJSONAdapter createAdapter(AbstractContact contact){
        return contact!=null? new ContactJSONAdapter(contact): new NullContactJSONAdapter();
    }
}
