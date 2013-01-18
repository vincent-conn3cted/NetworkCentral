package au.com.toyota.nc.webapp.stripes.admin;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import au.com.toyota.nc.common.model.hibernate.AbstractContact;
import au.com.toyota.nc.common.model.hibernate.TMCAStaff;
import au.com.toyota.nc.common.staff.exceptions.DeleteTmcaStaffException;
import au.com.toyota.nc.webapp.stripes.ext.converters.PhoneNumberConverter;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.DontValidate;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidateNestedProperties;
import net.sourceforge.stripes.validation.ValidationErrorHandler;
import net.sourceforge.stripes.validation.ValidationErrors;
import org.apache.log4j.Logger;

/**
 * User: Alex Wibowo
 * Date: 09/02/2009
 * Time: 12:58:12 PM
 */
public class ManageTMCAFieldRepresentativesActionBean extends AdministrationActionBean implements ValidationErrorHandler
{
    private static final Logger LOGGER = Logger.getLogger(ManageTMCAFieldRepresentativesActionBean.class.getName());

    public static final String EVENT_LIST = "listTMCAFieldReps";
    public static final String EVENT_GET = "getTMCAFieldReps";
    public static final String EVENT_SAVE = "saveTMCAFieldReps";
    public static final String EVENT_ADD = "addTMCAFieldReps";

    @ValidateNestedProperties({
        @Validate(field = "firstname", required = true, on = EVENT_SAVE, maxlength = TMCAStaff.MAX_FIRSTNAME),
        @Validate(field = "surname", required = true, on = EVENT_SAVE, maxlength = TMCAStaff.MAX_SURNAME),
        @Validate(field = "tmcaPIN", required = true, on = EVENT_SAVE, maxlength = TMCAStaff.MAX_TMCAPIN),
        @Validate(field = "contact.mobile", maxlength = AbstractContact.MAX_MOBILE),
        @Validate(field = "contact.phone", maxlength = AbstractContact.MAX_PHONE, required=false, converter = PhoneNumberConverter.class),
        @Validate(field = "contact.fax", maxlength = AbstractContact.MAX_FAX, required=false, converter = PhoneNumberConverter.class),
        @Validate(field = "contact.email", maxlength = AbstractContact.MAX_EMAIL)
            })
    private TMCAStaff staff;

    private boolean displayForm = false;

    private static final String REQUEST_PARAM_STAFF_ID = "staff.personId";

    @DefaultHandler
    @HandlesEvent(EVENT_LIST)
    public Resolution displayTMCAFieldReps()
    {
        return new ForwardResolution(ADMIN_JSP_BASE + "/maintainTMCAFieldReps.jsp");
    }

    @DontValidate
    @HandlesEvent(EVENT_ADD)
    public Resolution addTMCAFieldRep()
    {
        displayForm = true;
        return displayTMCAFieldReps();
    }

    /**
     * Save/Update {@link #staff}
     *
     * @return redirect resolution to get the edited staff
     */
    @HandlesEvent(EVENT_SAVE)
    public Resolution saveTMCAFieldRep()
    {
        staff = (TMCAStaff) staffServices.save(staff);
        addLocalizableGlobalMessage("message.save.success");
        return new RedirectResolution(getClass(), EVENT_GET).addParameter(REQUEST_PARAM_STAFF_ID, staff.getPersonId());
    }

    @HandlesEvent(EVENT_GET)
    public Resolution getTMCAFieldRep()
    {
        if (staff == null || staff.getPersonId() == null)
        {
            addLocalizableValidationError("staff.personId", "/admin/ManageTMCAFieldRepresentatives.action.edit.staffId.required");
            return displayTMCAFieldReps();
        }

        staff = staffServices.getTMCAStaff(staff.getPersonId());
        if (staff == null)
        {
            addLocalizableValidationError("staff.personId", "error.model.notfound", "TMCA Field Representative");
        }
        else
        {
            displayForm = true;
        }
        return displayTMCAFieldReps();
    }

    @HandlesEvent("discontinue")
    public Resolution discontinue()
    {
        staffServices.discontinue(staff.getPersonId());
        return new RedirectResolution(ManageTMCAFieldRepresentativesActionBean.class, "displayTMCAFieldReps");
    }

    @HandlesEvent("delete")
    public Resolution delete()
    {
        Resolution redirectResolution;
        try
        {
            staffServices.deleteTmcaStaff(staff.getPersonId());
            redirectResolution = new RedirectResolution(ManageTMCAFieldRepresentativesActionBean.class, "displayTMCAFieldReps");
        }
        catch (DeleteTmcaStaffException e)
        {
            addSimpleGlobalError(e.getMessage());
            redirectResolution = new ForwardResolution(ADMIN_JSP_BASE + "/maintainTMCAFieldReps.jsp");
        }
        return redirectResolution;
    }

    public TMCAStaff getStaff()
    {
        return staff;
    }

    public void setStaff(TMCAStaff staff)
    {
        this.staff = staff;
    }

    public boolean isDisplayForm()
    {
        return displayForm;
    }

    public void setDisplayForm(boolean displayForm)
    {
        this.displayForm = displayForm;
    }

    public Resolution handleValidationErrors(ValidationErrors errors) throws Exception
    {
        // On validation error, display the form
        displayForm = true;
        return context.getSourcePageResolution();
    }
    
    /**
     * Get the actual username from the toyota LDAP using the T/K number or the dealer name.  
     * @return The actual name from e-Dir
     */
    public String getLastMaintainedUserNameFromLDAP() {
    	return getLastMaintainedUserName(staff);
    }

}
