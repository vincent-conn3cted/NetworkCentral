package au.com.toyota.nc.webapp.taglibs;

import net.sourceforge.stripes.controller.StripesConstants;
import au.com.toyota.nc.webapp.decorator.RequestDecorator;
import au.com.toyota.nc.webapp.decorator.RequestDecoratorHelper;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;

import org.apache.log4j.Logger;

/**
 * decorate result base on request
 * User: Deepthi Fernando
 * Date: 15/03/2009
 * Time: 10:13:29 PM
 */
public class NCRequestDecoratorTag extends TagSupport {
    private final Logger LOG = Logger.getLogger(NCRequestDecoratorTag.class);

    public int doStartTag() {
     try {
        JspWriter out = pageContext.getOut();
        RequestDecorator requestDecorator = (RequestDecorator)pageContext.getRequest().getAttribute(StripesConstants.REQ_ATTR_ACTION_BEAN);
        out.print(RequestDecoratorHelper.getRequestParameterDecoratorString(requestDecorator.getRequestForDecoration()));
     } catch(IOException ioe) {
        LOG.error("Error in NCRequestDecoratorTag: " + ioe);
     }
     return(SKIP_BODY);
    }

}