package au.com.toyota.nc.webapp.stripes.staff.mydetails;

import au.com.toyota.isd.common.ldap.model.User;
import au.com.toyota.nc.common.model.hibernate.Appointment;
import au.com.toyota.nc.common.staff.exceptions.AppointmentNotFoundException;
import au.com.toyota.nc.common.staff.exceptions.DealerStaffValidationException;
import au.com.toyota.nc.common.staff.exceptions.PasswordResetException;
import au.com.toyota.nc.webapp.stripes.staff.dealerstaff.AbstractManageStaffActionBean;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import org.apache.log4j.Logger;

/**
 * User: Alex Wibowo
 * Date: 27/11/2008
 * Time: 15:47:14
 */
public class MyDetailsActionBean extends AbstractManageStaffActionBean
{
    private static final Logger LOG = Logger.getLogger(MyDetailsActionBean.class.getName());

    public static final String EVENT_SEARCH = "search";
    private static final String VIEW_EVENT = "view";
    private static final String SHOW_GENERATED_SAP_PASSWORD_EVENT = "showGeneratedSapPassword";

    private static final String MY_DETAILS_BASE_JSP = JSP_BASE + "/staff/mydetails";

    private String generatedSapPassword;

    private Long appointmentId;

    @DefaultHandler
    @HandlesEvent(VIEW_EVENT)
    public Resolution view() throws AppointmentNotFoundException
    {
        LOG.info("Viewing dealer staff");
        final String cn = getContext().getLoginId();
        LOG.info("for user cn [" + cn + "]");
        final Appointment appointment = getLoggedInUsersAppointment();
        setDealerStaff(appointment.getPerson());
        setOldDob(getDealerStaff().getDob());
        setOldFirstname(getDealerStaff().getFirstname());
        setOldLastname(getDealerStaff().getSurname());
        setSelectedLanguages(getDealerStaff().getLanguages());
        return new ForwardResolution(MY_DETAILS_BASE_JSP + "/view.jsp");
    }

    @HandlesEvent(SAVE_OR_UPDATE_EVENT)
    public Resolution saveOrUpdate()
    {
        Resolution resolution;
        try
        {
            Long currentAppointmentId = getLoggedInUsersAppointment().getAppointmentId();
            doSaveOrUpdate();
            updateCurrentLoggedInUser(currentAppointmentId);
            resolution = new RedirectResolution(MyDetailsActionBean.class);
        }
        catch (DealerStaffValidationException e)
        {
            addSimpleGlobalError(e.getMessage());
            resolution = new ForwardResolution(MY_DETAILS_BASE_JSP + "/view.jsp");
        }
        catch (AppointmentNotFoundException e)
        {
            throw new RuntimeException(e);
        }
        return resolution;
    }

    @HandlesEvent("generateSapPassword")
    public Resolution generateSapPassword()
    {
        Resolution resolution;
        try
        {
            generatedSapPassword = appointmentTopology.resetSapPassword(getAppointmentId());
            resolution = new RedirectResolution(MyDetailsActionBean.class, SHOW_GENERATED_SAP_PASSWORD_EVENT).flash(this);
        }
        catch (PasswordResetException e)
        {
            addSimpleGlobalError(e.getMessage());
            resolution = new ForwardResolution(MyDetailsActionBean.class, VIEW_EVENT);
        }
        catch (AppointmentNotFoundException e)
        {
            addSimpleGlobalError(e.getMessage());
            resolution = new ForwardResolution(MyDetailsActionBean.class, VIEW_EVENT);
        }
        return resolution;
    }

    @HandlesEvent(SHOW_GENERATED_SAP_PASSWORD_EVENT)
    public Resolution showGeneratedSapPassword()
    {
        return new ForwardResolution(MY_DETAILS_BASE_JSP + "/generatedSapPassword.jsp");
    }

    private void updateCurrentLoggedInUser(Long currentAppointmentId)
    {
        final Appointment currentAppointment = appointmentServices.get(currentAppointmentId);
        User user = userRepository.fetchUser(currentAppointment.getUsercode());
        getContext().setUserDetails(user);
    }

    public String getGeneratedSapPassword()
    {
        return generatedSapPassword;
    }

    public Long getAppointmentId()
    {
        return appointmentId;
    }

    public void setAppointmentId(Long appointmentId)
    {
        this.appointmentId = appointmentId;
    }

    /**
     * the user is always eligible to see their own DOB! However, this is still required because the _coreDetails.jsp
     * references a call to eligible.
     */
    public Boolean getEligible()
    {
        return true;
    }
}
