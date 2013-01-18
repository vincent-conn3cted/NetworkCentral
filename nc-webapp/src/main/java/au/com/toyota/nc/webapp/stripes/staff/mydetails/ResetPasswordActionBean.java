package au.com.toyota.nc.webapp.stripes.staff.mydetails;

import au.com.toyota.nc.common.staff.exceptions.AppointmentNotFoundException;
import au.com.toyota.nc.common.staff.exceptions.PasswordResetException;
import au.com.toyota.nc.common.staff.users.PasswordResetTopology;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidationMethod;
import org.apache.commons.lang.StringUtils;

import java.util.List;

public class ResetPasswordActionBean extends BaseActionBean
{
    private static final String RESET_OWN_PASSWORD_EVENT = "resetOwnPassword";
    private static final String MY_DETAILS_JSP_BASE = JSP_BASE + "/staff/mydetails";

    @SpringBean
    private PasswordResetTopology passwordResetTopology;

    @Validate(required = true, on = {RESET_OWN_PASSWORD_EVENT})
    private String oldPassword;

    @Validate(required = true, on = {RESET_OWN_PASSWORD_EVENT})
    private String newPassword;

    @Validate(required = true, on = {RESET_OWN_PASSWORD_EVENT})
    private String confirmNewPassword;

    @HandlesEvent("showResetOwnPassword")
    public Resolution showResetOwnPassword()
    {
        Resolution resolution;
        try
        {
            getLoggedInUsersAppointment();
            resolution = new ForwardResolution(MY_DETAILS_JSP_BASE + "/resetOwnPassword.jsp");
        }
        catch (AppointmentNotFoundException e)
        {
            addSimpleGlobalError(e.getMessage());
            resolution = new ForwardResolution(MY_DETAILS_JSP_BASE + "/myDetails.jsp");
        }
        return resolution;
    }

    @HandlesEvent(RESET_OWN_PASSWORD_EVENT)
    public Resolution resetOwnPassword() throws AppointmentNotFoundException
    {
        Resolution redirectResolution;
        try
        {
            passwordResetTopology.resetOwnPassword(getLoggedInUsersAppointment(), oldPassword, newPassword);
            addLocalizableGlobalMessage("message.password.reset.own.success");
            redirectResolution = new RedirectResolution(getClass(), "showResetOwnPassword").flash(this);
        }
        catch (PasswordResetException e)
        {
            addSimpleGlobalError(e.getMessage());
            redirectResolution = new ForwardResolution(MY_DETAILS_JSP_BASE + "/resetOwnPassword.jsp");
        }
        return redirectResolution;
    }

    @ValidationMethod(on = RESET_OWN_PASSWORD_EVENT)
    public void ensurePasswordsAreSame()
    {
        if (!StringUtils.isBlank(newPassword) && !StringUtils.isBlank(confirmNewPassword))
        {
            if (!newPassword.equals(confirmNewPassword))
            {
                addLocalizableGlobalError("message.password.errors.newPassword.doesNotMatch");
            }
        }
    }

    public String getOldPassword()
    {
        return oldPassword;
    }

    public void setOldPassword(String oldPassword)
    {
        this.oldPassword = oldPassword;
    }

    public String getNewPassword()
    {
        return newPassword;
    }

    public void setNewPassword(String newPassword)
    {
        this.newPassword = newPassword;
    }

    public String getConfirmNewPassword()
    {
        return confirmNewPassword;
    }

    public void setConfirmNewPassword(String confirmNewPassword)
    {
        this.confirmNewPassword = confirmNewPassword;
    }

    public List<String> getEligibleUsercodes() throws AppointmentNotFoundException
    {
        return passwordResetTopology.getAllPasswordResetEligibleUsercodesFor(getLoggedInUsersAppointment().getPerson(), getLoggedInUsersAppointment().getDealer());
    }

}
