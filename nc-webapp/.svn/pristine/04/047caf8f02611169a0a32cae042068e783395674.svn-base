package au.com.toyota.nc.webapp.taglibs;

import au.com.toyota.nc.common.security.NCFieldPermission;
import au.com.toyota.nc.common.security.NCFieldSecurityMapper;
import com.toyota.ibus.common.util.Str;
import net.sourceforge.stripes.exception.StripesJspException;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.integration.spring.SpringHelper;
import net.sourceforge.stripes.tag.InputSelectTag;
import org.apache.log4j.Logger;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import java.io.IOException;
import java.text.MessageFormat;

/**
 * Extension of Stripes' {@link InputSelectTag} which uses uses {@link NCFieldSecurityMapper}
 * to consult whether to display the input as input field, label, or not to display at all.
 *
 * User: Alex Wibowo
 * Date: Mar 11, 2009
 * Time: 4:12:55 AM
 */
public class NCSelectTag extends InputSelectTag {
    private static final Logger LOG = Logger.getLogger(NCSelectTag.class.getName());

    public static final String DEFAULT_READONLY_CLASS = "formValue";

    @SpringBean
    private NCFieldSecurityMapper securityMapper;

    private String readOnlyClass;

    private Boolean bodyIncluded;

    private Object readOnlyValue;

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

    public int doStartInputTag() throws JspException {
        NCFieldPermission ncFieldPermission = helper.getFieldPermission(getName());

        switch (ncFieldPermission) {
            case Write:
                bodyIncluded = true;
                return super.doStartInputTag();
            case Read:
                // Figure out where to pull the value from
                bodyIncluded = false;
                writeAsSpanLabel();
                return SKIP_BODY;
            case None:
                bodyIncluded = false;
                return SKIP_BODY;
            default:
                throw new IllegalArgumentException("Invalid field permission " + ncFieldPermission);
        }
    }

    private void writeAsSpanLabel() throws JspException {
        try {
                JspWriter writer = getPageContext().getOut();
                if (getId() != null) {
                    set("id", getId());
                }
                set("class", !Str.isEmpty(readOnlyClass) ? readOnlyClass : DEFAULT_READONLY_CLASS);

                writeOpenTag(getPageContext().getOut(), "span");
                writer.print(readOnlyValue!=null?format(readOnlyValue):"");
                writeCloseTag(getPageContext().getOut(), "span");
        } catch (IOException ioe) {
            JspException jspe = new JspException(
                    MessageFormat.format("IOException encountered while writing value  [{0}] to the JspWriter.", readOnlyValue), ioe);
            LOG.warn(jspe);
            throw jspe;
        } finally {
            if (getId() != null) {
                getAttributes().remove("id");
            }
            getAttributes().remove("class");
        }
    }

    public int doEndInputTag() throws JspException {
        if (bodyIncluded) {
            return super.doEndInputTag();
        } else {
            return EVAL_PAGE;
        }
    }

    public void release() {
        super.release();
        readOnlyClass = null;
        bodyIncluded = null;
        securityMapper=null;
        helper=null;
    }

    public String getReadOnlyClass() {
        return readOnlyClass;
    }

    public void setReadOnlyClass(String readOnlyClass) {
        this.readOnlyClass = readOnlyClass;
    }

    public Object getReadOnlyValue() {
        return readOnlyValue;
    }

    public void setReadOnlyValue(Object readOnlyValue) {
        this.readOnlyValue = readOnlyValue;
    }
}
