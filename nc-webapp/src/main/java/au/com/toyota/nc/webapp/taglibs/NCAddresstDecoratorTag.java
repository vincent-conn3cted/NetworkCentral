package au.com.toyota.nc.webapp.taglibs;

import au.com.toyota.nc.common.model.hibernate.AbstractContact;
import au.com.toyota.nc.common.utils.AddressFormatter;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.integration.spring.SpringHelper;
import org.apache.log4j.Logger;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;

/**
 * insert formated address 
 * Date: 15/03/2009
 * Time: 10:13:29 PM
 *
 * @author Deepthi Fernando
 * @author Alex Wibowo
 */
public class NCAddresstDecoratorTag extends TagSupport {
    private final Logger LOG = Logger.getLogger(NCAddresstDecoratorTag.class);
    private AbstractContact contact;
    private AbstractContact.Address.Type addressType;

    @SpringBean
    private AddressFormatter addressFormater;

   public void setPageContext(PageContext pageContext) {
        super.setPageContext(pageContext);
        SpringHelper.injectBeans(this, pageContext.getServletContext());
    }

    public int doStartTag() {
        try {
            JspWriter out = pageContext.getOut();
            String formattedAddress = addressFormater.formatAddress(contact, addressType);
            out.print(formattedAddress);
        } catch (IOException ioe) {
            LOG.error("Error in NCAddresstDecoratorTag: " + ioe);
        }
        return (SKIP_BODY);
    }

    public AbstractContact.Address.Type getAddressType() {
        return addressType;
    }

    public void setAddressType(String addressType) {
        this.addressType= AbstractContact.Address.Type.valueOf(addressType);
    }

    public AbstractContact getContact() {
        return contact;
    }

    public void setContact(AbstractContact contact) {
        this.contact = contact;
    }

    @Override
    public void release() {
        super.release();
        contact=null;
        addressType=null;
        addressFormater=null;
    }
}