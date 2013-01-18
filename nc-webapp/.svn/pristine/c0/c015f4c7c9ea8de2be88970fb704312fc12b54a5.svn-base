package au.com.toyota.nc.webapp.stripes.reports;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;

import au.com.toyota.nc.common.model.DealerLocationSearchRequest;
import au.com.toyota.nc.common.reports.LocationSearchResultsReportService;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.StreamingResolution;
import net.sourceforge.stripes.action.UrlBinding;
import net.sourceforge.stripes.integration.spring.SpringBean;

/**
 * User: Alex Ooi
 * Date: 1/05/2009
 * Time: 13:59:50
 */
@UrlBinding("/reports/LocationSearchResultsReport-MailMerge.xls")
public class MailMergeLocationSearchResultsReportActionBean extends BaseActionBean
{
    @SpringBean
    private LocationSearchResultsReportService searchResultsReportService;

    private DealerLocationSearchRequest searchReq;

    @DefaultHandler
    @HandlesEvent("export")
    public Resolution export()
    {
        final ByteArrayOutputStream byteArrayOutputStream = searchResultsReportService.exportMailMerge(searchReq, getContext().getUserRole());
        final String contentType = "application/ms-excel";
        return new StreamingResolution(contentType, new ByteArrayInputStream(byteArrayOutputStream.toByteArray()));
    }

    public DealerLocationSearchRequest getSearchReq()
    {
        return searchReq;
    }

    public void setSearchReq(DealerLocationSearchRequest searchReq)
    {
        this.searchReq = searchReq;
    }
}