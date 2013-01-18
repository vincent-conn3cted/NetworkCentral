package au.com.toyota.nc.webapp.dataproxy;

import au.com.toyota.nc.common.dealers.DealerSapService;
import au.com.toyota.nc.common.dealers.exceptions.SapDealerException;
import au.com.toyota.nc.common.dealers.impl.SapDealer;
import au.com.toyota.nc.common.locations.LocationSapService;
import au.com.toyota.nc.common.locations.SapLocation;
import au.com.toyota.nc.common.locations.exceptions.SapLocationException;
import au.com.toyota.nc.webapp.NetworkCentralWebappTestCase;
import net.sf.json.JSONObject;
import net.sf.json.JSON;
import org.easymock.EasyMock;
import org.easymock.IMocksControl;
import static org.hamcrest.CoreMatchers.*;
import static org.hamcrest.CoreMatchers.is;
import org.junit.Assert;
import static org.junit.Assert.assertThat;
import org.junit.Before;
import org.junit.Test;

/**
 * Date: May 6, 2009
 * Time: 2:34:13 PM
 *
 * @author Alex Wibowo
 */
public class SapCodeVerifierUnitTest extends NetworkCentralWebappTestCase{
    private IMocksControl mockControl;


    private SAPCodeVerifier sapCodeVerifier;

    private DealerSapService dealerSAPService;

    private LocationSapService locationSAPService;

    @Before
    public void createMocks() throws Exception{
        mockControl = EasyMock.createNiceControl();

        dealerSAPService = mockControl.createMock(DealerSapService.class);
        locationSAPService = mockControl.createMock(LocationSapService.class);
        sapCodeVerifier = new SAPCodeVerifier(dealerSAPService, locationSAPService);
    }


    @Test
    public void verifySAPDealerCodeAsJSONWithCorrectDealerCode() throws Exception {
        SapDealer dealer = sapDealerTestBuilder.create();
        EasyMock.expect(dealerSAPService.fetchSapDealer(""+dealer.getSapDealerCode())).andReturn(dealer);

        mockControl.replay();

        JSONObject json = (JSONObject) sapCodeVerifier.verifySAPDealerAsJSON(""+dealer.getSapDealerCode());
        mockControl.verify();
        assertThat("Should populate true  as success property", (Boolean) json.get(SAPCodeVerifier.PROPERTY_SUCCESS), is(true));
        assertThat("Shouldnt have any error message",(String) json.get(SAPCodeVerifier.PROPERTY_ERROR_MSG), is(""));

        JSONObject jsonDealer = (JSONObject) json.get(SAPCodeVerifier.PROPERTY_DEALER);
        assertThat("Should populate the dealer property", jsonDealer, not(nullValue()));
        assertThat("Should have the correct dealer name", (String) jsonDealer.get(SapDealer.PROPERTY_DEALER_NAME), is(dealer.getDealerName()));
        Assert.assertEquals("Should have the correct dealer code", ((Integer)jsonDealer.get(SapDealer.PROPERTY_DEALER_CODE)).longValue(), dealer.getSapDealerCode());
    }

    @Test
    public void verifySAPLocationCodeAsJSONWithCorrectCode() throws Exception{
        SapLocation location = sapLocationTestBuilder.create();
        EasyMock.expect(locationSAPService.fetchLocationWithCodes("1111", "1111")).andReturn(location);

        mockControl.replay();

        JSONObject json = (JSONObject) sapCodeVerifier.verifySAPLocationAsJSON("1111", "1111");
        mockControl.verify();
        assertThat("Should populate true  as success property", (Boolean) json.get(SAPCodeVerifier.PROPERTY_SUCCESS), is(true));
        assertThat("Shouldnt have any error message",(String) json.get(SAPCodeVerifier.PROPERTY_ERROR_MSG), is(""));

        JSONObject jsonLocation = (JSONObject) json.get(SAPCodeVerifier.PROPERTY_LOCATION);
        assertThat("Should populate the dealer property", jsonLocation, not(nullValue()));
        assertThat("Should have the correct location name", (String) jsonLocation.get(SapLocation.PROPERTY_LOCATION_NAME), is(location.getLocationName()));
        Assert.assertEquals("Should have the correct location code", ((Integer)jsonLocation.get(SapLocation.PROPERTY_LOCATION_CODE)).longValue(), location.getSapLocationCode());
    }


    @Test
    public void verifySAPDealerCodeAsJSONWithIncorrectDealerCode() throws Exception{
        dealerSAPService.fetchSapDealer("1111");
        EasyMock.expectLastCall().andThrow(SapDealerException.unknownSapDealerCode("1111"));

        mockControl.replay();
        JSONObject json = (JSONObject) sapCodeVerifier.verifySAPDealerAsJSON("1111");
        mockControl.verify();
         assertThat("Should populate false as success property", (Boolean) json.get(SAPCodeVerifier.PROPERTY_SUCCESS), is(false));
        assertThat("Should have the correct error message",(String) json.get(SAPCodeVerifier.PROPERTY_ERROR_MSG), is(SapDealerException.unknownSapDealerCode("1111").getMessage()));
    }

    @Test
    public void verifySAPLocationCodeAsJSONWithIncorrectCode() throws Exception{
        locationSAPService.fetchLocationWithCodes("1111", "1111");
        EasyMock.expectLastCall().andThrow(SapLocationException.unknownLocation("1111", "1111"));

        mockControl.replay();
        JSONObject json = (JSONObject) sapCodeVerifier.verifySAPLocationAsJSON("1111", "1111");
        mockControl.verify();
        assertThat("Should populate false as success property", (Boolean) json.get(SAPCodeVerifier.PROPERTY_SUCCESS), is(false));
        assertThat("Should have the correct error message",(String) json.get(SAPCodeVerifier.PROPERTY_ERROR_MSG), is(SapLocationException.unknownLocation("1111","1111").getMessage()));
    }
    

    @Test
    public void verifySAPDealerCodeWithCorrectDealerCode() throws Exception {
        SapDealer dealer = sapDealerTestBuilder.create();
        EasyMock.expect(dealerSAPService.fetchSapDealer(""+dealer.getSapDealerCode())).andReturn(dealer);

        mockControl.replay();
        sapCodeVerifier.verifySAPDealer("" + dealer.getSapDealerCode());
        mockControl.verify();
    }

    @Test
    public void verifySAPLocationCodeWithCorrectCode() throws Exception {
        SapLocation location = sapLocationTestBuilder.create();
        EasyMock.expect(locationSAPService.fetchLocationWithCodes("1111", "1111")).andReturn(location);
        mockControl.replay();
        sapCodeVerifier.verifySAPLocation("1111","1111");
        mockControl.verify();
    }
}
