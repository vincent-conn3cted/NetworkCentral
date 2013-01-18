package au.com.toyota.nc.webapp.taglibs;

import au.com.toyota.nc.common.security.NCPageViewMode;
import au.com.toyota.nc.common.utils.NCConstants;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import java.util.logging.Logger;

/**
 * Evaluate the body tag if the page view mode is equals to the given parameter. Default to include the body, if
 * no page view mode was specified
 * 
 * User: Alex Wibowo
 * Date: Apr 28, 2009
 * Time: 11:35:29 AM
 */
public class NCIfPageViewModeTag extends BodyTagSupport {
    private static final Logger LOG = Logger.getLogger(NCIfPageViewModeTag.class.getName());

    private String mode;


    public int doStartTag() throws JspException {
        NCPageViewMode viewMode= (NCPageViewMode) pageContext.getAttribute(NCConstants.JSP_PAGE_VIEW_MODE_ATTRIBUTE);
        if (viewMode == null || NCPageViewMode.valueOf(mode).equals(viewMode)) {
            return EVAL_BODY_INCLUDE;
        }else {
            return SKIP_BODY;
        }
    }

    public void release() {
        super.release();
        mode=null;
    }

    public String getMode() {
        return mode;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }
}
