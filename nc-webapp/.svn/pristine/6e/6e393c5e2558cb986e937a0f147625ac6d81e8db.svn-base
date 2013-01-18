package au.com.toyota.nc.webapp.taglibs;

import au.com.toyota.nc.common.security.NCFieldPermission;
import au.com.toyota.nc.common.security.NCFieldSecurityMapper;
import net.sourceforge.stripes.exception.StripesJspException;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.integration.spring.SpringHelper;
import net.sourceforge.stripes.tag.InputCheckBoxTag;
import org.apache.log4j.Logger;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import java.text.MessageFormat;

/**
 * User: Alex Wibowo
 * Date: Mar 12, 2009
 * Time: 12:52:18 AM
 */
public class NCCheckboxTag extends InputCheckBoxTag {
    private static final Logger LOG = Logger.getLogger(NCCheckboxTag.class.getName());

    @SpringBean
    private NCFieldSecurityMapper securityMapper;

    private NCTagHelper helper;

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
                writeAsSpanLabel();
                return EVAL_PAGE;
            case None:
                return EVAL_PAGE;
            default:
                throw new IllegalArgumentException("Invalid field permission " + ncFieldPermission);
        }
    }

    private void writeAsSpanLabel() throws JspException{
        Object value = getSingleOverrideValue();
        try {
            if (getId() != null) {
                set("id", getId());
            }
            getAttributes().remove("type");
            if (Boolean.TRUE.equals(value)) {
                set("class", "checkedImage");
            }else{
                set("class", "unCheckedImage");
            }
            writeOpenTag(getPageContext().getOut(), "span");
            writeCloseTag(getPageContext().getOut(), "span");
        } finally {
            if (getId() != null) {
                getAttributes().remove("id");
            }
            getAttributes().remove("class");
        }
    }
    

    public void release() {
        super.release();
        securityMapper=null;
        helper=null;
    }
}
