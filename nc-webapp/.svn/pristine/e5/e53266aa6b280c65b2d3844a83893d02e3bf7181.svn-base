package au.com.toyota.nc.webapp.stripes.ext.handlers;

import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.exception.ActionBeanNotFoundException;
import net.sourceforge.stripes.exception.AutoExceptionHandler;
import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.MessageFormat;
import java.util.Map;

/**
 * Implementation of {@link net.sourceforge.stripes.exception.AutoExceptionHandler}
 * <p/>
 * Date: Aug 14, 2009
 * Time: 3:43:41 PM
 *
 * @author Alex Wibowo
 */
public class ExceptionHandler extends AbstractExceptionHandler implements AutoExceptionHandler
{
    private static final Logger LOG = Logger.getLogger(ExceptionHandler.class.getName());

    public Resolution handle(Throwable exception, HttpServletRequest req, HttpServletResponse res)
    {
        if (exception instanceof ActionBeanNotFoundException)
        {
            LOG.debug("Attempt to access Invalid action bean");
            return handleInvalidActionBean(res);
        }
        else
        {
            LOG.error(MessageFormat.format("An exception has occurred while handling the request", req.getRequestURL()), exception);
            return handleServerError(exception, req, res);
        }
    }

    private Resolution handleInvalidActionBean(HttpServletResponse res)
    {
        Resolution resolution = new ForwardResolution("/WEB-INF/jsp/nc/invalidPage.jsp");
        res.setStatus(HttpServletResponse.SC_NOT_FOUND);
        return resolution;
    }

    private Resolution handleServerError(Throwable exception, HttpServletRequest req, HttpServletResponse res)
    {
        Resolution resolution = new ForwardResolution("/WEB-INF/jsp/nc/serverError.jsp");
        req.setAttribute("error", exception);
        res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        notifyOfError(exception, req);
        return resolution;
    }

    private void notifyOfError(Throwable exception, HttpServletRequest req)
    {
        final Map<Object, ExceptionListener> exceptionListeners = getSpringApplicationContext(req).getBeansOfType(ExceptionListener.class);
        for (ExceptionListener exceptionListener : exceptionListeners.values())
        {
            exceptionListener.notify(exception);
        }
    }
}
