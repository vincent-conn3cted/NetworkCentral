package au.com.toyota.nc.webapp.stripes.staff.dealerstaff;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.logging.Logger;

import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.integration.spring.SpringBean;
import au.com.toyota.isd.common.ldap.model.User;
import au.com.toyota.nc.common.model.hibernate.Appointment;
import au.com.toyota.nc.common.model.hibernate.Language;
import au.com.toyota.nc.common.security.staff.ManageStaffSecurityContext;
import au.com.toyota.nc.common.staff.exceptions.DealerStaffValidationException;

public class DealerStaffActionBean extends AbstractManageStaffActionBean
{
    private static final Logger LOG = Logger.getLogger(DealerStaffActionBean.class.getName());
    private static final String DEALER_STAFF_JSP_BASE = JSP_BASE + "/staff/dealerstaff";
    private static final String APPOINTMENT_LINKS_FOUND = "APPOINTMENT_LINKS_FOUND";    
    
    @SpringBean
    private ManageStaffSecurityContext manageStaffSecurityContext;

    private boolean readOnly;
    private String eligible="false";
    
    private boolean showWarning;
    
    private boolean showNationalAdminDuplicateConfirmation;
    
    @DefaultHandler
    @HandlesEvent("add")
    public Resolution add()
    {
        setSelectedLanguages(new ArrayList<Language>());
        return new ForwardResolution(DEALER_STAFF_JSP_BASE + "/add.jsp");
    }

    @HandlesEvent(SAVE_OR_UPDATE_EVENT)
    public Resolution saveOrUpdate()
    {
        Resolution resolution;
        try
        {
            doSaveOrUpdate();
            resolution = new RedirectResolution(DealerStaffActionBean.class, "edit").addParameter("dealerStaff.personId", getDealerStaff().getPersonId()).flash(this);
        }
        catch (DealerStaffValidationException e)
        {
        	if (getContext().getUserRole().isNationalAdmin()) {
        		setShowNationalAdminDuplicateConfirmation(true);
        	}
        	else {
        		addSimpleGlobalError(e.getMessage());
        	}
        	//check if its a error on adding new staff or updating existing one. 
        	if (getDealerStaff().getPersonId() != null) {
        		// repopulate the hibernate session with the dealerStaff object as needed by the JSP to display.
        		setDealerStaff(staffServices.getDealerStaff(getDealerStaff().getPersonId()));
        	}
        	resolution = getContext().getSourcePageResolution();
        }
        return resolution;
    }
    
    

    @HandlesEvent("edit")
    public Resolution edit()
    {
    	
        sendAlertMessageWhenAppointmentHasLinks();
        
        setDealerStaff(staffServices.getDealerStaff(getDealerStaff().getPersonId()));
        setOldDob(getDealerStaff().getDob());
        setOldFirstname(getDealerStaff().getFirstname());
        setOldLastname(getDealerStaff().getSurname());
        setSelectedLanguages(getDealerStaff().getLanguages());
        return new ForwardResolution(DEALER_STAFF_JSP_BASE + "/edit.jsp");
    }

	private void sendAlertMessageWhenAppointmentHasLinks() {
		if(context.getRequest().getSession().getAttribute(APPOINTMENT_LINKS_FOUND) != null){
        	context.getRequest().getSession().removeAttribute(APPOINTMENT_LINKS_FOUND);
            context.getRequest().setAttribute(APPOINTMENT_LINKS_FOUND, "true");
        }
	}
    
    @HandlesEvent("checkWarning")
	public Resolution checkWarning() {
		if (checkIfWarningShouldBeDisplayed()) {
			setShowWarning(true);
			return new ForwardResolution(DEALER_STAFF_JSP_BASE + "/edit.jsp");
		} else {
			return saveOrUpdate();
		}
	}
    
    @HandlesEvent("nationalAdminSaveOrUpdate")
    public Resolution nationalAdminSaveOrUpdate() {
    	setBypassDuplicateRule(true);
    	return saveOrUpdate();
    }

	public List<Appointment> getStaffsAppointments()
    {
        return manageStaffSecurityContext.getAppointmentsFor(getDealerStaff(), getContext().getUserRole());
    }

    public boolean getStaffIsAssociatedToUsersDealer()
    {
        return manageStaffSecurityContext.canUserManageStaff(getDealerStaff(), getContext().getUserDetails(), getContext().getUserRole());
    }
    
    public boolean getHasDpGmrAppointments()
    {
        return getDealerStaff().getDpGmrAppointments().size() > 0;
    }

    public boolean isReadOnly()
    {
        return readOnly;
    }

    public void setReadOnly(boolean readOnly)
    {
        this.readOnly = readOnly;
    }

    public boolean isShowWarning() {
		return showWarning;
	}

	public void setShowWarning(boolean showWarning) {
		this.showWarning = showWarning;
	}

	public boolean isShowNationalAdminDuplicateConfirmation() {
		return showNationalAdminDuplicateConfirmation;
	}

	public void setShowNationalAdminDuplicateConfirmation(boolean showNationalAdminDuplicateConfirmation) {
		this.showNationalAdminDuplicateConfirmation = showNationalAdminDuplicateConfirmation;
	}

	public String getEligible() {
        return eligible;
    }

    public void setEligible(String eligible) {
        this.eligible = eligible;
    }
    
    /**
     * Get the last maintained actual username from the toyota LDAP using the T/K number or the dealer name.  
     * @return The actual name from e-Dir
     */
    public String getLastMaintainedUserNameFromLDAP() {
    	return getLastMaintainedUserName(getDealerStaff());
    }
    
    /**
     * Get the actual lastmaintained username for the staff's appointments 
     * from the toyota LDAP using the T/K number or the dealer name.  
     * @return The actual name from e-Dir
     */
    public List<String> getLastMaintainedAppointmentsUserNameListFromLDAP() {
    	List<String> userNameFromLDAP = new ArrayList<String>();
    	for (Appointment appointment : getStaffsAppointments()) {
    			userNameFromLDAP.add(getLastMaintainedUserName(appointment));
    	}
    	return userNameFromLDAP;
    }
    
}