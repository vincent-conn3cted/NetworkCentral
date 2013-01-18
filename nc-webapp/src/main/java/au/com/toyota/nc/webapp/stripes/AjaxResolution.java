package au.com.toyota.nc.webapp.stripes;

import net.sf.json.JSON;
import net.sourceforge.stripes.action.StreamingResolution;
import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletResponse;
import java.io.StringReader;

public class AjaxResolution extends StreamingResolution {
    private static final Logger LOGGER = Logger.getLogger(AjaxResolution.class.getName());
    private final JSON json;

    public AjaxResolution(JSON json) {
        super("text", new StringReader(json.toString()));
        this.json = json;
    }

    protected void stream(HttpServletResponse response) throws Exception {
        response.setHeader("Expires", "0");
        response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
        response.setHeader("Pragma", "public");

        super.stream(response);
    }

    public JSON getJson()
    {
        return json;
    }
}

