package au.com.toyota.nc.webapp.taglibs;

import au.com.toyota.nc.common.security.NCFieldPermission;
import au.com.toyota.nc.common.security.NCFieldSecurityMapper;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.integration.spring.SpringHelper;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class NCEvalAccessTag extends BodyTagSupport
{
    @SpringBean
    private NCFieldSecurityMapper securityMapper;

    private NCTagHelper helper;

    public NCEvalAccessTag()
    {
        super();
    }

    //for mocks
    NCEvalAccessTag(NCTagHelper helper)
    {
        this.helper = helper;
    }

    public void setPageContext(PageContext pageContext)
    {
        super.setPageContext(pageContext);
        SpringHelper.injectBeans(this, pageContext.getServletContext());
        this.helper = new NCTagHelper(securityMapper, pageContext);
    }

    public int doStartTag() throws JspException
    {
        NCFieldPermission ncFieldPermission = helper.getFieldPermission("evalAccess");
        switch (ncFieldPermission)
        {
            case ConditionalRestrict:
                return EVAL_BODY_INCLUDE;
            case DoNotRestrict:
                return SKIP_BODY;
            default:
                throw new IllegalArgumentException("Invalid field permission " + ncFieldPermission);
        }
    }

    public void release()
    {
        super.release();
        securityMapper = null;
        helper = null;
    }
}
