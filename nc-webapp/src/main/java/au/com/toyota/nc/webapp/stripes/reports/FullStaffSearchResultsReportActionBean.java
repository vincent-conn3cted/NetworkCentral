package au.com.toyota.nc.webapp.stripes.reports;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;

import au.com.toyota.nc.common.reports.AppointmentSearchResultsReportService;
import au.com.toyota.nc.webapp.stripes.staff.DealerStaffSearchActionBean;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.StreamingResolution;
import net.sourceforge.stripes.action.UrlBinding;
import net.sourceforge.stripes.integration.spring.SpringBean;

@UrlBinding("/reports/StaffSearchResultsReport-Full.xls")
public class FullStaffSearchResultsReportActionBean extends AbstractStaffSearchReportActionBean
{
    @SpringBean
    private AppointmentSearchResultsReportService appointmentSearchResultsReportService;

    @DefaultHandler
    @HandlesEvent(EXPORT_EVENT)
    public Resolution export()
    {
    	if(null != getSearchReq() && getContext() != null && getContext().getUserRole() != null){
	    	final ByteArrayOutputStream byteArrayOutputStream = appointmentSearchResultsReportService.exportFullReport(getSearchReq(), getContext().getUserRole());
	        final String contentType = "application/ms-excel";
	        return new StreamingResolution(contentType, new ByteArrayInputStream(byteArrayOutputStream.toByteArray()));
    	}else{
            return new RedirectResolution(DealerStaffSearchActionBean.class, DealerStaffSearchActionBean.EVENT_DISPLAY_SEARCH_CRITERIA_FOR_VIEW);
    	}
    }
}