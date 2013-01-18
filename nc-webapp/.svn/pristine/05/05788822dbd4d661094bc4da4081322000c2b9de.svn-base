package au.com.toyota.nc.webapp.stripes;

import au.com.toyota.nc.common.auth.LoginService;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.integration.spring.SpringBean;
import org.apache.log4j.Logger;

public class HomeActionBean extends BaseActionBean
{
    private static final Logger LOG = Logger.getLogger(HomeActionBean.class.getName());

    @SpringBean
    private LoginService loginService;

    @DefaultHandler
    public Resolution displayHome()
    {
        LOG.info("Displaying the home page");
        final Resolution resolution;
        if (!isLoginDetailsPresent()) {
            populateUserDetails();
        }
        if (getContext().getUserDetails()!=null && loginService.isVirtualEntity(getContext().getUserDetails()))
        {
            getContext().invalidateSession();
            addSimpleGlobalError("The username entered does not correspond to a valid Network Central user");
            resolution = new ForwardResolution(JSP_BASE + "/loginError.jsp");
        }
        else
        {
            resolution = new ForwardResolution(JSP_BASE + "/home.jsp");
        }
        return resolution;
    }
}
