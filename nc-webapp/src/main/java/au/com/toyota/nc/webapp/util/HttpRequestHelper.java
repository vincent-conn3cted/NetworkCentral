package au.com.toyota.nc.webapp.util;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.StringTokenizer;

/**
 *
 */
@Component
public class HttpRequestHelper {
    private static final Logger LOG = Logger.getLogger(HttpRequestHelper.class.getName());
    
    public static final String X_FORWARDED_FOR = "X-Forwarded-For";

    /**
     * Get remote address for the given request. Handles the case where request is forwarded from proxy, etc.
     *
     * @param request instance of {@link HttpServletRequest}
     * @return remote IP address
     */
    public String getRemoteIPAddress(HttpServletRequest request) {
         String reportedIpAddress = request.getRemoteAddr();

        // get all the header values for the X-Forwarded-For header (in case there are multiple values)
        Enumeration headerIpAddresses = request.getHeaders(X_FORWARDED_FOR);

          // there may be many headers, so we only want to report the last one
        // which, so far, is the reportedIpAddress from the request object
        String latestIpAddress = reportedIpAddress;

        if (!headerIpAddresses.hasMoreElements()) {
            // no headers, use the req.getRemoteAddr value
            LOG.debug("Using reported caller IP address of " + reportedIpAddress + " as no value for header " + X_FORWARDED_FOR);
        } else {
            // multiple headers, iterate through the list of headerIpAddresses to get to the last one
            while (headerIpAddresses.hasMoreElements()) {
                // the HTTP spec says that can be one header name with multiple values comma separated
                // so need to support this
                StringTokenizer headerIPs = new StringTokenizer((String) headerIpAddresses.nextElement(), ",");

                // go through each element and record the last one in the list as the latest forwarded ip address
                while (headerIPs.hasMoreElements()) {
                    latestIpAddress = ((String) headerIPs.nextElement()).trim();
                    LOG.debug("Parsed header value for " + X_FORWARDED_FOR + " of " + latestIpAddress);
                }
            }

            if (latestIpAddress.equals(reportedIpAddress)) {
                LOG.debug("Using caller IP address of " + latestIpAddress + " (header same as reported)");
            } else {
                LOG.debug("Using header caller IP address of " + latestIpAddress + " (rather than reported " + reportedIpAddress + ")");
            }
        }
        return latestIpAddress;
    }
}
