package au.com.toyota.nc.webapp.util;

import au.com.toyota.nc.webapp.NetworkCentralWebappTestCase;
import org.easymock.EasyMock;
import static org.easymock.EasyMock.expect;
import org.easymock.IMocksControl;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.List;

/**
 *
 */
public class HttpRequestHelperUnitTest extends NetworkCentralWebappTestCase{

    private IMocksControl niceControl;
    private HttpServletRequest mockRequest;

    @Autowired
    private HttpRequestHelper helper;

    @Before
    public void before(){
        niceControl = EasyMock.createNiceControl();
        mockRequest = niceControl.createMock(HttpServletRequest.class);
    }


    @After
    public void verify(){
        niceControl.verify();
    }

    private class EnumeratedHttpHeader implements Enumeration{
        private List<String> internalIPs;
        private int currentIndex;

        EnumeratedHttpHeader(String... ips) {
            internalIPs = Arrays.asList(ips);
            if (ips.length > 0) {
                currentIndex =0;
            }else{
                currentIndex=-1;
            }
        }

        public boolean hasMoreElements() {
            return !internalIPs.isEmpty() && currentIndex < internalIPs.size();
        }

        public Object nextElement() {
            if (currentIndex == -1) {
                return null;
            }else {
                return internalIPs.get(currentIndex++);
            }
        }
    }


    @Test
    public void on_request_with_no_xforward_should_return_reported_ip() throws Exception {
        expect(mockRequest.getHeaders(HttpRequestHelper.X_FORWARDED_FOR)).andReturn(new EnumeratedHttpHeader());
        expect(mockRequest.getRemoteAddr()).andReturn("192.168.0.2");

        niceControl.replay();

        String remoteIPAddress = helper.getRemoteIPAddress(mockRequest);
        assertThat(remoteIPAddress, is("192.168.0.2"));
    }


    @Test
    public void on_request_with_single_xforward_should_return_that_address() throws Exception {
        expect(mockRequest.getHeaders(HttpRequestHelper.X_FORWARDED_FOR)).andReturn(new EnumeratedHttpHeader("132.147.1.1"));
        expect(mockRequest.getRemoteAddr()).andReturn("192.168.0.2");

        niceControl.replay();

        String remoteIPAddress = helper.getRemoteIPAddress(mockRequest);
        assertThat(remoteIPAddress, is("132.147.1.1"));
    }

    @Test
    public void on_request_with_multiple_xforward_should_return_latest_address() throws Exception {
        expect(mockRequest.getHeaders(HttpRequestHelper.X_FORWARDED_FOR)).andReturn(new EnumeratedHttpHeader("132.147.1.1,201.23.55.11"));
        expect(mockRequest.getRemoteAddr()).andReturn("192.168.0.2");

        niceControl.replay();

        String remoteIPAddress = helper.getRemoteIPAddress(mockRequest);
        assertThat(remoteIPAddress, is("201.23.55.11"));

    }
}
