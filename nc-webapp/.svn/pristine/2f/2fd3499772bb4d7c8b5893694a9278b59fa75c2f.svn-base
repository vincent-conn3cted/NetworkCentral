package au.com.toyota.nc.webapp.stripes.staff;

import au.com.toyota.nc.common.model.hibernate.TMCAStaff;
import au.com.toyota.nc.webapp.adapter.TMCAStaffJSONAdapter;
import au.com.toyota.nc.webapp.stripes.AjaxResolution;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.Resolution;
import org.apache.log4j.Logger;

import java.text.MessageFormat;

/**
 * User: Alex Wibowo
 * Date: 04/03/2009
 * Time: 4:50:29 PM
 */
public class TMCAStaffSearchActionBean extends BaseActionBean {
    private static final Logger LOG = Logger.getLogger(TMCAStaffSearchActionBean.class.getName());

    public static final String EVENT_GET_STAFF = "getTMCAStaff";

    private Long staffId;

    @HandlesEvent(EVENT_GET_STAFF)
    public Resolution getTMCAStaff() {
        LOG.info(MessageFormat.format("Fetching TMCA Staff with id [{0}]", staffId));
        TMCAStaff tmcaStaff = staffServices.getTMCAStaff(staffId);
        return new AjaxResolution(new TMCAStaffJSONAdapter(tmcaStaff).toJSONObject());
    }

    public Long getStaffId() {
        return staffId;
    }

    public void setStaffId(Long staffId) {
        this.staffId = staffId;
    }
}
