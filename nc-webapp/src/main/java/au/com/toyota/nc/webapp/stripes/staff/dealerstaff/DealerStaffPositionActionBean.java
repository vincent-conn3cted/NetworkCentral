package au.com.toyota.nc.webapp.stripes.staff.dealerstaff;

import static java.util.Arrays.asList;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

import net.sourceforge.stripes.action.Before;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.controller.LifecycleStage;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidateNestedProperties;
import net.sourceforge.stripes.validation.ValidationMethod;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.joda.time.DateTime;

import au.com.toyota.nc.common.comparartors.GenericComparator;
import au.com.toyota.nc.common.dealers.exceptions.InvalidDealerException;
import au.com.toyota.nc.common.helper.AppointmentHelper;
import au.com.toyota.nc.common.model.DateRange;
import au.com.toyota.nc.common.model.DealerStaffSearchRequest;
import au.com.toyota.nc.common.model.DealerStaffSearchResponse;
import au.com.toyota.nc.common.model.hibernate.Appointment;
import au.com.toyota.nc.common.model.hibernate.AppointmentContact;
import au.com.toyota.nc.common.model.hibernate.AppointmentDepartment;
import au.com.toyota.nc.common.model.hibernate.Dealer;
import au.com.toyota.nc.common.model.hibernate.DealerStaff;
import au.com.toyota.nc.common.model.hibernate.Department;
import au.com.toyota.nc.common.model.hibernate.Location;
import au.com.toyota.nc.common.model.hibernate.Position;
import au.com.toyota.nc.common.model.hibernate.PositionDefinition;
import au.com.toyota.nc.common.security.staff.ManageStaffSecurityContext;
import au.com.toyota.nc.common.staff.SapUsernameModificationHandler;
import au.com.toyota.nc.common.staff.exceptions.AppointmentNotFoundException;
import au.com.toyota.nc.common.staff.exceptions.SaveAppointmentValidationException;
import au.com.toyota.nc.common.utils.NCCollectionUtils;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;
import au.com.toyota.nc.common.model.TrainingApprovalMgr;
import au.com.toyota.nc.webapp.stripes.ext.converters.PhoneNumberConverter;
import au.com.toyota.nc.webapp.stripes.staff.AppointmentSourceActionType;
import au.com.toyota.nc.webapp.stripes.staff.mydetails.MyDetailsActionBean;

public class DealerStaffPositionActionBean extends BaseActionBean
{


	private static final Logger LOG = Logger.getLogger(DealerStaffPositionActionBean.class);

    private static final String APPOINTMENTS_JSP_BASE = JSP_BASE + "/staff/appointments";
    private static final String EVENT_CREATE = "create";
    private static final String EVENT_UPDATE = "update";
    private static final String EDIT = "edit";
    private static final String REQUEST_PARAM_APPOINTMENT_ID = "appointment.appointmentId";
    private static final String GET_POSITION_DEFINITIONS_AS_PER_SELECTED_POSITION = "getPositionDefinitionsAsPerSelectedPosition";
    private static final String APPOINTMENT_LINKS_FOUND = "APPOINTMENT_LINKS_FOUND";
    private static final String INVALID_TRAINING_APPROVAL_MANAGER = "INVALID_TRAINING_APPROVAL_MANAGER";
   
    
    @SpringBean
    private SapUsernameModificationHandler sapUsernameModificationHandler;

    @SpringBean
    private ManageStaffSecurityContext manageStaffSecurityContext;

    @ValidateNestedProperties({
        @Validate(field = "location.locationId", on = {EVENT_CREATE, EVENT_UPDATE}), //validation is put on the validation method
        @Validate(field = "person.personId", on = {EVENT_CREATE, EVENT_UPDATE}), //validation is put on the validation method
        @Validate(field = "selectedPositionId", on = {EVENT_CREATE, EVENT_UPDATE}), //validation is put on the validation method
        @Validate(field = "appointmentDate.startDate", on = {EVENT_CREATE, EVENT_UPDATE}), //validation is put on the validation method
        @Validate(field = "appointment.contact.phone", on = {EVENT_CREATE, EVENT_UPDATE}), //validation is put on the validation method
        @Validate(field = "appointment.contact.email", on = {EVENT_CREATE, EVENT_UPDATE}), //validation is put on the validation method
        @Validate(field = "appointment.trainingManager.appointmentId", on = {EVENT_CREATE, EVENT_UPDATE}), //validation is put on the validation method
        @Validate(field = "contact.phone", on = {EVENT_CREATE, EVENT_UPDATE}, maxlength = 12, required=false, converter = PhoneNumberConverter.class),
        @Validate(field = "contact.mobile", on = {EVENT_CREATE, EVENT_UPDATE}, maxlength = 12, required=false, converter = PhoneNumberConverter.class),
        @Validate(field = "contact.fax", on = {EVENT_CREATE, EVENT_UPDATE}, maxlength = 12, required=false, converter = PhoneNumberConverter.class)
            })
    private Appointment appointment;

    private List<Location> locations;

    private Long selectedDealerId;
    
    private Long dpGmrFlag;   
    
    private String personId;

    private List<Department> appointmentDepartments;

    private AppointmentSourceActionType sourceActionType;

    private String oldSapUsername;

    private Long selectedPositionId;
    
    private Long selectedPositionDefinitionId;
    
    private List<PositionDefinition> positionDefinitions;
    
    private List<TrainingApprovalMgr> trainingManagers;
    

    @HandlesEvent("add")
    public Resolution add()
    {
        DealerStaff dealerStaff = staffServices.getDealerStaff(appointment.getPerson().getPersonId());
        DealerStaffSearchRequest dealerStaffSearchRequest = new DealerStaffSearchRequest();
        dealerStaffSearchRequest.setFirstname(dealerStaff.getFirstname());
        dealerStaffSearchRequest.setSurname(dealerStaff.getSurname());
        
        DealerStaffSearchResponse dealerStaffSearchResponse = staffServices.findDealerStaff(dealerStaffSearchRequest);
        
//        if (dealerStaffSearchResponse.getUsers().size() > 1){
//            return new RedirectResolution(DealerStaffPositionDOBValidationActionBean.class).addParameter(REQUEST_PARAM_APPOINTMENT_ID, appointment.getAppointmentId());
//        }else{
            return new ForwardResolution(APPOINTMENTS_JSP_BASE + "/add.jsp");
//        }
    }

    @HandlesEvent("addDpGmr")
    public Resolution addDpGmr()
    {
        return new ForwardResolution(APPOINTMENTS_JSP_BASE + "/addDpGmr.jsp");
    }

    @HandlesEvent("showLocationsForDealer")
    public Resolution showLocationsForDealer() throws InvalidDealerException
    {
        locations = getEligibleLocations();
        return new ForwardResolution(APPOINTMENTS_JSP_BASE + "/showLocations.jsp");
    }

    @HandlesEvent("showPrincipalLocationForDealer")
    public Resolution showPrincipalLocationForDealer() throws InvalidDealerException
    {
        locations = asList(dealerDBService.fetchDealer(selectedDealerId).getPrincipalLocation());
        return new ForwardResolution(APPOINTMENTS_JSP_BASE + "/showLocations.jsp");
    }

    @HandlesEvent(EVENT_CREATE)
    public Resolution create()
    {
        Resolution resolution;
        try
        {
            prepareAndSetPositionPositonDefinition();
            appointment = appointmentTopology.create(appointment, appointmentDepartments);
            resolution = redirectToEditStaff();
        }
        catch (SaveAppointmentValidationException e)
        {
            addSimpleGlobalError(e.getMessage());
            resolution = new ForwardResolution(APPOINTMENTS_JSP_BASE + "/addDpGmr.jsp");
        }
        return resolution;
    }

	private void prepareAndSetPositionPositonDefinition() 
	{
		Position position = new Position();
		position.setPositionId(selectedPositionId);
		appointment.setPosition(position);
		PositionDefinition positionDefinition = new PositionDefinition();
		positionDefinition.setCommonValueId(selectedPositionDefinitionId);
		appointment.setPositionDefinition(positionDefinition);
	}

    @HandlesEvent("copy")
    public Resolution copy() throws AppointmentNotFoundException
    {
        final Appointment loadedApppointment = appointmentServices.fetch(appointment.getAppointmentId());
        appointment = copyFields(loadedApppointment);
        selectedDealerId = appointment.getDealer().getDealerId();
        return new ForwardResolution(APPOINTMENTS_JSP_BASE + "/add.jsp");
    }

    @HandlesEvent("discontinue")
    public Resolution discontinue() throws AppointmentNotFoundException
    {
        
        appointmentTopology.discontinue(appointment.getAppointmentId());
    	
        sendAlertMessageWhenAppointmentHasLinks();     	
        addLocalizableGlobalMessage("message.dealerstaffsearch.appointment.discontinue.success");
        return redirectToEditStaff();
    }

    @HandlesEvent(EDIT)
    public Resolution edit() throws AppointmentNotFoundException
    {
        appointment = appointmentServices.fetch(appointment.getAppointmentId());
        oldSapUsername = appointment.getSapInfo().getUsername();
        appointmentDepartments = new ArrayList<Department>();

        for (AppointmentDepartment appointmentDepartment : appointment.getDepartments())
        {
            appointmentDepartments.add(appointmentDepartment.getDepartment());
        }

        validateTrainingManager();
        
        selectedPositionId = appointment.getPosition().getPositionId();

        return new ForwardResolution(APPOINTMENTS_JSP_BASE + "/edit.jsp");
    }

    @HandlesEvent(EVENT_UPDATE)
    public Resolution update() throws AppointmentNotFoundException, SaveAppointmentValidationException
    {
        if(AppointmentSourceActionType.MY_DETAILS == sourceActionType)
        {
            sapUsernameModificationHandler.handle(oldSapUsername, appointment.getSapInfo().getUsername(), appointment);
        }
        prepareAndSetPositionPositonDefinition();
        appointment = appointmentTopology.update(appointment, appointmentDepartments, this.selectedPositionId);

        return redirectToEditStaff();
    }

    @HandlesEvent(GET_POSITION_DEFINITIONS_AS_PER_SELECTED_POSITION)
    public Resolution getPositionDefinitionsAsPerSelectedPosition()
    {
    	return new ForwardResolution(APPOINTMENTS_JSP_BASE + "/showPositionDefinition.jsp");
    }

    @Before(stages = LifecycleStage.BindingAndValidation, on = {EVENT_UPDATE, EDIT, GET_POSITION_DEFINITIONS_AS_PER_SELECTED_POSITION})
    public void ensureAppointmentIsSet()
    {
        String appointmentIdString = context.getRequest().getParameter(REQUEST_PARAM_APPOINTMENT_ID);
        if(!StringUtils.isEmpty(appointmentIdString))
        {
			final long appointmentId = Long.parseLong(appointmentIdString);
	        final Appointment loadedAppointment = appointmentServices.get(appointmentId);
	        appointment = new Appointment(loadedAppointment);
	        appointment.setAppointmentId(appointmentId);
			PositionDefinition positionDefinition = appointment.getPositionDefinition();
	        if(positionDefinition != null)
	        	selectedPositionDefinitionId = positionDefinition.getCommonValueId();
        }
    }

    // yes, one wonders why this is here when a simple required=true might be all thats required on the appointment validation annotation above....
    // but it is required... i suspect its a stripes bug but could easily be something that we are doing incorrectly...
    // anyway, the problem is that, despite PRE-BINDING the appointment record, and DESPITE the start date being present in the
    // loaded staff, and DESPITE the appointment being set in the appointment field, the validation STILL FAILS!!! saying that start date is
    // not present?!
    // the solution is a workaround. tell the validation annotation NOT to validate required fields, and validation required fields
    // explicitly, thereby fully controlling whehter a field is null or not.... hopefully this wont cause anyone to shoot me when it comes to
    // maintenance.... i fully apologize now if something else ive done has caused this wierd situation to occur ;)
    @ValidationMethod(on = {EVENT_CREATE, EVENT_UPDATE})
    public void validateAppointment()
    {
    	if(getAppointment() != null)
        {
            ensureThatMandatoryFieldsArePopulated();
            ensureStartDateOnOrBeforeToday();
            validateSapUsername();
            validateTrainingManager(true);
            validateApprovalChain();
        }
    }

    private void ensureThatMandatoryFieldsArePopulated()
    {
        if(getAppointment().getAppointmentDate().getStartDate() == null)
        {
            addLocalizableValidationError("Start Date in role", "validation.required.valueNotPresent");
        }
        
        if(getAppointment().getTrainingManager() != null && getAppointment().getTrainingManager().getAppointmentId() == -1)
        {
            addLocalizableValidationError("Training Approval Manager", "validation.required.valueNotPresent");
            
        }else if(getAppointment().getPerson() != null && getAppointment().getPerson().getPersonId() != null && getAppointment().getTrainingManager() != null)
        {
            try {
				long currentPersonId = getAppointment().getPerson().getPersonId().longValue();
				long newAppointedTrainingManagerPersonId = appointmentServices.fetch(getAppointment().getTrainingManager().getAppointmentId()).getPerson().getPersonId().longValue();
				
				if(currentPersonId == newAppointedTrainingManagerPersonId){
		            addLocalizableValidationError("Training Approval Manager", "validation.trainingApprovalManager.self.not.allowed");
				}
				
			} catch (AppointmentNotFoundException e) {
				e.printStackTrace();
			}
        }        
        
        if(getAppointment().getLocation() == null || getAppointment().getLocation().getLocationId() == null)
        {
            addLocalizableValidationError("Location", "validation.required.valueNotPresent");
        }
        if(selectedPositionId == null)
        {
            addLocalizableValidationError("Position", "validation.required.valueNotPresent");
        }
        if(selectedPositionDefinitionId == null)
        {
        	addLocalizableValidationError("Position Definition", "validation.required.valueNotPresent");
        }
        if(getAppointment().getPerson() == null || getAppointment().getPerson().getPersonId() == null)
        {
            addLocalizableValidationError("Person", "validation.required.valueNotPresent");
        }
        if(appointmentDepartments == null || appointmentDepartments.size() == 0)
        {
            addLocalizableValidationError("Department(s)", "validation.required.valueNotPresent");
        }
        if ((org.apache.commons.lang.StringUtils.isBlank(getAppointment().getContact().getPhone()))) {
        	addLocalizableValidationError("Direct Phone", "validation.required.valueNotPresent");
        }
        if (org.apache.commons.lang.StringUtils.isBlank(getAppointment().getContact().getEmail())) {
        	addLocalizableValidationError("Email Address", "validation.required.valueNotPresent");
        }
        if (StringUtils.isNotBlank(getAppointment().getContact().getEmail())) {
        	if (!validateEmail(getAppointment().getContact().getEmail()) ) {
        		addLocalizableValidationError("Email Address", "validation.email.invalid");
        		
        	}
        }
    }

    private boolean validateEmail(String anEmailId) {
    	boolean valid = true;
    	try {
    		InternetAddress emailAddress = new InternetAddress(anEmailId);
    		emailAddress.validate();
    		if (!hasNameAndDomain(anEmailId)) {
    			valid = false;
    		}
    	}
    	catch(AddressException ex) {
    		valid = false;
    	}
    	return valid;
    }
    
    private boolean hasNameAndDomain(String emailAddress) {
    	String[] part = emailAddress.split("@");
    	 return part.length == 2 &&	StringUtils.isNotEmpty(part[0]) && StringUtils.isNotEmpty(part[1]) && part[1].contains(".") && checkDomain(part[1]);
    }
    
    private boolean checkDomain(String hostDomain) {
    	String domain = hostDomain.substring(hostDomain.indexOf("."));
    	return domain.length() >= 3 ? true : false ;
    }
    
    private void validateSapUsername()
    {
        if (appointment.getSapInfo().getUsername()!=null && appointment.getSapInfo().getUsername().length() > 12){
            addLocalizableValidationError("appointment.sapInfo.username", "validation.maxlength.valueTooLong", "12");
        }
    }

    private void ensureStartDateOnOrBeforeToday()
    {
        final DateRange dateRange = appointment.getAppointmentDate();
        if (dateRange != null)
        {
            final DateTime startDate = new DateTime(dateRange.getStartDate());
            if (startDate.isAfterNow())
            {
                addLocalizableGlobalError("errors.positions.startDate.afterToday");
            }
        }
    }
    
    private Resolution redirectToEditStaff()
    {
    	
        final Resolution redirectResolution;
        if(AppointmentSourceActionType.MAINTAIN_STAFF == getSourceActionType())
        {
            redirectResolution = new RedirectResolution(DealerStaffActionBean.class, EDIT).
                    addParameter("dealerStaff.personId", appointment.getPerson().getPersonId()).flash(this);
        }
        else if(AppointmentSourceActionType.MY_DETAILS == getSourceActionType())
        {
            redirectResolution = new RedirectResolution(MyDetailsActionBean.class, "view");
        }
        else
        {
            throw new RuntimeException("The source action type is required for redirecting after an update");
        }
        return redirectResolution;
    }

    private Appointment copyFields(Appointment loadedApppointment)
    {
        final Appointment cloned = new Appointment();
        cloned.setLocation(new Location());
        cloned.getLocation().setDealer(new Dealer());
        cloned.setContact(new AppointmentContact());

        cloned.getLocation().setLocationId(loadedApppointment.getLocation().getLocationId());
        cloned.getDealer().setDealerId(loadedApppointment.getDealer().getDealerId());
        cloned.getContact().setPhone(loadedApppointment.getContact().getPhone());
        cloned.getContact().setEmail(loadedApppointment.getContact().getEmail());
        cloned.getContact().setFax(loadedApppointment.getContact().getFax());
        cloned.getContact().setMobile(loadedApppointment.getContact().getMobile());

        cloned.getDripInfo().setEmailOptIn(loadedApppointment.getDripInfo().isEmailOptIn());
        cloned.getDripInfo().setSmsOptIn(loadedApppointment.getDripInfo().isSmsOptIn());
        cloned.getDripInfo().setSmsNumber(loadedApppointment.getDripInfo().getSmsNumber());

        cloned.getSapInfo().setSapUsernameActive(loadedApppointment.getSapInfo().isSapUsernameActive());
        cloned.getSapInfo().setUsername(loadedApppointment.getSapInfo().getUsername());

        return cloned;
    }
    
	public List<PositionDefinition> getPositionDefinitions() 
	{
		if(positionDefinitions == null)
		{
	        if(selectedPositionId != null)
	    	{
	    		Position selectedPosition = positionService.get(selectedPositionId);
	    		if(selectedPosition != null && selectedPosition.getPositionDefinitions() != null)
	    		{
	    			List<PositionDefinition> positionDefinitions = selectedPosition.getPositionDefinitions();
	    			//Creating a new list here in order to avoid auto commit the new items added to the list
	    			this.positionDefinitions= new ArrayList<PositionDefinition>(positionDefinitions);
	    			if(appointment != null)
	    			{
	    				addCurrentPositionDefinitionInList(selectedPosition, positionDefinitions, appointment.getPositionDefinition());
	    			}
	    		}
	    	}
	        
	        if(positionDefinitions != null)
	        {
	        	Collections.sort(positionDefinitions, new GenericComparator<PositionDefinition>("description", true));
	        }
		}
        return positionDefinitions;
	}

	private void addCurrentPositionDefinitionInList(Position selectedPosition, List<PositionDefinition> positionDefinitionsCopy, PositionDefinition currentPositionDefinition) 
	{
		 if(currentPositionDefinition != null)
		 {
			 if(positionDefinitionsCopy == null)
				 return;
			 Position currentPosition = appointment.getPosition();
			 if(currentPosition == null)
				 return;
			 
			 if(currentPosition.getPositionId().equals(selectedPosition.getPositionId()))
			 {
				 if(!positionDefinitionsCopy.contains(currentPositionDefinition))
				 {
					 positionDefinitionsCopy.add(currentPositionDefinition);
				 }
			 }					 
		 }
	}
    
    

    public List<Location> getEligibleLocations()
    {
        return usersDealerService.getEligibleAppointmentLocationsFor(getContext().getUserDetails(), getContext().getUserRole(), selectedDealerId);
    }

    public List<Position> getAllEligiblePositions()
    {
        return positionService.getAllNonDpGmrPositions();
    }

    public boolean getIsSalesPositionSelected()
    {
        boolean isSales = false;
        if(getSelectedPositionId() != null)
        {
            final Position position = positionService.get(getSelectedPositionId());
            isSales = position.isSales();
        }
        return isSales;
    }

    public List<Position> getAllDpGmrPositions()
    {
        return positionService.getAllDpGmrPositions();
    }

    public Appointment getAppointment()
    {
        return appointment;
    }

    public void setAppointment(Appointment appointment)
    {
        this.appointment = appointment;
    }

    public List<Location> getLocations()
    {
        return locations;
    }

    public void setLocations(List<Location> locations)
    {
        this.locations = locations;
    }

    public Long getSelectedDealerId()
    {
        return selectedDealerId;
    }

    public void setSelectedDealerId(Long selectedDealerId)
    {
        this.selectedDealerId = selectedDealerId;
    }

    public List<Department> getAppointmentDepartments()
    {
        return appointmentDepartments;
    }

    public void setAppointmentDepartments(List<Department> appointmentDepartments)
    {
        this.appointmentDepartments = appointmentDepartments;
    }

    public String getAppointmentDepartmentsValues()
    {
        return NCCollectionUtils.combineAsCommaSeparatedString(getAppointmentDepartments());
    }

    public AppointmentSourceActionType getSourceActionType()
    {
        return sourceActionType;
    }

    public void setSourceActionType(AppointmentSourceActionType sourceActionType)
    {
        this.sourceActionType = sourceActionType;
    }

    public String getOldSapUsername()
    {
        return oldSapUsername;
    }

    public void setOldSapUsername(String oldSapUsername)
    {
        this.oldSapUsername = oldSapUsername;
    }

    public Long getSelectedPositionId() {
        return selectedPositionId;
    }

    public void setSelectedPositionId(Long selectedPositionId) {
        this.selectedPositionId = selectedPositionId;
    }

    public boolean getAppointmentIsAssociatedToUsersDealer()
    {
        return manageStaffSecurityContext.canUserManageStaff(getAppointment().getPerson(), getContext().getUserDetails(), getContext().getUserRole());
    }

	public Long getSelectedPositionDefinitionId() {
		return selectedPositionDefinitionId;
	}

	public void setSelectedPositionDefinitionId(Long selectedPositionDefinitionId) {
		this.selectedPositionDefinitionId = selectedPositionDefinitionId;
	}
	
    /**
     * Gets the appointments that are active and authorised training approver
     * 
     */		
	public List<TrainingApprovalMgr> getTrainingManagerAppointments(Long dealerId) {
		List<TrainingApprovalMgr> trainingMgrList = new ArrayList<TrainingApprovalMgr>();
		List<Appointment> result = appointmentServices
				.findTrainingManagerAppointments(dealerId, true, null);

		for (Appointment appointment : result) {
			trainingMgrList.add(AppointmentHelper.convert(appointment));
		}
		return trainingMgrList;
	}	
	
    /**
     * Gets the appointments that are active and authorised training approver
     * Includes also the current appointment even if not active and no longer an authorised approver
     */		
	public List<TrainingApprovalMgr> getTrainingManagerIncludingCurrentAppointment(Long dealerId, Long currentAppointmentId) {
		List<TrainingApprovalMgr> trainingMgrList = new ArrayList<TrainingApprovalMgr>();

		List<Appointment> result = appointmentServices
				.findTrainingManagerAppointments(dealerId, true, currentAppointmentId);
		
		for (Appointment appointment : result) {
			trainingMgrList.add(AppointmentHelper.convert(appointment));
		}
		return trainingMgrList;
	}	

    /**
     * Validate the training manager is active and an authorised training approver
     *
     */	
    private void validateTrainingManager(boolean includeLocalizableValidationError){
    	
        if(getAppointment().getTrainingManager() != null && getAppointment().getTrainingManager().getAppointmentId() != -1){
        	  	
        	if (getAppointment().isDpGmrAppointment())
        	{
        		addLocalizableGlobalError("validation.trainingApprovalManager.no.need");
        	}
        	       	
    		List<Appointment> result = appointmentServices
    		.findActiveTrainingManagerAppointmentById(getAppointment().getTrainingManager().getAppointmentId());
    		    		
    		if(result == null || result.size() == 0){
    			if(includeLocalizableValidationError){
    				addLocalizableValidationError("Training Approval Manager", "validation.invalid.trainingApprovalManager");
    			}
                context.getRequest().setAttribute(INVALID_TRAINING_APPROVAL_MANAGER, getAppointment().getTrainingManager().getAppointmentId().toString());
    		}
    			
    		
        }
    }
    
    
    /**
     * Validate the approval chain
     *
     */	
    private void validateApprovalChain(){
		TrainingApprovalMgr approvalMgr = new TrainingApprovalMgr();
		approvalMgr.setAppointment_id(getAppointment().getTrainingManager().getAppointmentId());
		Appointment apt = appointmentServices.get(getAppointment().getTrainingManager().getAppointmentId());
		approvalMgr.setPersonId(apt.getPerson().getPersonId());
    	if  (getAppointment().getTrainingManager()!= null && getAppointment().getPerson() !=null && (!checkLoop(getAppointment().getPerson().getPersonId()+"", approvalMgr, 5 )))
    		addLocalizableValidationError("Training Approval Manager", "validation.invalid.trainingApprovalManager");
    }
    
    
    
    
    /**
     * Validate the training manager is active and an authorised training approver
     *
     */	
    private void validateTrainingManager(){
    	validateTrainingManager(false);
    }    

	private void sendAlertMessageWhenAppointmentHasLinks() {
		List<Appointment> appointmentLinks = appointmentServices.getActiveAppointmentsLinkToTrainingManager(appointment.getAppointmentId());
        if(appointmentLinks != null && appointmentLinks.size() > 0){
            context.getRequest().getSession().setAttribute(APPOINTMENT_LINKS_FOUND, "true");
        }
	}    
    
    @HandlesEvent("showTrainingManagersForDealer")
    public Resolution showTrainingManagersForDealer() throws InvalidDealerException
    {

    	getTrainingManagers();
    	
		if(getDpGmrFlag() != null && getDpGmrFlag() == 1)
        context.getRequest().setAttribute("isDpGmrFlag", "true");
		
        return new ForwardResolution(APPOINTMENTS_JSP_BASE + "/showTrainingManagers.jsp");
    }
    
   
	public List<TrainingApprovalMgr> getTrainingManagers() {
		Long currentAppointmentTrainingManagerId = (getAppointment() != null && getAppointment().getAppointmentId() != null && getAppointment().getTrainingManager() != null ) 
			? getAppointment().getTrainingManager().getAppointmentId() 
			: null;
			
		if  ((getDpGmrFlag() != null && getDpGmrFlag() == 1) || (getAppointment() !=null &&  getAppointment().isDpGmrAppointment()))
		{
			List<TrainingApprovalMgr> result = new ArrayList<TrainingApprovalMgr>();
			
			if  ((getAppointment() != null) &&  (getAppointment().getTrainingManager()!= null))
			{
				Appointment apt = appointmentServices.get(getAppointment().getTrainingManager().getAppointmentId());	
				TrainingApprovalMgr mgr = AppointmentHelper.convert(apt);
				result.add(mgr);
				context.getRequest().setAttribute(INVALID_TRAINING_APPROVAL_MANAGER, getAppointment().getTrainingManager().getAppointmentId().toString());
			}
			
			return result;
		}
			
			
		setSelectedDealerIdIfAvailable();
			
		if(currentAppointmentTrainingManagerId == null){
			trainingManagers = getTrainingManagerAppointments(selectedDealerId);
		}else{
			trainingManagers = getTrainingManagerIncludingCurrentAppointment(selectedDealerId, currentAppointmentTrainingManagerId);
		}
		
		if (((getAppointment()!= null) && (getAppointment().getPerson() != null)) || (getPersonId() != null))
		{
			Iterator<TrainingApprovalMgr> iter = trainingManagers.iterator();
			
			while (iter.hasNext()) {
				
				TrainingApprovalMgr mgr = iter.next();
			    
			    String selfId = getPersonId()!=null? getPersonId(): getAppointment().getPerson().getPersonId()+"";
				
				if (!checkLoop(selfId, mgr, 5 ))
				{
					
					if (getAppointment()!= null && getAppointment().getTrainingManager()!= null && mgr.getAppointment_id().equals(getAppointment().getTrainingManager().getAppointmentId()))
					{
						context.getRequest().setAttribute(INVALID_TRAINING_APPROVAL_MANAGER, getAppointment().getTrainingManager().getAppointmentId().toString());
					}
					else
					{
					   iter.remove();
					}
				}
				
			}		
		}
		

		return trainingManagers;
	}
	

	private void setSelectedDealerIdIfAvailable() {
		if(selectedDealerId == null){
			if(getAppointment() != null && getAppointment().getAppointmentId() != null && getAppointment().getDealer() != null && getAppointment().getDealer().getDealerId() != null)
				selectedDealerId = getAppointment().getDealer().getDealerId();
		}
	}

	public void setTrainingManagers(List<TrainingApprovalMgr> trainingManagers) {
		this.trainingManagers = trainingManagers;
	}

	public Long getDpGmrFlag() {
		return dpGmrFlag;
	}

	public void setDpGmrFlag(Long dpGmrFlag) {
		this.dpGmrFlag = dpGmrFlag;
	}
	
	//detect loop, if false then there is a loop, otherwise there is no loop
	private boolean checkLoop(String selfId, TrainingApprovalMgr trainMgr,  int limit ){
		
		if (limit == 0)
		{
			return true;
		}
				
		if ((selfId == null) || (selfId == "")) 
		{
		    return true;	
		}
		
		if (selfId.equals(trainMgr.getPersonId()+""))
		{
			return false;
		}		
					
        DealerStaff staff = staffServices.getDealerStaff(trainMgr.getPersonId());
        
		Set<Appointment>  appointments = staff.getAppointments();	
				
		for(Appointment apptment: appointments )
		{
	    	
	    	if (!apptment.getDateRange().isActive())
	    	{
	    		continue;
	    	}
	    	
	    	if (apptment.isProvisionalIndicator())
	    	{
	    		continue;
	    	}
									
			if (apptment.getTrainingManager() != null)
			{
				trainMgr = new TrainingApprovalMgr();
				
				trainMgr.setAppointment_id(apptment.getTrainingManager().getAppointmentId());
				
				trainMgr.setPersonId(apptment.getTrainingManager().getPerson().getPersonId());
				
				if (!checkLoop(selfId, trainMgr, limit - 1))
				{
					return false;
				}
			}
			
		}
			
	    return true;	
	}

	public String getPersonId() {
		return personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}	

}
