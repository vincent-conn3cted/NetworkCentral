package au.com.toyota.nc.webapp.stripes.reports;

import au.com.toyota.nc.common.model.hibernate.OtherProduct;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.Resolution;
import org.apache.log4j.Logger;

/**
 * User: Alex Wibowo
 * Date: 12/01/2009
 * Time: 09:35:27
 */
public class ReportsActionBean extends BaseActionBean
{
    private static final Logger LOGGER = Logger.getLogger(ReportsActionBean.class.getName());

    public static final String EVENT_DISPLAY_DEALER_REPORTS_MENU = "displayDealerReportsMenu";

    @DefaultHandler
    public Resolution displayReportsMenu()
    {
        return new ForwardResolution(JSP_BASE + "/reports/menu.jsp");
    }

    @HandlesEvent(EVENT_DISPLAY_DEALER_REPORTS_MENU)
    public Resolution displayDealerReportsMenu()
    {
        return new ForwardResolution(JSP_BASE + "/reports/hardCopy.jsp");
    }

    public OtherProduct getPriusOtherProduct()
    {
        return masterTableServices.getSimilar(OtherProduct.class, OtherProduct.PRIUS_VALUE);
    }

}
