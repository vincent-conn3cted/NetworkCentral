package au.com.toyota.nc.webapp.taglibs;

import au.com.toyota.nc.common.security.NCFieldPermission;
import au.com.toyota.nc.common.security.NCFieldSecurityMapper;
import net.sourceforge.stripes.exception.StripesJspException;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.integration.spring.SpringHelper;
import net.sourceforge.stripes.tag.InputHiddenTag;
import org.apache.log4j.Logger;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import java.text.MessageFormat;

/**
 * Extension of   Stripes' {@link InputHiddenTag} to render hidden element. It uses  {@link NCFieldSecurityMapper}
 * to consult whether or not to display the field
 *
 * User: Alex Wibowo
 * Date: Mar 13, 2009
 * Time: 5:47:04 AM
 */
public class NCHiddenTag extends InputHiddenTag {
    private static final Logger LOG = Logger.getLogger(NCTextTag.class.getName());

    @SpringBean
    private NCFieldSecurityMapper securityMapper;

    private  NCTagHelper helper;


    public void setPageContext(PageContext pageContext) {
        super.setPageContext(pageContext);
        SpringHelper.injectBeans(this, getPageContext().getServletContext());
        this.helper= new NCTagHelper(securityMapper, getPageContext());
    }

    /**
     * We are overriding this tag, because Stripes will call this method on doStartTag()
     * method, and on doEndInputTag() method, stripes will render all registered field,
     * and on binding, Stripes will set all missing fields in the request with null.
     * We dont want this behaviour on the fields that we set to read-only. We dont want
     * those fields to be registered in the first place, so that Stripes mechanism to
     * set missing fields wont set those fields.
     *
     * @see net.sourceforge.stripes.controller.DefaultActionBeanPropertyBinder#bind(net.sourceforge.stripes.action.ActionBean, net.sourceforge.stripes.action.ActionBeanContext, boolean)
     * @see net.sourceforge.stripes.controller.DefaultActionBeanPropertyBinder#bindMissingValuesAsNull(net.sourceforge.stripes.action.ActionBean, net.sourceforge.stripes.action.ActionBeanContext)
     * @throws StripesJspException
     */
    protected void registerWithParentForm() throws StripesJspException {
        NCFieldPermission ncFieldPermission = helper.getFieldPermission(getName());
        switch (ncFieldPermission) {
            case Write:
                super.registerWithParentForm();
                break;
            default:
                LOG.debug(MessageFormat.format("Not registering field [{0}] as user doesnt have write access",getName()));
        }
    }

    public int doEndInputTag() throws JspException {
        NCFieldPermission ncFieldPermission = helper.getFieldPermission(getName());
        switch (ncFieldPermission) {
            case Write:
                return super.doEndInputTag();
            case Read:
            case None:
                return EVAL_PAGE;
            default:
                throw new IllegalArgumentException("Invalid field permission " + ncFieldPermission);
        }
    }

    public void release() {
        super.release();
        securityMapper=null;
        helper=null;

    }
}
