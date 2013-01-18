package au.com.toyota.nc.webapp.taglibs;

import au.com.toyota.nc.common.security.NCFieldPermission;
import au.com.toyota.nc.common.security.NCFieldSecurityMapper;
import au.com.toyota.nc.webapp.stripes.ext.formatters.NCDateTimeFormatter;
import com.toyota.ibus.common.util.Str;
import net.sourceforge.stripes.exception.StripesJspException;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.integration.spring.SpringHelper;
import net.sourceforge.stripes.tag.InputTextTag;
import org.apache.log4j.Logger;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import java.io.IOException;
import java.text.MessageFormat;

/**
 * Extension of Stripes' {@link InputTextTag} to render input element with calendar popup. It also uses {@link NCFieldSecurityMapper}
 * to consult whether to allow the field to be edited, or just display as label, or nothing at all
 *
 * User: Alex Wibowo
 * Date: Mar 11, 2009
 * Time: 3:24:57 AM
 */
public class NCDateTextTag extends InputTextTag {
    private static final Logger LOG = Logger.getLogger(NCDateTextTag.class.getName());

    public static final String DEFAULT_READONLY_CLASS = "formValue";
    public static final String DEFAULT_CALENDAR_BUTTON_CLASS = "calendarTriggerBtn";

    public static final String DEFAULT_FORMAT_WITH_TIME = "%d-%m-%Y %H:%M";
    public static final String DEFAULT_FORMAT_WITHOUT_TIME = "%d-%m-%Y";

    @SpringBean
    private NCFieldSecurityMapper securityMapper;

    /**
     * CSS class used for rendering the field as label
     */
    private String readOnlyClass;

    /**
     * HTML id of the calendar button
     */
    private String buttonId;

    /**
     * CSS class for the calendar button.
     */
    private String buttonClass;

    private Boolean showTime =Boolean.FALSE;

    private String format;

    private  NCTagHelper helper;

    private boolean skipPermissions = false;


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
        NCFieldPermission ncFieldPermission = getFieldPermission();
        switch (ncFieldPermission) {
            case Write:
                super.registerWithParentForm();
                break;
            default:
                LOG.debug(MessageFormat.format("Not registering field [{0}] as user doesnt have write access",getName()));
        }
    }

    private NCFieldPermission getFieldPermission()
            throws StripesJspException
    {
        NCFieldPermission ncFieldPermission;
        if(skipPermissions)
        {
            ncFieldPermission = NCFieldPermission.Write;
        }
        else
        {
            ncFieldPermission = helper.getFieldPermission(getName());
        }
        return ncFieldPermission;
    }

    /**
     * Determines which source is applicable for the value of the text field and then writes
     * out the tag.
     *
     * @return EVAL_PAGE in all cases.
     * @throws javax.servlet.jsp.JspException if the enclosing form tag cannot be found, or output cannot be written.
     */
    public int doEndInputTag() throws JspException {
        NCFieldPermission ncFieldPermission = getFieldPermission();
        switch (ncFieldPermission) {
            case Write:
                String fieldId = getId();
                getAttributes().put("readonly", "readonly"); // all date text boxes should be readonly so user must use the calendar select popup
                super.doEndInputTag();
                getAttributes().clear();
                writeButtonTag(fieldId);
                getAttributes().clear();
                writeClearFieldButtonTag(fieldId);
                return EVAL_PAGE;
            case Read:
                // Figure out where to pull the value from
               writeAsSpanLabel();
                return EVAL_PAGE;
            case None:
                return EVAL_PAGE;
            default:
                throw new IllegalArgumentException("Invalid field permission " + ncFieldPermission);
        }
    }

    private void writeButtonTag(String fieldId) throws JspException {
        try {
            JspWriter writer = getPageContext().getOut();
            getAttributes().put("id", getButtonId());
            getAttributes().put("class", !Str.isEmpty(buttonClass)?buttonClass: DEFAULT_CALENDAR_BUTTON_CLASS);
            writeOpenTag(getPageContext().getOut(), "button");
            writer.print("&nbsp;");
            writeCloseTag(getPageContext().getOut(), "button");
            String calendarSetupScript = MessageFormat.format("" +
                "<script type=''text/javascript''>" +
                "Calendar.setup('{'" +
                "   inputField: \"{0}\"," +
                "   showsTime: {1}," +
                "   timeFormat: 24," +
                "   ifFormat: \"{2}\"," +
                "   button: \"{3}\"" +
                "});" +
                "</script>",
                    fieldId, showTime,
                format != null ? format : (showTime ? DEFAULT_FORMAT_WITH_TIME : DEFAULT_FORMAT_WITHOUT_TIME),
                buttonId);
            writer.print(calendarSetupScript);
        } catch (IOException ioe) {
             JspException jspe = new JspException("IOException encountered while writing calendar button with id " +
                    getButtonId()+ " to the JspWriter.", ioe);
            LOG.warn(jspe);
            throw jspe;
        } finally {
            getAttributes().remove("id");
            getAttributes().remove("class");
        }
    }

    private void writeClearFieldButtonTag(String fieldId) throws JspException
    {
        try
        {
            getAttributes().put("id", "clear" + getButtonId());
            getAttributes().put("class", "clearCalendarBtn");
            getAttributes().put("onclick", "clearValue('"+fieldId+"');return false;");
            writeOpenTag(getPageContext().getOut(), "button");
            getPageContext().getOut().print("&nbsp;");
            writeCloseTag(getPageContext().getOut(), "button");
        }
        catch (IOException e)
        {
            JspException jspe = new JspException("IOException encountered while writing calendar button with id " +
                   getButtonId()+ " to the JspWriter.", e);
           LOG.warn(jspe);
           throw jspe;
        }
        finally
        {
            getAttributes().remove("id");
            getAttributes().remove("class");
        }
    }

    private void writeAsSpanLabel() throws JspException {
          Object value = getSingleOverrideValue();
          if (value != null) {
              try {
                  JspWriter writer = getPageContext().getOut();
                  set("id", getId());
                  set("class", !Str.isEmpty(readOnlyClass) ? readOnlyClass : DEFAULT_READONLY_CLASS);
                  getAttributes().remove("text");


                  writeOpenTag(getPageContext().getOut(), "span");
                  writer.print(format(value));
                  writeCloseTag(getPageContext().getOut(), "span");
              } catch (IOException ioe) {
                  JspException jspe = new JspException("IOException encountered while writing value " +
                          value + " to the JspWriter.", ioe);
                  LOG.warn(jspe);
                  throw jspe;
              } finally {
                  getAttributes().remove("id");
                  getAttributes().remove("class");
              }
          }
      }

    public void release() {
        // Overriden method
        super.release();
        readOnlyClass = null;
        securityMapper=null;
        buttonClass=null;
        showTime=null;
        format=null;
        helper=null;

    }

    public String getReadOnlyClass() {
        return readOnlyClass;
    }

    public void setReadOnlyClass(String readOnlyClass) {
        this.readOnlyClass = readOnlyClass;
    }

    public String getButtonId() {
        return buttonId;
    }

    public void setButtonId(String buttonId) {
        this.buttonId = buttonId;
    }

    public String getButtonClass() {
        return buttonClass;
    }

    public void setButtonClass(String buttonClass) {
        this.buttonClass = buttonClass;
    }

    public Boolean getShowTime() {
        return showTime;
    }

    public void setShowTime(Boolean showTime) {
        this.showTime = showTime;
        if (Boolean.TRUE.equals(showTime)) {
            setFormatType(NCDateTimeFormatter.DateFormatType.DATE_TIME.getValue());
        }else{
            setFormatType(NCDateTimeFormatter.DateFormatType.DATE.getValue());
        }
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }

    public boolean isSkipPermissions()
    {
        return skipPermissions;
    }

    public boolean getSkipPermissions()
    {
        return isSkipPermissions();
    }

    public void setSkipPermissions(boolean skipPermissions)
    {
        this.skipPermissions = skipPermissions;
    }
}
