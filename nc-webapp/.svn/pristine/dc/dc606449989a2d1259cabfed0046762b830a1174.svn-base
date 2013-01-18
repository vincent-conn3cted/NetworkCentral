package au.com.toyota.nc.webapp.stripes;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletContext;

import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.Resolution;

import org.apache.log4j.Logger;

import au.com.toyota.nc.common.security.NCRole;

public class HelpPDFActionBean extends BaseActionBean
{
    private static final String HELP_FOR_DEALERSHIP_USER_PDF = "/pdf/help_for_dealership_user.pdf";
    private static final String HELP_FOR_OTHER_USER_PDF = "/pdf/help_for_other_user.pdf";

    private static final Logger LOG = Logger.getLogger(HelpPDFActionBean.class.getName());

    @DefaultHandler
    public Resolution displayHelpPDF() throws IOException
    {
    	NCActionBeanContext ncActionBeanContext = this.getContext();
		if(ncActionBeanContext == null)
    		throw new RuntimeException("Context is null!");
    	NCRole userRole = ncActionBeanContext.getUserRole();
		if(userRole == null)
			throw new RuntimeException("This page should be unavailable to unauthenticated user!");
		
		String pdfFilePath;
    	if(userRole.isDelearUpdateOrDelearSearch())
    		pdfFilePath = HELP_FOR_DEALERSHIP_USER_PDF;
    	else
    		pdfFilePath = HELP_FOR_OTHER_USER_PDF;
    		
    	ServletContext servletContext = ncActionBeanContext.getServletContext();
    	if(servletContext == null)
    		throw new RuntimeException("Servlet context is null!");
    		
		InputStream pdfFileInputStream = servletContext.getResourceAsStream(pdfFilePath);
    	return new NetworkCentralPdfResolution(getByteArrayOutputStreamForInputStream(pdfFileInputStream), "help_pdf.pdf");
    }

	private ByteArrayOutputStream getByteArrayOutputStreamForInputStream(InputStream fis) throws IOException 
	{
    	ByteArrayOutputStream bos = new ByteArrayOutputStream();
    	byte[] buf = new byte[1024];
        for(int readNum; (readNum = fis.read(buf)) != -1;) 
        {
            bos.write(buf, 0, readNum);
        }
        return bos;
	}

}
