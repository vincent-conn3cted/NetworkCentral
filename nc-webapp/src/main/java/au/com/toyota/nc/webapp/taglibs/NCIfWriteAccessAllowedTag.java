package au.com.toyota.nc.webapp.taglibs;

import au.com.toyota.nc.common.security.NCFieldPermission;
import au.com.toyota.nc.common.security.NCFieldSecurityMapper;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.integration.spring.SpringHelper;
import org.apache.log4j.Logger;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyTagSupport;

/**
  * Tag to test if logged in user has write access to the given field name, and if so, evaluate the body, otherwise
 * skip it.
 * Uses {@link au.com.toyota.nc.common.security.NCFieldSecurityMapper} to consult for the configuration
 *
 * User: Alex Wibowo
 * Date: Mar 12, 2009
 * Time: 12:11:24 AM
 */
public class NCIfWriteAccessAllowedTag extends BodyTagSupport {
    private static final Logger LOG = Logger.getLogger(NCIfWriteAccessAllowedTag.class.getName());

    @SpringBean
    private NCFieldSecurityMapper securityMapper;

    private String name;

    private  NCTagHelper helper;


   public void setPageContext(PageContext pageContext) {
        super.setPageContext(pageContext);
       SpringHelper.injectBeans(this, pageContext.getServletContext());
       this.helper= new NCTagHelper(securityMapper, pageContext);
    }

    public int doStartTag() throws JspException {
        NCFieldPermission ncFieldPermission = helper.getFieldPermission(getName());
        switch (ncFieldPermission) {
            case Write:
                return EVAL_BODY_INCLUDE;
            case Read:
            case None:
                return SKIP_BODY;
            default:
                throw new IllegalArgumentException("Invalid field permission " + ncFieldPermission);
        }
    }

    public void release() {
        super.release();
        securityMapper = null;
        name = null;
        helper=null;

    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
