package au.com.toyota.nc.webapp.stripes.dealerLocations;

import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.RedirectResolution;

import org.apache.log4j.Logger;

import java.util.Map;
import java.util.List;

import au.com.toyota.nc.common.security.NCRole;
import au.com.toyota.nc.common.staff.exceptions.AppointmentNotFoundException;
import au.com.toyota.nc.common.model.hibernate.Dealer;
import au.com.toyota.nc.common.model.DealerLocationSearchRequest;

/**
 * User: Alex Wibowo
 * Date: 3/02/2009
 * Time: 10:45:52
 */
public class DealerLocationMenuActionBean extends BaseDealerLocationActionBean {
    private static final Logger LOG = Logger.getLogger(DealerLocationMenuActionBean.class.getName());

    @DefaultHandler
    public Resolution displayMenuPage() throws AppointmentNotFoundException {
        if (context.isUserInRole(NCRole.DealerUpdater)) {
            LOG.info("Logged in user has DealerUpdater role. Redirect to 'ViewMyDealerLocation'");
            return new RedirectResolution(ViewMyDealerLocationActionBean.class);
        }else{
            return new ForwardResolution(DEALER_JSP_BASE + "/manageDealershipLocationMenu.jsp");
        }
    }

}
