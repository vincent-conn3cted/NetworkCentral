package au.com.toyota.nc.webapp.dataproxy;

import org.springframework.stereotype.Component;
import org.springframework.beans.factory.annotation.Autowired;
import org.apache.log4j.Logger;
import net.sf.json.JSONObject;
import net.sf.json.JSON;
import au.com.toyota.nc.common.dealers.impl.SapDealer;
import au.com.toyota.nc.common.dealers.exceptions.SapDealerException;
import au.com.toyota.nc.common.dealers.DealerSapService;
import au.com.toyota.nc.common.locations.SapLocation;
import au.com.toyota.nc.common.locations.LocationSapService;
import au.com.toyota.nc.common.locations.exceptions.SapLocationException;

/**
 * Date: May 5, 2009
 * Time: 10:53:11 AM
 *
 * @author Alex Wibowo
 */
@Component
public class SAPCodeVerifier {
    private static final Logger LOG = Logger.getLogger(SAPCodeVerifier.class.getName());

    public static final String PROPERTY_SUCCESS = "success";
    public static final String PROPERTY_ERROR_MSG = "errorMsg";
    public static final String PROPERTY_DEALER = "dealer";
    public static final String PROPERTY_LOCATION = "location";

    @Autowired
    private DealerSapService dealerSAPService;

    @Autowired
    private LocationSapService locationSAPService;

    public SAPCodeVerifier() {
    }

    public SAPCodeVerifier(DealerSapService dealerSAPService, LocationSapService locationSAPService) {
        this.dealerSAPService = dealerSAPService;
        this.locationSAPService = locationSAPService;
    }

    /**
     * Verify the SAP dealer code
     *
     * @param dealerSAPCode dealer SAP code to be verified
     * @return JSON object in the following structure:
     * {
     *      {@link #PROPERTY_SUCCESS} :   true/false,
     *      {@link #PROPERTY_DEALER} : JSON dealer object,
     *      {@link #PROPERTY_ERROR_MSG}  : string
     * }
     */
    public JSON verifySAPDealerAsJSON(String dealerSAPCode){
        LOG.info("Verifying SAP dealer code");
         JSONObject result = new JSONObject();
        try {
            SapDealer sapDealer = verifySAPDealer(dealerSAPCode);
            result.put(PROPERTY_SUCCESS, true);
            result.put(PROPERTY_DEALER, sapDealer);
            result.put(PROPERTY_ERROR_MSG, "");
        } catch (SapDealerException e) {
            result.put(PROPERTY_SUCCESS, false);
            result.put(PROPERTY_ERROR_MSG, e.getMessage());
            LOG.info("Failed to verify SAP dealer code", e);
        }
        LOG.info("Finished verifying SAP dealer code");
        return result;
    }

    /**
     * Verify the given SAP dealer code
     *
     * @param dealerSAPCode {@link au.com.toyota.nc.common.model.hibernate.Dealer.GeneralInfo#sapDealerCode}
     * @return verified SAP dealer, or raise exception
     * @throws SapDealerException if there's no dealer in SAP with the given code
     */
    public SapDealer verifySAPDealer(String dealerSAPCode) throws SapDealerException {
        return dealerSAPService.fetchSapDealer(dealerSAPCode);
    }

    /**
     * Verify the SAP location code
     *
     * @param dealerSAPCode dealer SAP code of the location to be verified
     * @param locationSAPCode location SAP code to be verified
     * @return JSON object in the following structure:
     *  {
     *      {@link #PROPERTY_SUCCESS} :   true/false,
     *      {@link #PROPERTY_LOCATION} : JSON dealer object,
     *      {@link #PROPERTY_ERROR_MSG}  : string
     *  }
     */
    public JSON verifySAPLocationAsJSON(String dealerSAPCode, String locationSAPCode){
        LOG.info("Verifying SAP location code");
         JSONObject result = new JSONObject();
        try {
            SapLocation sapLocation = verifySAPLocation(dealerSAPCode, locationSAPCode);
            result.put(PROPERTY_SUCCESS, true);
            result.put(PROPERTY_LOCATION, sapLocation);
            result.put(PROPERTY_ERROR_MSG, "");
        } catch (SapLocationException e) {
            result.put(PROPERTY_SUCCESS, false);
            result.put(PROPERTY_ERROR_MSG, e.getMessage());
            LOG.info("Failed to verify SAP location code", e);
        }
        LOG.info("Finished verifying SAP location code");
        return result;
    }

    /**
     * Verify the given SAP dealer & location code
     *
     * @param dealerSAPCode {@link au.com.toyota.nc.common.model.hibernate.Dealer.GeneralInfo#sapDealerCode}
     * @param locationSAPCode {@link au.com.toyota.nc.common.model.hibernate.Location#sapCode}
     * @return verified SAP location, or raise exception
     * @throws SapLocationException if there's no location in SAP with the given codes
     */
    public SapLocation verifySAPLocation(String dealerSAPCode, String locationSAPCode) throws SapLocationException {
        return locationSAPService.fetchLocationWithCodes(dealerSAPCode, locationSAPCode);
    }
}
