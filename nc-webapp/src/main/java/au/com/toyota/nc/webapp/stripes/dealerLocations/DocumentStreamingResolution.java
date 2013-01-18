package au.com.toyota.nc.webapp.stripes.dealerLocations;

import au.com.toyota.nc.common.model.hibernate.AbstractDocument;
import net.sourceforge.stripes.action.StreamingResolution;

import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;

/**
 * User: Alex Wibowo
 * Date: Mar 20, 2009
 * Time: 12:59:03 AM
 */
public class DocumentStreamingResolution extends StreamingResolution {
    protected AbstractDocument document;

    public DocumentStreamingResolution(AbstractDocument document, InputStream is) {
        super(document.getFileContentType(), is);
        this.document = document;
    }

    protected void stream(HttpServletResponse response) throws Exception {
        setHeaders(response);
        super.stream(response);
    }

    protected void setHeaders(final HttpServletResponse response) {
        response.setHeader("Expires", "-1");
        response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
        response.setHeader("Pragma", "public");
        response.setHeader("Content-Disposition", "attachment;filename=\"" + document.getFileName() + "\"");
    }

}
