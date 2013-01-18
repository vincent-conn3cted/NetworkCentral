package au.com.toyota.nc.webapp.taglibs;

import org.springframework.mock.web.MockJspWriter;
import org.springframework.mock.web.MockPageContext;

import javax.servlet.jsp.JspWriter;
import java.io.StringWriter;

class NetworkCentralPageContext extends MockPageContext
{
    private final JspWriter writer;
    private final StringWriter stringWriter;

    public NetworkCentralPageContext()
    {
        stringWriter = new StringWriter();
        this.writer = new MockJspWriter(stringWriter);
    }

    public String getBody()
    {
        return stringWriter.toString();
    }

    public JspWriter getOut()
    {
        return writer;
    }
}
