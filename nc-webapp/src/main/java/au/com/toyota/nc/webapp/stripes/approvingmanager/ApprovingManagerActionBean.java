package au.com.toyota.nc.webapp.stripes.approvingmanager;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidateNestedProperties;
import net.sourceforge.stripes.validation.ValidationMethod;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import weblogic.wsee.util.StringUtil;

import au.com.toyota.nc.common.helper.AppointmentHelper;
import au.com.toyota.nc.common.model.ChangeAppointment;
import au.com.toyota.nc.common.model.TrainingApprovalMgr;
import au.com.toyota.nc.common.model.hibernate.Appointment;
import au.com.toyota.nc.common.model.hibernate.DealerStaff;
import au.com.toyota.nc.common.model.hibernate.Department;
import au.com.toyota.nc.common.reports.AppointApprovalMgrReportService;
import au.com.toyota.nc.common.reports.MailingLabelsReportService;
import au.com.toyota.nc.webapp.stripes.NetworkCentralPdfResolution;
import au.com.toyota.nc.webapp.stripes.dealerLocations.BaseDealerLocationActionBean;

public class ApprovingManagerActionBean extends BaseDealerLocationActionBean {
	private static final Logger LOGGER = Logger
			.getLogger(ApprovingManagerActionBean.class.getName());

	protected static final String APPROVAL_MANAGER_JSP_BASE = JSP_BASE
			+ "/approvalmanager";

	private static final String EVENT_APPOINTMENT_SEARCH = "searchAppoint";
	private static final String EVENT_APPOINTMENT_SAVE = "saveAppoint";
	private static final String EVENT_APPOINTMENT_PRINT = "printAppoint";

	public static final String REQUEST_PARAM_DEALER_ID = "dealer.dealerId";

	@SpringBean
	private AppointApprovalMgrReportService appointApprovalMgrReportService;

	private List<Appointment> appointments = new ArrayList<Appointment>();

	private Map<Long, String> trainingMgrIdMap;

	private Long dealerId;

	private String departmentStr;

	private String trainningMgrId;

	private String changeList;

	private List<ChangeAppointment> changeAppointment;
	
	List<ChangeAppointment> toBeSavedList;
	
	private StringBuilder trainingMgrPersonIdList = new StringBuilder();

	@DefaultHandler
	public Resolution displayInitialPage() {
		return new ForwardResolution(JSP_BASE + "/approvalmanager/index.jsp");
	}

	@ValidationMethod(on = { EVENT_APPOINTMENT_SAVE })
	public void validateAppointments() {
		List<Appointment> aptsList = new ArrayList<Appointment>();
		
		toBeSavedList = GetChangedAppointments();
		
		if (changeAppointment == null)
			changeAppointment = new ArrayList<ChangeAppointment>();
		
		for (ChangeAppointment apt : changeAppointment) {
			validateTrainingMgr(apt);
				
			if ((!StringUtils.isEmpty(apt.getTrainPersonId())) &&  (!StringUtils.isEmpty(apt.getPersonId())))  
			{				
				if (Long.parseLong(apt.getPersonId()) == Long.parseLong(apt.getTrainPersonId()))
				{
					addLocalizableGlobalError("validation.trainingApprovalManager.of.self");
				}	
			}
			
			if (toBeSavedList.contains(apt))
			{
				if  (!checkLoop(apt, 5, apt.getPersonId()))
			    {
			    	addLocalizableGlobalError("validation.trainingApprovalManager.loop", new Object[]{apt.getAppointmentDescription()});
			    }
			}
		
			
			Appointment appointment = new Appointment();
			appointment.setAppointmentId(Long.parseLong(apt.getId()));
			appointment.setAppointmentDescription(apt
					.getAppointmentDescription());
			appointment.setDpGmrFlag(apt.getDpGmrFlag());
			appointment.setDepartmentListStr(apt.getDepartmentListStr());
			appointment.setCurrentTrainMgrId(apt.getCurrentTrainMgrId());
			DealerStaff person = new DealerStaff();
			person.setPersonId(Long.parseLong(apt.getPersonId()));
			appointment.setPerson(person);

			if ((apt.getTrainMgr() != null) && (!"".equals(apt.getTrainMgr()))) {
				Appointment trainingMgr = new Appointment();
				trainingMgr.setAppointmentId(Long.parseLong(apt.getTrainMgr()));
				trainingMgr.setAppointmentDescription(apt.getTrainMgrDesc());
				DealerStaff person1 = new DealerStaff();
				if (!StringUtil.isEmpty(apt.getTrainPersonId()))
				{
					person1.setPersonId(Long.parseLong(apt.getTrainPersonId()));
				}
				trainingMgr.setPerson(person1);
				appointment.setTrainingManager(trainingMgr);
			}
			aptsList.add(appointment);

		}
		
		appointments = aptsList;

	}

	@HandlesEvent(EVENT_APPOINTMENT_SAVE)
	public Resolution saveAppointments() throws IOException // userFile.getReader
															// throws this
	{	
		appointmentServices.saveTrainMgr(toBeSavedList);
		
		List<Appointment> aptsList = new ArrayList<Appointment>();
		for (ChangeAppointment apt : changeAppointment) {
			
			Appointment appointment = new Appointment();
			appointment.setAppointmentId(Long.parseLong(apt.getId()));
			appointment.setAppointmentDescription(apt
					.getAppointmentDescription());
			appointment.setDpGmrFlag(apt.getDpGmrFlag());
			appointment.setDepartmentListStr(apt.getDepartmentListStr());
			appointment.setCurrentTrainMgrId(apt.getTrainMgr());
			
			DealerStaff person = new DealerStaff();
			person.setPersonId(Long.parseLong(apt.getPersonId()));
			appointment.setPerson(person);

			if ((apt.getTrainMgr() != null) && (!"".equals(apt.getTrainMgr()))) {
				Appointment trainingMgr = new Appointment();
				trainingMgr.setAppointmentId(Long.parseLong(apt.getTrainMgr()));
				trainingMgr.setAppointmentDescription(apt.getTrainMgrDesc());				
				DealerStaff person1 = new DealerStaff();
				person1.setPersonId(Long.parseLong(apt.getTrainPersonId()));
				trainingMgr.setPerson(person1);				
				appointment.setTrainingManager(trainingMgr);
			}
			aptsList.add(appointment);

		}
		appointments = aptsList;
		
		return new ForwardResolution(APPROVAL_MANAGER_JSP_BASE + "/index.jsp");
	
	}

	@HandlesEvent(EVENT_APPOINTMENT_PRINT)
	public Resolution generateReport() throws IOException // userFile.getReader
															// throws this
	{
		List<Appointment> list = new ArrayList<Appointment>();
		
		if (changeAppointment == null)
			changeAppointment = new ArrayList<ChangeAppointment>();
		
		for (ChangeAppointment apt : changeAppointment) {
			list.add(appointmentServices.get(Long.parseLong(apt.getId())));
		}

		if (!("All".equals(getTrainningMgrId())))
		{
		    Appointment trainingApprovalMgr = appointmentServices.get(Long.parseLong(getTrainningMgrId()));
		    trainningMgrId = AppointmentHelper.convert(trainingApprovalMgr).getDescription();	    
		}
		
		
		final ByteArrayOutputStream outputStream = appointApprovalMgrReportService
				.generate(list,getDepartmentStr(), getTrainningMgrId());
		final Resolution resolution = new NetworkCentralPdfResolution(
				outputStream, "AppointApprovalMgrReport.pdf");
		return resolution;
	}

	@HandlesEvent(EVENT_APPOINTMENT_SEARCH)
	public Resolution searchAppointment() throws IOException // userFile.getReader
																// throws this
	{
		// LOGGER.debug("Search Appointment: " + usersFile.getFileName() +
		// " (load for eDMS is: " + loadForEdms + ")");

		Department department = null;
		
		appointments.clear();
		
		getContext().getRequest().getSession()
		.setAttribute("appointTrainManagerMap", null);

		if (!("All".equals(departmentStr))) {
			department = Department.fromDescription(departmentStr);
		}

		Appointment trainingMgr = null;

		if (!("All".equals(trainningMgrId))) {
			trainingMgr = appointmentServices.get(Long
					.parseLong(trainningMgrId));
		}
		
		this.appointments = appointmentServices
				.findAppointmentByDepartmentAndTrainningMgr(staffServices.getDealerIDForGivenUserID(getContext().getLoginId()), department,
						trainingMgr);

		Collections.sort(this.appointments);
		

		for (Appointment apt : appointments) {
			apt = appointmentServices.get(apt.getAppointmentId());

		}

		Map<Long, Long> appointTrainManagerMap = new HashMap<Long, Long>();

		for (Appointment appointment : appointments) {
			if (appointment.getTrainingManager() != null)
				appointTrainManagerMap.put(appointment.getAppointmentId(),
						appointment.getTrainingManager().getAppointmentId());
			else
				appointTrainManagerMap
						.put(appointment.getAppointmentId(), null);
		}

		getContext().getRequest().getSession()
				.setAttribute("appointTrainManagerMap", appointTrainManagerMap);
		
        
		changeAppointment = null;

		return new ForwardResolution(APPROVAL_MANAGER_JSP_BASE + "/index.jsp");
	}

	public List<Appointment> getAppointments() {
		return appointments;
	}

	public List<String> getDepartmentList() {
		List<String> deptList = new ArrayList<String>();
		deptList.add("All");
		for (Department dept : au.com.toyota.nc.common.model.hibernate.Department
				.values()) {
			deptList.add(dept.getDescription());
		}
		return deptList;
	}

	public List<TrainingApprovalMgr> getTrainningMgrList() {
		List<TrainingApprovalMgr> trainingMgrList = new ArrayList<TrainingApprovalMgr>();

		trainingMgrIdMap = new HashMap<Long, String>();

		List<Appointment> result = appointmentServices
				.findTrainingMgrList(staffServices.getDealerIDForGivenUserID(getContext().getLoginId()));

		TrainingApprovalMgr all = new TrainingApprovalMgr();
		all.setDescription("All");

		trainingMgrPersonIdList.append("[");
		for (int index = 0; index < result.size(); index++) {
			Appointment apt = result.get(index);
			trainingMgrList.add(AppointmentHelper.convert(apt));
			trainingMgrIdMap.put(apt.getAppointmentId(), "abc");

		}
		Collections.sort(trainingMgrList);

		return trainingMgrList;
	}

	public String getTrainingMgrPersonIdList() {

		List<Appointment> result = appointmentServices
				.findTrainingMgrList(staffServices.getDealerIDForGivenUserID(getContext().getLoginId()));
		trainingMgrPersonIdList = new StringBuilder();
		trainingMgrPersonIdList.append("[");
		for (int index = 0; index < result.size(); index++) {
			Appointment apt = result.get(index);
			trainingMgrPersonIdList.append("\"" + apt.getPerson().getPersonId() + "\"");
			if (index < result.size() - 1)
			    trainingMgrPersonIdList.append(",");
		}
		trainingMgrPersonIdList.append("]");
		return trainingMgrPersonIdList.toString();
	}
		
	

	public Map<Long, String> getTrainingMgrIdMap() {
		return trainingMgrIdMap;
	}

	public Long getDealerId() {
		return dealerId;
	}

	public void setDealerId(Long dealerId) {
		this.dealerId = dealerId;
	}

	public String getDepartmentStr() {
		return departmentStr;
	}

	public void setDepartmentStr(String departmentStr) {
		this.departmentStr = departmentStr;
	}

	public String getTrainningMgrId() {
		return trainningMgrId;
	}

	public void setTrainningMgrId(String trainningMgrId) {
		this.trainningMgrId = trainningMgrId;
	}

	public String getChangeList() {
		return changeList;
	}

	public void setChangeList(String changeList) {
		this.changeList = changeList;
	}

	public List<ChangeAppointment> getChangeAppointment() {
		return changeAppointment;
	}

	public void setChangeAppointment(List<ChangeAppointment> changeAppointment) {
		this.changeAppointment = changeAppointment;
	}

	private boolean validateTrainingMgr(ChangeAppointment changeAppointment) {
		Appointment appontment = appointmentServices.get(Long
				.parseLong(changeAppointment.getId()));
		if ((changeAppointment.getTrainMgr() == null)
				|| ("".equals(changeAppointment.getTrainMgr()))) {
			if (!appontment.isDpGmrAppointment()) {
				addLocalizableGlobalError("validation.trainingApprovalManager.not.valid");
				return false;
			}

		} else {
			
			if (appontment.isDpGmrAppointment()) {
				addLocalizableGlobalError("validation.trainingApprovalManager.no.need");
				return false;
			}
			
			Long trainingMgrId = Long
					.parseLong(changeAppointment.getTrainMgr());

			if (trainingMgrIdMap == null)
				getTrainningMgrList();

			if (!trainingMgrIdMap.keySet().contains(trainingMgrId)) {
				addLocalizableGlobalError("validation.trainingApprovalManager.not.valid");
				return false;
			}

		}
		return true;
	}

	private List<ChangeAppointment> GetChangedAppointments() {

		Map<Long, Long> appointTrainManagerMap = (HashMap<Long, Long>) getContext()
				.getRequest().getSession()
				.getAttribute("appointTrainManagerMap");

		List<ChangeAppointment> toBeSavedList = new ArrayList<ChangeAppointment>();

		for (ChangeAppointment apt : changeAppointment) {
			if (("".equals(apt.getTrainMgr())) || (apt.getTrainMgr() == null)) {
				if (appointTrainManagerMap.get(Long.parseLong(apt.getId())) != null) {
					toBeSavedList.add(apt);
				}

			} else if (((Long) appointTrainManagerMap.get(Long.parseLong(apt
					.getId())) == null)
					&& ((apt.getTrainMgr() != null) || (!("".equals(apt
							.getTrainMgr()))))) {
				toBeSavedList.add(apt);
			} else if (!(((Long) appointTrainManagerMap.get(Long.parseLong(apt
					.getId()))).equals(Long.parseLong(apt.getTrainMgr())))) {
				toBeSavedList.add(apt);
			}
		}
		return toBeSavedList;
	}
	
	//detect loop, if false then there is a loop, otherwise there is no loop
	private boolean checkLoop(ChangeAppointment apt, int limit, String selfId ){
		
		if (limit == 0)
		{
			return true;
		}
				
		if (apt.getTrainMgr() == null) 
		{
		    return true;	
		}
		
		if (selfId.equals(apt.getTrainPersonId()))
		{	
			return false;
		}
				
			    
        DealerStaff staff = staffServices.getDealerStaff(Long.parseLong(apt.getTrainPersonId()));
		
		Set<Appointment>  appointments = staff.getAppointments();
		
		Boolean found = false;
		
		Long dealerId = staffServices.getDealerIDForGivenUserID(getContext().getLoginId());
			    
	    for(Appointment apptment : appointments)
	    {	    	
	   	
	    	if (!apptment.getDateRange().isActive())
	    	{
	    		continue;
	    	}
	    	
	    	
	    	if (apptment.isProvisionalIndicator())
	    	{
	    		continue;
	    	}
	    	
	    	found = false;
			
			//First check the web page
		    for (ChangeAppointment apt1: changeAppointment)
		    {
		    	if ((apptment.getAppointmentId()+"").equals( apt1.getId()))
		    	{
		    		apt = apt1;
		    		found = true;
		    		break;
		    	}
		    }
		    
		    if (!found)
		    {	
		    	apt = new ChangeAppointment();
		    	
		    	if ((apptment.getTrainingManager() == null) || (apptment.getTrainingManager().getAppointmentId() == -1)) 
		    	{
		    		apt.setTrainMgr(null);
		    		apt.setTrainPersonId(null);
		    	}
		    	else
		    	{
		    		apt.setTrainMgr(apptment.getTrainingManager().getAppointmentId()+"");
		    		apt.setTrainPersonId(apptment.getTrainingManager().getPerson().getPersonId()+"");
		    	}
		    			    	
		    	apt.setId(apptment.getAppointmentId()+"");
		    }
	  				    
	    	if (!checkLoop(apt, limit - 1, selfId))
	    		return false;
	    }
		
		return true;
	}
	
}
