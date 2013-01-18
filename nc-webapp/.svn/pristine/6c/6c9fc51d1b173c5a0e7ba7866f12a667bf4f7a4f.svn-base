package au.com.toyota.nc.webapp.taglibs;

import au.com.toyota.nc.common.utils.NCConstants;
import org.apache.log4j.Logger;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.text.MessageFormat;

/**
 * Taglib to set the required page context attribute for the secured fields
 * <p/>
 * User: Alex Wibowo
 * Date: 06/03/2009
 * Time: 5:02:39 PM
 */
public class NCSecuredPageTag extends TagSupport {
    private static final Logger LOG = Logger.getLogger(NCSecuredPageTag.class.getName());

    private String pageName;

    public int doStartTag() throws JspException {
        if (LOG.isDebugEnabled()) {
            String debugMessage =
                    "\n=====================================================" +
                    "\n Accessing secured page                              " +
                    "\n=====================================================";
            LOG.debug(debugMessage);
            LOG.debug(MessageFormat.format("Setting [{0}] attribute as [{1}]", NCConstants.JSP_PAGE_NAME_ATTRIBUTE, pageName));
        }
        pageContext.setAttribute(NCConstants.JSP_PAGE_NAME_ATTRIBUTE, pageName);
        return super.doStartTag();
    }


    public void release() {
        pageName = null;
        super.release();
    }

    public String getPageName() {
        return pageName;
    }

    public void setPageName(String pageName) {
        this.pageName = pageName;
    }
}
