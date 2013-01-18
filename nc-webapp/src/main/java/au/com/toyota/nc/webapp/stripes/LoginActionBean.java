package au.com.toyota.nc.webapp.stripes;

import au.com.toyota.nc.common.auth.LoginService;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.integration.spring.SpringBean;
import org.apache.log4j.Logger;

public class LoginActionBean extends BaseActionBean
{
    private static final Logger LOG = Logger.getLogger(LoginActionBean.class.getName());

    public static final String EVENT_SHOW_FAILED_LOGIN = "showFailedLogin";

    @SpringBean
    private LoginService loginService;

    @DefaultHandler
    public Resolution show()
    {
        LOG.info("Displaying the login page");
        getContext().invalidateSession();
        return new ForwardResolution(JSP_BASE + "/login.jsp");
    }

    @HandlesEvent(EVENT_SHOW_FAILED_LOGIN)
    public Resolution showFailedLogin()
    {
        LOG.info("Login failed. Saving and forward to login errors page");
        String user = context.getRequest().getParameter("j_username");
        String password = context.getRequest().getParameter("j_password");
        String remoteIPAddress = context.getRemoteIPAddress();

        loginService.saveFailedLogin(user, password, remoteIPAddress);
        addLocalizableGlobalError("message.login.failed");
        return new ForwardResolution(JSP_BASE + "/loginError.jsp");
    }
}
