package au.com.toyota.nc.webapp.taglibs;

import net.sourceforge.stripes.tag.MessagesTag;
import net.sourceforge.stripes.action.Message;
import net.sourceforge.stripes.controller.StripesFilter;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import au.com.toyota.nc.webapp.stripes.NCActionBeanContext;

import java.util.List;
import java.util.Locale;
import java.util.ResourceBundle;
import java.util.MissingResourceException;
import java.io.IOException;

/**
 * Date: May 5, 2009
 * Time: 4:56:54 PM
 *
 * @author Alex Wibowo
 */
public class NCWarningsTag extends MessagesTag {

    public static final String DEFAULT_HEADER = "<ul class=\"warning\">";

    public static final String DEFAULT_FOOTER = "</ul>";


     @Override
    public int doEndTag() throws JspException {
        try {
            List<Message> messages = getMessages();

            if (messages != null && messages.size() > 0) {
                JspWriter writer = getPageContext().getOut();

                // Output all errors in a standard format
                Locale locale = getPageContext().getRequest().getLocale();
                ResourceBundle bundle = StripesFilter.getConfiguration()
                        .getLocalizationBundleFactory().getErrorMessageBundle(locale);

                // Fetch the header and footer
                String header, footer, beforeMessage, afterMessage;
                try { header = bundle.getString("stripes.warnings.header"); }
                catch (MissingResourceException mre) { header = DEFAULT_HEADER; }

                try { footer = bundle.getString("stripes.warnings.footer"); }
                catch (MissingResourceException mre) { footer = DEFAULT_FOOTER; }

                try { beforeMessage = bundle.getString("stripes.warnings.beforeWarning"); }
                catch (MissingResourceException mre) { beforeMessage = "<li>"; }

                try { afterMessage = bundle.getString("stripes.warnings.afterWarning"); }
                catch (MissingResourceException mre) { afterMessage = "</li>"; }

                // Write out the error messages
                writer.write(header);

                for (Message message : messages) {
                    writer.write(beforeMessage);
                    writer.write(message.getMessage(locale));
                    writer.write(afterMessage);
                }

                writer.write(footer);
            }
            return EVAL_PAGE;
        }
        catch (IOException e) {
            throw new JspException("IOException encountered while writing messages " +
                    "tag to the JspWriter.", e);
        }
    }


    @Override
    public int doStartTag() throws JspException {
        setKey(NCActionBeanContext.REQ_ATTR_WARNINGS);
        return super.doStartTag();
    }
}
