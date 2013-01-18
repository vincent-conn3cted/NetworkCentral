package au.com.toyota.nc.webapp.taglibs;

import au.com.toyota.nc.common.security.NCPageViewMode;
import au.com.toyota.nc.common.utils.NCConstants;
import org.apache.log4j.Logger;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.text.MessageFormat;

/**
 * Taglib to set the page view mode
 * <p/>
 * User: Alex Wibowo
 * Date: Mar 21, 2009
 * Time: 3:32:14 AM
 */
public class NCPageViewModeTag extends TagSupport {
    private static final Logger LOG = Logger.getLogger(NCPageViewModeTag.class.getName());

    private Boolean isReadOnly = Boolean.TRUE;

    public int doStartTag() throws JspException {

        NCPageViewMode pageViewMode =isReadOnly? NCPageViewMode.View : NCPageViewMode.Edit;
        if (LOG.isDebugEnabled()) {
            LOG.debug(MessageFormat.format("Setting [{0}] attribute as [{1}]", NCConstants.JSP_PAGE_NAME_ATTRIBUTE, pageViewMode));
        }
        pageContext.setAttribute(NCConstants.JSP_PAGE_VIEW_MODE_ATTRIBUTE, pageViewMode);
        return super.doStartTag();
    }

    public void release() {
        isReadOnly = null;
        super.release();
    }

    public Boolean getReadOnly() {
        return isReadOnly;
    }

    public void setReadOnly(Boolean readOnly) {
        isReadOnly = readOnly;
    }
}
