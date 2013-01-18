package au.com.toyota.nc.webapp.stripes;

import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.Resolution;

import org.apache.log4j.Logger;

public class AdministrationAccessDeniedAction extends BaseActionBean
{
    private static final Logger LOG = Logger.getLogger(AdministrationAccessDeniedAction.class.getName());

    @DefaultHandler
    public Resolution goErrorPage()
    {
        LOG.info("Administration access denied!");
        return new ForwardResolution(JSP_BASE + "/accessDeniedPage.jsp");
    }

}
