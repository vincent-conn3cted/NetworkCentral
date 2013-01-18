package au.com.toyota.nc.webapp.stripes.reports;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.List;

import au.com.toyota.nc.common.model.DealerLocationSearchRequest;
import au.com.toyota.nc.common.model.hibernate.Location;
import au.com.toyota.nc.common.reports.MailingLabelsReportService;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;
import au.com.toyota.nc.webapp.stripes.NetworkCentralPdfResolution;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.UrlBinding;
import net.sourceforge.stripes.integration.spring.SpringBean;
import org.apache.log4j.Logger;

@UrlBinding("/reports/MailingLabelLocationReport.pdf")
public class MailingLabelLocationReportActionBean extends BaseActionBean implements MailingLabelActionBean
{
    private static final Logger LOG = Logger.getLogger(MailingLabelLocationReportActionBean.class);
    private static final String MAILING_LABEL_JSP_BASE = JSP_BASE + "/reports/mailinglabel";

    @SpringBean
    private MailingLabelsReportService mailingLabelsReportService;

    private DealerLocationSearchRequest searchReq = new DealerLocationSearchRequest();

    private List<Location> locationsWithNoAddress;

    @HandlesEvent("withNoAddress")
    public Resolution withNoAddress() throws Exception
    {
        LOG.info("Locating all locations with no addresses");
        locationsWithNoAddress = mailingLabelsReportService.getLocationsWithoutAnAddress(getSearchReq());
        return new ForwardResolution(MAILING_LABEL_JSP_BASE +"/withNoAddress.jsp");
    }

    @DefaultHandler
    @HandlesEvent("generate")
    public Resolution generate() throws Exception
    {
        final ByteArrayOutputStream outputStream = mailingLabelsReportService.generate(locationDealerSearchService.findLocationForRole(searchReq, context.getUserRole()));
        final Resolution resolution = new NetworkCentralPdfResolution(outputStream, "MailingLabelLocationReport.pdf");
        return resolution;
    }

    public DealerLocationSearchRequest getSearchReq()
    {
        return searchReq;
    }

    public void setSearchReq(DealerLocationSearchRequest searchReq)
    {
        this.searchReq = searchReq;
    }

    public List<Location> getLocationsWithNoAddress()
    {
        return locationsWithNoAddress;
    }

    public List<String> getNamesWithoutAddresses()
    {
        final List<String> names = new ArrayList<String>();
        for (Location location : getLocationsWithNoAddress())
        {
            names.add(location.getLocationName());
        }
        return names;
    }
}