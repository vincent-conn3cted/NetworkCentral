package au.com.toyota.nc.webapp.stripes.reports;

import java.io.ByteArrayOutputStream;

import au.com.toyota.nc.common.model.DealerLocationSearchRequest;
import au.com.toyota.nc.common.reports.hardcopy.HardCopyDealerReportsService;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;
import au.com.toyota.nc.webapp.stripes.NetworkCentralPdfResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.UrlBinding;
import net.sourceforge.stripes.integration.spring.SpringBean;

/**
 * User: Alex Ooi
 * Date: 27/04/2009
 * Time: 17:48:27
 */
@UrlBinding("/reports/HardCopyReport.pdf")
public class HardCopyActionBean extends BaseActionBean
{
    @SpringBean
    private HardCopyDealerReportsService hardCopyDealerReportsService;

    private DealerLocationSearchRequest dealerSearchRequest = new DealerLocationSearchRequest();

    private String reportTitle;

    @HandlesEvent("generate")
    public Resolution generate() throws Exception
    {
        final ByteArrayOutputStream outputStream = hardCopyDealerReportsService.generate(dealerSearchRequest, reportTitle);
        return new NetworkCentralPdfResolution(outputStream, "HardCopyReport.pdf");
    }

    public String getReportTitle()
    {
        return reportTitle;
    }

    public void setReportTitle(String reportTitle)
    {
        this.reportTitle = reportTitle;
    }

    public DealerLocationSearchRequest getDealerSearchRequest()
    {
        return dealerSearchRequest;
    }

    public void setDealerSearchRequest(DealerLocationSearchRequest dealerSearchRequest)
    {
        this.dealerSearchRequest = dealerSearchRequest;
    }
}
