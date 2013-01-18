package au.com.toyota.nc.webapp.stripes.staff.dealerstaff;

import au.com.toyota.nc.common.dealers.exceptions.InvalidDealerException;
import au.com.toyota.nc.common.model.hibernate.Dealer;
import au.com.toyota.nc.common.model.hibernate.DealerStaff;
import au.com.toyota.nc.common.staff.PasswordResetResponse;
import au.com.toyota.nc.common.staff.exceptions.AppointmentNotFoundException;
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

public class ResetDealerStaffPasswordActionBean extends BaseActionBean
{
    private static final String SHOW_RESET_OTHERS_PASSWORD_EVENT = "showResetOthersPassword";
    private static final String DEALER_STAFF_JSP_BASE = JSP_BASE + "/staff/dealerstaff";
    private static final String RESET_PASSWORD_EVENT = "resetPassword";

    @SpringBean
    private PasswordResetTopology passwordResetTopology;

    private DealerStaff dealerStaff;

    private Dealer dealer;

    @Validate(required = true, on = {RESET_PASSWORD_EVENT})
    private String newPassword;

    @Validate(required = true, on = {RESET_PASSWORD_EVENT})
    private String confirmNewPassword;

    @HandlesEvent(SHOW_RESET_OTHERS_PASSWORD_EVENT)
    public Resolution showResetOthersPassword()
    {
        dealerStaff = getLoadedSelectedDealerStaff();
        return new ForwardResolution(DEALER_STAFF_JSP_BASE + "/resetDealerStaffPassword.jsp");
    }

    @HandlesEvent(RESET_PASSWORD_EVENT)
    public Resolution resetPassword() throws InvalidDealerException
    {
        dealerStaff = getLoadedSelectedDealerStaff();
        dealer = getLoadedSelectedDealer();
        final PasswordResetResponse response = passwordResetTopology.resetOthersPassword(dealer, dealerStaff, newPassword);
        final Resolution resolution = new RedirectResolution(ResetDealerStaffPasswordActionBean.class, "resetPasswordSuccess").flash(this);
        return resolution;
    }

    @HandlesEvent("resetPasswordSuccess")
    public Resolution resetPasswordSuccess()
    {
        return new ForwardResolution(DEALER_STAFF_JSP_BASE + "/resetDealerStaffPasswordSuccess.jsp");
    }

    public List<String> getEligibleUsercodes() throws AppointmentNotFoundException, InvalidDealerException
    {
        return passwordResetTopology.getAllPasswordResetEligibleUsercodesFor(getLoadedSelectedDealerStaff(), getLoadedSelectedDealer());
    }

    public List<String> getNonEligibleUsercodes() throws AppointmentNotFoundException, InvalidDealerException
    {
        return passwordResetTopology.getAllPasswordResetNonEligibleUsercodesFor(getLoadedSelectedDealerStaff(), getLoadedSelectedDealer());
    }

    @ValidationMethod(on = RESET_PASSWORD_EVENT)
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

    @ValidationMethod(on = RESET_PASSWORD_EVENT)
    public void ensurePasswordHasMinimumLength()
    {
        if (newPassword.length() < 6)
        {
            addLocalizableGlobalError("message.password.errors.newPassword.tooShort");
        }
    }

    @ValidationMethod(on = RESET_PASSWORD_EVENT)
    public void ensurePasswordHasAtLeastOneNumber()
    {
        if (!newPassword.matches(".{0,}[0-9].{0,}"))
        {
            addLocalizableGlobalError("message.password.errors.newPassword.needAtLeastOneNumber");
        }
    }

    public Dealer getLoadedSelectedDealer() throws InvalidDealerException
    {
        return dealerDBService.fetchDealer(dealer.getDealerId());
    }

    public DealerStaff getLoadedSelectedDealerStaff()
    {
        return staffServices.getDealerStaff(dealerStaff.getPersonId());
    }

    public Dealer getDealer()
    {
        return dealer;
    }

    public void setDealer(Dealer dealer)
    {
        this.dealer = dealer;
    }

    public DealerStaff getDealerStaff()
    {
        return dealerStaff;
    }

    public void setDealerStaff(DealerStaff dealerStaff)
    {
        this.dealerStaff = dealerStaff;
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
}
