package au.com.toyota.nc.webapp.stripes.ext.handlers;

import org.springframework.web.context.WebApplicationContext;

import javax.servlet.http.HttpServletRequest;

public class AbstractExceptionHandler
{
    protected WebApplicationContext getSpringApplicationContext(HttpServletRequest request)
    {
        return ((WebApplicationContext) request.getSession().getServletContext().getAttribute("org.springframework.web.context.WebApplicationContext.ROOT"));
    }
}
