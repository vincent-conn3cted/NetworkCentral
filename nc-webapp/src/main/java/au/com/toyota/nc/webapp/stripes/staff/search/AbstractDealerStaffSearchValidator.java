package au.com.toyota.nc.webapp.stripes.staff.search;

import au.com.toyota.nc.common.model.DealerStaffSearchRequest;
import au.com.toyota.nc.common.model.hibernate.Department;
import au.com.toyota.nc.common.model.hibernate.State;
import au.com.toyota.nc.common.model.search.RegionSearchOption;

public class AbstractDealerStaffSearchValidator
{
    protected final RegionSearchOption region;
    protected final State state;
    protected final Department department;
    protected final Long position;
    protected final String firstname;
    protected final String surname;
    protected final Long dealerStaffNo;
    protected final String dealerName;
    protected final String locationSuburb;

    public AbstractDealerStaffSearchValidator(DealerStaffSearchRequest dealerStaffSearchRequest)
    {
        // bulk return parameters
        region = dealerStaffSearchRequest.getDealerRegion();
        state = dealerStaffSearchRequest.getLocationState();
        position = dealerStaffSearchRequest.getPosition();
        department = dealerStaffSearchRequest.getDepartment();

        // fine return parameters
        firstname = dealerStaffSearchRequest.getFirstname();
        surname = dealerStaffSearchRequest.getSurname();
        dealerStaffNo = dealerStaffSearchRequest.getDealerStaffNo();
        dealerName = dealerStaffSearchRequest.getDealerName();
        locationSuburb = dealerStaffSearchRequest.getLocationSuburb();
    }

    protected int getFieldLength(Object value)
    {
        if (value != null)
        {
            return value.toString().trim().length();
        }
        else
        {
            return 0;
        } // when item can not be found
    }
}
