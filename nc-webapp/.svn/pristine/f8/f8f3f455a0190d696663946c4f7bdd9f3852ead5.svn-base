package au.com.toyota.nc.webapp.stripes.dealerLocations;

import au.com.toyota.nc.common.dealers.exceptions.InvalidDealerException;
import au.com.toyota.nc.common.model.hibernate.DMSContactPerson;
import au.com.toyota.nc.common.model.hibernate.DMSVendor;
import au.com.toyota.nc.common.model.hibernate.Dealer;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.Resolution;
import org.apache.log4j.Logger;

public class ShowDmsVendorOptionsActionBean extends BaseActionBean
{
    private static final Logger LOG = Logger.getLogger(ShowDmsVendorOptionsActionBean.class);

    protected static final String DEALER_JSP_BASE = JSP_BASE + "/dealer";

    private Dealer dealer;

    private Long dmsVendorId;

    private Long dmsContactId;

    @HandlesEvent("showSelectedDmsVendorOptions")
    public Resolution showSelectedDmsVendorOptions() throws InvalidDealerException
    {
        LOG.info("Showing a section that includes only the DMS Vendors options");
        dealer = dealerDBService.fetchDealer(dealer.getDealerId());
        final ForwardResolution resolution = new ForwardResolution(DEALER_JSP_BASE + "/systemInfo/showDmsVendorOptions.jsp");
        return resolution;
    }

    @HandlesEvent("showInfoForDmsContact")
    public Resolution showInfoForDmsContact() throws InvalidDealerException
    {
        LOG.info("Showing a section that includes only the DMS Vendors options");
        dealer = dealerDBService.fetchDealer(dealer.getDealerId());
        final ForwardResolution resolution = new ForwardResolution(DEALER_JSP_BASE + "/systemInfo/showDmsVendorContactInfo.jsp");
        return resolution;
    }

    public DMSContactPerson getSelectedContactPerson()
    {
        return dmsVendorServices.getDmsContactPerson(dmsContactId);
    }

    public DMSVendor getSelectedDmsVendor()
    {
        return dmsVendorServices.getDMSVendor(dmsVendorId);
    }

    public Long getDmsContactId()
    {
        return dmsContactId;
    }

    public void setDmsContactId(Long dmsContactId)
    {
        this.dmsContactId = dmsContactId;
    }

    public Long getDmsVendorId()
    {
        return dmsVendorId;
    }

    public void setDmsVendorId(Long dmsVendorId)
    {
        this.dmsVendorId = dmsVendorId;
    }

    public Dealer getDealer()
    {
        return dealer;
    }

    public void setDealer(Dealer dealer)
    {
        this.dealer = dealer;
    }
}
