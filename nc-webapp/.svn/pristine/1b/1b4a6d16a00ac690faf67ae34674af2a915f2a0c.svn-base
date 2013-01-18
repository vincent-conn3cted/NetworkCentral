package au.com.toyota.nc.webapp.taglibs;

import au.com.toyota.nc.common.security.NCFieldPermission;
import au.com.toyota.nc.common.security.NCFieldSecurityMapper;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.integration.spring.SpringHelper;
import net.sourceforge.stripes.tag.InputLabelTag;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;

/**
 * Extension of Stripes' {@link InputLabelTag} which uses {@link au.com.toyota.nc.common.security.NCFieldSecurityMapper}
 * to consult whether or not to display the label.
 *
 * User: Alex Wibowo
 * Date: 09/03/2009
 * Time: 10:13:29 PM
 */
public class NCLabelTag extends InputLabelTag {

    @SpringBean
    private NCFieldSecurityMapper securityMapper;

    private NCTagHelper helper;

     public void setPageContext(PageContext pageContext) {
        super.setPageContext(pageContext);
       SpringHelper.injectBeans(this, getPageContext().getServletContext());
       this.helper= new NCTagHelper(securityMapper, getPageContext());
    }

    @Override
    public int doEndInputTag() throws JspException {
        NCFieldPermission ncFieldPermission = helper.getFieldPermission(getFor());
        switch(ncFieldPermission){
            case None:
                return EVAL_PAGE;
            default:
                return super.doEndInputTag();
        }
    }

    public void release() {
        super.release();
        securityMapper=null;
        helper=null;
    }
}
