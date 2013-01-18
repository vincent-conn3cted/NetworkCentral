package au.com.toyota.nc.webapp.taglibs;

import org.apache.log4j.Logger;

import javax.servlet.jsp.tagext.BodyTagSupport;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.JspException;

import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.integration.spring.SpringHelper;
import au.com.toyota.nc.common.security.NCFieldSecurityMapper;
import au.com.toyota.nc.common.security.NCRole;

/**
 * Evaluate  the body if the current logged in user is allowed to create dealer/location
 */
public class NCIfAllowCreateDealerLocationTag extends BodyTagSupport {
    private static final Logger LOG = Logger.getLogger(NCIfAllowCreateDealerLocationTag.class.getName());

      @SpringBean
    private NCFieldSecurityMapper securityMapper;

    private  NCTagHelper helper;

    public NCIfAllowCreateDealerLocationTag() {
        super();
    }

    public NCIfAllowCreateDealerLocationTag(NCTagHelper helper) {
        this.helper = helper;
    }

    public void setPageContext(PageContext pageContext) {
        super.setPageContext(pageContext);
       SpringHelper.injectBeans(this, pageContext.getServletContext());
       this.helper= new NCTagHelper(securityMapper, pageContext);
    }

    @Override
    public int doStartTag() throws JspException {
        NCRole userRole = helper.getUserRole();
        if (userRole.isAllowCreateDealerLocation()) {
            LOG.info("User is not allowed to create dealer/location.");
            return EVAL_BODY_INCLUDE;
        }else{
            return SKIP_BODY;
        }
    }

    @Override
    public void release() {
        super.release();
        securityMapper=null;
        helper=null;
    }
}
