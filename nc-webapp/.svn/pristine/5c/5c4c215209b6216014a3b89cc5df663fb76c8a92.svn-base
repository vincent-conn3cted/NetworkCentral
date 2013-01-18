package au.com.toyota.nc.webapp.stripes;

import au.com.toyota.isd.common.ldap.model.User;
import au.com.toyota.nc.common.auth.LoginService;
import au.com.toyota.nc.common.model.hibernate.Dealer;
import au.com.toyota.nc.common.model.hibernate.ToyotaFranchise;
import au.com.toyota.nc.common.security.NCRole;
import au.com.toyota.nc.common.staff.exceptions.MultipleRolesException;
import au.com.toyota.nc.common.utils.NCConstants;
import au.com.toyota.nc.webapp.dataproxy.NCRoleDataProxy;
import au.com.toyota.nc.webapp.util.HttpRequestHelper;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.LocalizableMessage;
import net.sourceforge.stripes.action.Message;
import net.sourceforge.stripes.action.SimpleMessage;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.validation.LocalizableError;
import net.sourceforge.stripes.validation.SimpleError;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Custom action bean context for Network Central
 * <p/>
 * User: Alex Wibowo
 * Date: 30/01/2009
 * Time: 10:41:58
 */
public class NCActionBeanContext extends ActionBeanContext {
    private static final Logger LOG = Logger.getLogger(NCActionBeanContext.class.getName());

    private static final String X_FORWARDED_FOR = "X-Forwarded-For";

    public static final  String REQ_ATTR_WARNINGS = "_stripes_warnings";

    @SpringBean
    private NCRoleDataProxy ncRoleDataProxy;

    @SpringBean
    private HttpRequestHelper requestHelper;

    @SpringBean
    private LoginService loginService;

    @SuppressWarnings("deprecation")
    public void setViewingDealer(Dealer dealer) {
        getSession().setAttribute(NCConstants.SESSION_KEY_VIEWING_DEALER, dealer);
    }

    @SuppressWarnings("deprecation")
    public Dealer getViewingDealer() {
        return getSessionAttribute(NCConstants.SESSION_KEY_VIEWING_DEALER, Dealer.class);
    }


    /**
     * @return IP adddress of the incoming request
     */
    public String getRemoteIPAddress(){
        HttpServletRequest request = getRequest();
        return requestHelper.getRemoteIPAddress(request);
    }

    /**
     * @return warning messages
     */
    public List<Message> getWarnings() {
        return super.getMessages(REQ_ATTR_WARNINGS);
    }


     /**
     * Check if currently we are in any of the specified events
     *
     * @param events event names to check against
     * @return <code>true</code> if the context matches any of the given events
     */
    public boolean isInAnyEvents(final String... events) {
        String currentEvent = getEventName();
        for (String anEvent : events) {
            if (anEvent.equals(currentEvent)){
                return true;
            }
        }
        return false;
    }


    /**
     * Set user details & user role in session
     * @see #getUserDetails()
     * @see #getUserRole()
     * @param user {@link User} details to be saved in the session
     * @throws au.com.toyota.nc.common.staff.exceptions.MultipleRolesException if user has multiple roles. This can happen if dealer user has both internal NC role & dealer NC role (multiple)
     */
    public void setUserDetails(User user){
        try
        {
            NCRole role = ncRoleDataProxy.getApplicationRole(getRequest(), user);
            LOG.info("The final role for user [] is ["+role+"]");
            if (role != null) {
                getSession().setAttribute(NCConstants.SESSION_KEY_LOGGED_IN_USER, user);
                getSession().setAttribute(NCConstants.SESSION_KEY_USER_ROLE, role);
                saveSuccessfulLogin();
            }else {
                // Theoretically, this cant happen, unless user is outside the Dealer Tree / Internal TMCA user tree
                saveForbiddenLogin();
                addLocalizableGlobalError("message.login.failed");
                getResponse().sendError(HttpServletResponse.SC_FORBIDDEN);
            }
        }
        catch (MultipleRolesException e)
        {
            throw new RuntimeException(e);
        }
        catch (IOException e)
        {
            throw new RuntimeException(e);
        }
    }

     private void saveSuccessfulLogin() {
         String user = getRequest().getRemoteUser();
        String remoteIPAddress = getRemoteIPAddress();
        loginService.saveSuccessLogin(user, remoteIPAddress);
    }

    private void saveForbiddenLogin(){
         String remoteIPAddress = getRemoteIPAddress();
         String user = getRequest().getRemoteUser();
         loginService.saveForbiddenLogin(user, remoteIPAddress);
    }

    /**
     * @return {@link User} from session
     */
    public User getUserDetails() {
        return (User) getSession().getAttribute(NCConstants.SESSION_KEY_LOGGED_IN_USER);
    }

    /**
     * @see #getUserDetails()
     * @return {@link NCRole} for the logged in {@link User}
     */
    public NCRole getUserRole() {
        return (NCRole) getSession().getAttribute(NCConstants.SESSION_KEY_USER_ROLE);
    }

    public ToyotaFranchise getFranchise()
    {
        return ToyotaFranchise.fromRole(getUserRole());
    }

    public String getLoginId() {
        return getUserDetails().getCn();
    }

    /**
     * @return <code>true</code> if the logged in user belongs to the role given as parameter
     */
    public boolean isUserInRole(NCRole role) {
        return role.equals(getSession().getAttribute(NCConstants.SESSION_KEY_USER_ROLE));
    }



    //------------------------ ERRORS & MESSAGES -----------------------------------------------
    /**
     * Add localizable validation error message
     *
     * @param field the field in error
     * @param messageKey error message key in Stripes resources
     * @param params parameter to the message in the Stripes resources
     */
    public void addLocalizableValidationError(String field, String messageKey, Object... params){
        getValidationErrors().add(field,new LocalizableError(messageKey, params));
    }

    /**
      * Add localizable global error
      *
      * @param messageKey error message key in Stripes resource
      * @param params     parameter to the message in the Stripes resources
      */
     public void addLocalizableGlobalError(String messageKey, Object... params) {
         getValidationErrors().addGlobalError(new LocalizableError(messageKey, params));
     }


     /**
      * Add localizable global warning
      *
      * @param messageKey warning message key in Stripes resource
      * @param params parameter to the message in the Stripes resource
      */
     public void addLocalizableGlobalWarning(String messageKey, Object... params) {
         getWarnings().add(new LocalizableMessage(messageKey, params));
     }

     /**
      * Add simple global warning
      *
      * @param message warning message
      */
     public void addSimpleGlobalWarning(String message) {
         getWarnings().add(new SimpleMessage(message));
     }


     /**
      * Add simple validation error message
      *
      * @param field the field in error
      * @param message error message
      * @param params parameter to the error message
      */
     public void addSimpleValidationError(String field, String message, Object... params){
         getValidationErrors().add(field, new SimpleError(message, params));
     }

     /**
      * Add simple global error
      *
      * @param errorMessage error message
      * @param params parameter to the error message
      */
     public void addSimpleGlobalError(String errorMessage, Object... params) {
         getValidationErrors().addGlobalError(new SimpleError(errorMessage, params));
     }

     /**
      * Add localizable global message
      *
      * @param messageKey message key in Stripes resources
      * @param params parameter to the message in the Stripes resources
      */
     public void addLocalizableGlobalMessage(String messageKey, Object... params) {
         getMessages().add(new LocalizableMessage(messageKey, params));
     }

     /**
      * Add simple global message
      *
      * @param message the message
      * @param params parameters to the message
      */
     public void addSimpleGlobalMessage(String message, Object... params) {
         getMessages().add(new SimpleMessage(message, params));
     }

    //------------------------ SESSION OPERATIONS ----------------------------------------------
    protected HttpSession getSession() {
        return getRequest().getSession();
    }

    /**
     * Invalidate session
     */
    public void invalidateSession(){
          getRequest().getSession().invalidate();
    }

    protected void setSessionAttribute(String key, Object value) {
        LOG.info("Setting key " + key + " in session " + getSession().getId());
        getSession().setAttribute(key, value);
    }

    protected <E> E getSessionAttribute(String key, Class<E> c) {
        LOG.info("Getting key " + key + " in session " + getSession().getId());
        return (E) getSession().getAttribute(key);
    }

    protected void removeSessionAttribute(String key) {
        LOG.info("Removing key " + key + " from session " + getSession().getId());
        getSession().removeAttribute(key);
    }

    public void setRequestAttribute(String key, Object value) {
        LOG.log(Level.INFO,"Setting key " + key + " in request");
        getRequest().setAttribute(key, value);
    }

    public <E> E getRequestAttribute(String key, Class<E> c) {
        LOG.log(Level.INFO,"Removing key " + key + " in request");
        return (E) getRequest().getAttribute(key);
    }


}
