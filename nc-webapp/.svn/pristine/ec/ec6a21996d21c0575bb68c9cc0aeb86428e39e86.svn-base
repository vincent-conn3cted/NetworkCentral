package au.com.toyota.nc.webapp.stripes.reports;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.List;

import au.com.toyota.nc.common.model.hibernate.Appointment;
import au.com.toyota.nc.common.reports.MailingLabelsReportService;
import au.com.toyota.nc.webapp.stripes.NetworkCentralPdfResolution;
import au.com.toyota.nc.webapp.stripes.staff.DealerStaffSearchActionBean;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.UrlBinding;
import net.sourceforge.stripes.integration.spring.SpringBean;
import org.apache.log4j.Logger;

@UrlBinding("/reports/MailingLabelAppointmentReport.pdf")
public class MailingLabelAppointmentReportActionBean extends AbstractStaffSearchReportActionBean implements MailingLabelActionBean
{
    private static final Logger LOG = Logger.getLogger(MailingLabelAppointmentReportActionBean.class);
    private static final String MAILING_LABEL_JSP_BASE = JSP_BASE + "/reports/mailinglabel";

    @SpringBean
    private MailingLabelsReportService mailingLabelsReportService;

    private List<Appointment> appointmentsWithoutAnAddress;

    @HandlesEvent("withNoAddress")
    public Resolution withNoAddress() throws Exception
    {
        LOG.info("Locating all appointments with no addresses");
        appointmentsWithoutAnAddress = mailingLabelsReportService.getAppointmentsWithoutAnAddress(getSearchReq());
        return new ForwardResolution(MAILING_LABEL_JSP_BASE +"/withNoAddress.jsp");
    }

    @DefaultHandler
    @HandlesEvent(GENERATE_EVENT)
    public Resolution generate() throws Exception
    {
    	if(null != getSearchReq()){
	        final ByteArrayOutputStream outputStream = mailingLabelsReportService.generate(getSearchReq());
	        final Resolution resolution = new NetworkCentralPdfResolution(outputStream, "MailingLabelStaffReport.pdf");
	        return resolution;
    	}else{
            return new RedirectResolution(DealerStaffSearchActionBean.class, DealerStaffSearchActionBean.EVENT_DISPLAY_SEARCH_CRITERIA_FOR_VIEW);
    	}
    }

    public List<Appointment> getAppointmentsWithoutAnAddress()
    {
        return appointmentsWithoutAnAddress;
    }

    public List<String> getNamesWithoutAddresses()
    {
        final List<String> names = new ArrayList<String>();
        for (Appointment appointment : getAppointmentsWithoutAnAddress())
        {
            names.add(appointment.getPerson().getFullName());
        }
        return names;
    }
}
