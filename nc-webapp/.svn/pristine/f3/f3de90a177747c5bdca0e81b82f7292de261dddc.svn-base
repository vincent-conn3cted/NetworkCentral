package au.com.toyota.nc.webapp.stripes;

import java.io.ByteArrayOutputStream;
import java.io.OutputStream;
import javax.servlet.http.HttpServletResponse;

import net.sourceforge.stripes.action.StreamingResolution;

public class NetworkCentralPdfResolution extends StreamingResolution
{
    private ByteArrayOutputStream baos;
    private final String filename;

    public NetworkCentralPdfResolution(ByteArrayOutputStream byteArrayOutputStream, String filename)
    {
        super("application/pdf");
        this.baos = byteArrayOutputStream;
        this.filename = filename;
    }

    public void stream(HttpServletResponse response) throws Exception
    {
        setHeaders(response);
        response.setContentLength(baos.size());
        final OutputStream os = response.getOutputStream();
        baos.writeTo(os);
        os.flush();
    }

    protected void setHeaders(final HttpServletResponse response)
    {
        response.setHeader("Expires", "0");
        response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
        response.setHeader("Pragma", "public");
        response.setHeader("Content-Disposition", "inline;filename=" + filename);
    }
}
