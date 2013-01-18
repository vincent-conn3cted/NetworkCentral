package au.com.toyota.nc.webapp.stripes.staff.dealerstaff;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import net.sourceforge.stripes.action.Before;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.controller.LifecycleStage;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidateNestedProperties;
import net.sourceforge.stripes.validation.ValidationMethod;

import org.apache.commons.lang.StringUtils;

import au.com.toyota.nc.common.model.hibernate.Appointment;
import au.com.toyota.nc.common.model.hibernate.DealerStaff;
import au.com.toyota.nc.common.model.hibernate.Language;
import au.com.toyota.nc.common.model.hibernate.Staff;
import au.com.toyota.nc.common.staff.UpdateDealerStaffResponse;
import au.com.toyota.nc.common.staff.exceptions.DealerStaffValidationException;
import au.com.toyota.nc.common.utils.NCCollectionUtils;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;

public abstract class AbstractManageStaffActionBean extends BaseActionBean
{
    protected static final String SAVE_OR_UPDATE_EVENT = "saveOrUpdate";
    
    protected static final String CHECK_WARNING_EVENT = "checkWarning";
    
    private static final String NAME_WARNING_MESSAGE = "If you proceed with this change the staff member's usercode(s) will be updated to reflect their new name. This may impact other applications e.g Showroom Direct";
    private static final String DOB_WARNING_MESSAGE = "If you proceed with this change the salesperson record in SAP will be discontinued and a new one created for their new DOB.";


    @ValidateNestedProperties({
        @Validate(field = "firstname", on = SAVE_OR_UPDATE_EVENT, maxlength = Staff.MAX_FIRSTNAME),
        @Validate(field = "surname", on = SAVE_OR_UPDATE_EVENT, maxlength = Staff.MAX_SURNAME),
        @Validate(field = "spouseSurname", on = SAVE_OR_UPDATE_EVENT, maxlength = 50),
        @Validate(field = "spouseFirstname", on = SAVE_OR_UPDATE_EVENT, maxlength = 50),
        @Validate(field = "dob", on = SAVE_OR_UPDATE_EVENT),
        @Validate(field = "title", on = SAVE_OR_UPDATE_EVENT),
        @Validate(field = "trainingIdNumber", on = SAVE_OR_UPDATE_EVENT, maxlength = 25),
        @Validate(field = "salesSocietyNumber", on = SAVE_OR_UPDATE_EVENT, maxlength = 25),
        @Validate(field = "technicianSocietyNumber", on = SAVE_OR_UPDATE_EVENT, maxlength = 25)
            })
    private DealerStaff dealerStaff;

    private List<Language> selectedLanguages;

    private String oldFirstname;

    private String oldLastname;

    private Date oldDob;

    private List<Appointment> selectedAppointments;
    
    private String nameChangeWarning;
    
    private String dobChangeWarning;
    
    private boolean bypassDuplicateRule;
    
	public abstract Resolution saveOrUpdate();

    protected void doSaveOrUpdate() throws DealerStaffValidationException
    {
        dealerStaff.setLanguages(getSelectedLanguages());
        dealerStaff.getAppointments().addAll(getSelectedAppointments());
        if (dealerStaff.getPersonId() == null)
        {
            doSave();
        }
        else
        {
            doUpdate();
        }
        setSelectedLanguages(getDealerStaff().getLanguages());
    }
    
    protected boolean checkIfWarningShouldBeDisplayed() {
    	List<Appointment> activeAppointments = dealerStaff.getActiveAppointments();
    	//check if the name change and DOB warnings needs to be displayed.
    	checkForNameChanges(activeAppointments);
    	checkForDobChanges(activeAppointments);
    	if ((StringUtils.isNotBlank(getNameChangeWarning())) || (StringUtils.isNotBlank(getDobChangeWarning())))  {
    		return true;
    	}
    	else return false;
    }

	private void checkForNameChanges(List<Appointment> activeAppointments) {
		if (activeAppointments.size() > 0) {
    		if ( !(dealerStaff.getFirstname().equals(oldFirstname)) || !(dealerStaff.getSurname().equals(oldLastname)) ) {
    			setNameChangeWarning(NAME_WARNING_MESSAGE);
    		}
    	}
	}

	private void checkForDobChanges(List<Appointment> activeAppointments) {
		for (Appointment appointment : activeAppointments) {
    		if (appointment.getSalesIndicator()) {
    			if (dealerStaff.getDob().compareTo(oldDob) != 0) {
    				setDobChangeWarning(DOB_WARNING_MESSAGE);
    			}
    		}
    	}
	}

    private void doSave() throws DealerStaffValidationException
    {
        dealerStaff = staffTopology.create(dealerStaff, bypassDuplicateRule);
        addLocalizableGlobalMessage("dealerstaffsearch.create.success");
    }

    private void doUpdate() throws DealerStaffValidationException
    {
    	// we need to clear the cache here as the object in Hibernate cache is dirty at this stage.
    	// as while updating the staff, we search the database for duplicate and get a "a different object with the same identifier already exists in teh session" exception.
    	dbServices.clearCache();
        final UpdateDealerStaffResponse response = staffTopology.updateStaff(oldFirstname, oldLastname, oldDob, dealerStaff, bypassDuplicateRule);
        dealerStaff = response.getDealerStaff();
        if (nameHasNotChanged() || staffHadNoAppointmentsToUpdateInLdap())
        {
            addLocalizableGlobalMessage("dealerstaffsearch.update.success");
        }
        else
        {
            addLocalizableGlobalMessage("dealerstaffsearch.updateWithLdap.success", NCCollectionUtils.combineWithSeperator(response.getUsercodeSuccesses(), "<br/>"));
        }
    }

    @Before(stages = LifecycleStage.BindingAndValidation, on = {SAVE_OR_UPDATE_EVENT, CHECK_WARNING_EVENT})
    public void ensureDealerStaffIsSet()
    {
        final String personIdValue = context.getRequest().getParameter("dealerStaff.personId");
        if(personIdValue != null)
        {
            final long personId = Long.parseLong(personIdValue);
            final DealerStaff loadedDealerStaff = staffServices.getDealerStaff(personId);
            dealerStaff = new DealerStaff(loadedDealerStaff);
        }
        else
        {
            dealerStaff = new DealerStaff();
        }
    }

    // yes, one wonders why this is here when a simple required=true might be all thats required on the dealerStaff validation annotation above....
    // but it is required... i suspect its a stripes bug but could easily be something that we are doing incorrectly...
    // anyway, the problem is that, despite PRE-BINDING the dealerstaff record, and DESPITE the firstname (et al) being present in the
    // loaded staff, and DESPITE the staff being set in the dealerStaff field, the validation STILL FAILS!!! saying that firstname (et al) is
    // not present?!
    // the solution is a workaround. tell the validation annotation NOT to validate required fields, and validation required fields
    // explicitly, thereby fully controlling whehter a field is null or not.... hopefully this wont cause anyone to shoot me when it comes to
    // maintenance.... i fully apologize now if something else ive done has caused this wierd situation to occur ;)
    @ValidationMethod(on = {SAVE_OR_UPDATE_EVENT})
    public void ensureThatMandatoryFieldsArePopulated()
    {
        if(dealerStaff != null)
        {
            if(dealerStaff.getDob() == null)
            {
                addLocalizableValidationError("dealerStaff.dob", "validation.required.valueNotPresent");
            }
            if(StringUtils.isBlank(dealerStaff.getFirstname()))
            {
                addLocalizableValidationError("dealerStaff.firstname", "validation.required.valueNotPresent");                
            }
            if(dealerStaff.getTitle() == null)
            {
                addLocalizableValidationError("dealerStaff.title", "validation.required.valueNotPresent");                
            }
            if(StringUtils.isBlank(dealerStaff.getSurname()))
            {
                addLocalizableValidationError("dealerStaff.surname", "validation.required.valueNotPresent");
            }
        }
    }

    private boolean staffHadNoAppointmentsToUpdateInLdap()
    {
        return dealerStaff.getActiveAppointments().size() == 0;
    }

    private boolean nameHasNotChanged()
    {
        return getOldLastname().equals(getDealerStaff().getSurname()) && getOldFirstname().equals(getDealerStaff().getFirstname());
    }

    public String getOldFirstname()
    {
        return oldFirstname;
    }

    public void setOldFirstname(String oldFirstname)
    {
        this.oldFirstname = oldFirstname;
    }

    public String getOldLastname()
    {
        return oldLastname;
    }

    public void setOldLastname(String oldLastname)
    {
        this.oldLastname = oldLastname;
    }

    public Date getOldDob()
    {
        return oldDob;
    }

    public void setOldDob(Date oldDob)
    {
        this.oldDob = oldDob;
    }

    public DealerStaff getDealerStaff()
    {
        return dealerStaff;
    }

    public void setDealerStaff(DealerStaff dealerStaff)
    {
        this.dealerStaff = dealerStaff;
    }

    public List<Language> getSelectedLanguages()
    {
        if (selectedLanguages == null)
        {
            selectedLanguages = new ArrayList<Language>();
        }
        return selectedLanguages;
    }

    public void setSelectedLanguages(List<Language> selectedLanguages)
    {
        this.selectedLanguages = selectedLanguages;
    }

    public Set<Language> getAllLanguages()
    {
        final Set<Language> allLanguages = new LinkedHashSet<Language>(masterTableServices.findAllActive(Language.class));
        if (dealerStaff != null)
        {
            allLanguages.addAll(dealerStaff.getLanguages());
        }
        return allLanguages;
    }

    public List<Appointment> getSelectedAppointments()
    {
        if (selectedAppointments == null)
        {
            selectedAppointments = new ArrayList<Appointment>();
        }
        return selectedAppointments;
    }

    public void setSelectedAppointments(List<Appointment> selectedAppointments)
    {
        this.selectedAppointments = selectedAppointments;
    }

	public String getNameChangeWarning() {
		return nameChangeWarning;
	}

	public void setNameChangeWarning(String nameChangeWarning) {
		this.nameChangeWarning = nameChangeWarning;
	}

	public String getDobChangeWarning() {
		return dobChangeWarning;
	}

	public void setDobChangeWarning(String dobChangeWarning) {
		this.dobChangeWarning = dobChangeWarning;
	}

	public boolean isBypassDuplicateRule() {
		return bypassDuplicateRule;
	}

	public void setBypassDuplicateRule(boolean bypassDuplicateRule) {
		this.bypassDuplicateRule = bypassDuplicateRule;
	}

}
