package au.com.toyota.nc.webapp.stripes.staff;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import au.com.toyota.nc.common.model.DealerStaffSearchRequest;
import au.com.toyota.nc.common.model.DealerStaffSearchResponse;
import au.com.toyota.nc.common.model.hibernate.Appointment;
import au.com.toyota.nc.common.model.hibernate.Department;
import au.com.toyota.nc.common.model.hibernate.Position;
import au.com.toyota.nc.common.savedsearch.SavedSearch;
import au.com.toyota.nc.common.savedsearch.SavedSearchRegistry;
import au.com.toyota.nc.common.savedsearch.SavedSearchType;
import au.com.toyota.nc.common.security.NCRole;
import au.com.toyota.nc.common.staff.StaffByDealer;
import au.com.toyota.nc.common.staff.users.UsersDealersService;
import au.com.toyota.nc.webapp.decorator.RequestDecorator;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;
import au.com.toyota.nc.webapp.stripes.staff.search.DealerStaffSearchValidator;
import au.com.toyota.nc.webapp.stripes.staff.search.DealerStaffSearchValidatorFactory;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.integration.spring.SpringBean;
import org.apache.log4j.Logger;

/**
 * User: Deepthi Date: 19/11/2008 Time: 17:06:19
 */
public class DealerStaffSearchActionBean extends BaseActionBean implements
		RequestDecorator {
	private static final Logger LOGGER = Logger
			.getLogger(DealerStaffSearchActionBean.class.getName());

	public static final String EVENT_DISPLAY_SEARCH_CRITERIA = "displaySearchPage";
	public static final String EVENT_DISPLAY_SEARCH_CRITERIA_FOR_VIEW = "displaySearchPageForView";
	public static final String EVENT_PERFORM_SEARCH = "search";
	public static final String EVENT_PERFORM_SEARCH_FOR_VIEW = "searchForView";
	public static final String EVENT_VIEW = "view";
	public static final String EVENT_REMOVE_ALL_APPOINTMENTS = "removeAllAppointments";
	public static final String EVENT_ADD_DEALER_STAFF_TO_INDIVIDUAL = "addDealerStaffIndividual";

	private static final String PREVIOUS_SEARCH_REQUEST = "previous_search_request";
	private static final String DEALER_ID = "dealer.id";
	private static final String DEALER_STAFF_ID = "dealerStaff.id";
	
    private static final String APPOINTMENT_LINKS_FOUND = "APPOINTMENT_LINKS_FOUND"; 	

	@SpringBean
	private SavedSearchRegistry savedSearchRegistry;

	@SpringBean
	private UsersDealersService usersDealersService;

	protected DealerStaffSearchRequest searchReq = new DealerStaffSearchRequest();
	protected DealerStaffSearchResponse searchRsp;

	protected String savedSearchName;

	private List<Department> departments;

	private String searchEventName;

	@DefaultHandler
	@HandlesEvent(EVENT_DISPLAY_SEARCH_CRITERIA)
	public Resolution displaySearchPage() {
		if (getContext().getRequest().getSession(true).getAttribute(RETURN_TO) != null) {
			searchReq.setReturnTo((String) getContext().getRequest()
					.getSession(true).getAttribute(RETURN_TO));
			getContext().getRequest().getSession(true).removeAttribute(
					RETURN_TO);
		}

		departments = Arrays.asList(Department.values());
		return new ForwardResolution(JSP_BASE + "/staff/searchDealerStaff.jsp");
	}

	@HandlesEvent(EVENT_REMOVE_ALL_APPOINTMENTS)
	public Resolution removeAllAppointments() {
		if (getDealerId() == null || getDealerStaffId() == null) {
			addLocalizableGlobalError("error.dealerStaff.discontinue.missingStaffOrDealerID");
		} else {
			
	        sendAlertMessageWhenAppointmentHasLinks();
	        
			appointmentTopology.discontinueAppointmentsForDealerStaffByDealer(
					getDealerStaffId(), getDealerId(), getContext().getUserRole().isNationalAdmin());
			
			
			
		}
		// this value can not be null, if the flow is followed correctly.
		if (getContext().getRequest().getSession(true).getAttribute(
				PREVIOUS_SEARCH_REQUEST) != null) {
			searchReq = (DealerStaffSearchRequest) getContext().getRequest()
					.getSession(true).getAttribute(PREVIOUS_SEARCH_REQUEST);
			getContext().getRequest().getSession().removeAttribute(
					PREVIOUS_SEARCH_REQUEST);
		}
		return search();
	}

	@HandlesEvent(EVENT_ADD_DEALER_STAFF_TO_INDIVIDUAL)
	public Resolution addDealerStaffIndividual() {
		setReturnTo("addDealerStaffIndividual");
		return displaySearchPage();
	}

	/*
	 * retrive dealer id from the request object
	 */

	private Long getDealerId() {
		if (getContext().getRequest().getParameter(DEALER_ID).equals("")) {
			return null;
		} else {
			return Long.valueOf(getContext().getRequest().getParameter(
					DEALER_ID));
		}
	}

	/*
	 * retrive dealer staff id from the request object
	 */

	private Long getDealerStaffId() {
		if (getContext().getRequest().getParameter(DEALER_STAFF_ID).equals("")) {
			return null;
		} else {
			return Long.valueOf(getContext().getRequest().getParameter(
					DEALER_STAFF_ID));
		}
	}

	@HandlesEvent(EVENT_DISPLAY_SEARCH_CRITERIA_FOR_VIEW)
	public Resolution displaySearchPageForView() {
		departments = Arrays.asList(Department.values());
		return new ForwardResolution(JSP_BASE
				+ "/staff/searchForViewDealerStaff.jsp");
	}

	@HandlesEvent(EVENT_PERFORM_SEARCH)
	public Resolution search() {
        
		// assign dealer id for given login ID
		if (isMyDearler()) {
			searchReq.setDealerID(staffServices
					.getDealerIDForGivenUserID(getContext().getLoginId()));
		}

		if (isValidate(searchReq)) {
			searchReq = populatePositionDescription(searchReq);

			searchRsp = staffServices.findStaffByDealer(searchReq);
			searchRsp.setReturnTo(searchReq.getReturnTo());

			setEligibility();

			getContext().getRequest().getSession(true).setAttribute(
					PREVIOUS_SEARCH_REQUEST, searchReq);
			// FlashScope.getCurrent(getContext().getRequest(),
			// true).put(PREVIOUS_SEARCH_REQUEST, searchReq);
			return new ForwardResolution(JSP_BASE
					+ "/staff/searchDealerStaffResult.jsp");
		} else {
			return new ForwardResolution(JSP_BASE
					+ "/staff/searchDealerStaff.jsp");
		}
	}

	private boolean isMyDearler() {
		if (searchReq.isMyDealer() != null && searchReq.isMyDealer()) {
			return true;
		} else {
			return false;
		}
	}

	@HandlesEvent(EVENT_PERFORM_SEARCH_FOR_VIEW)
	public Resolution searchForView() {
		// assign dealer id for given login ID
		if (isMyDearler()) {
			searchReq.setDealerID(staffServices
					.getDealerIDForGivenUserID(getContext().getLoginId()));
		}

		if (isValidate(searchReq)) {
			boolean isRemoveDPGMRDOB = false;
			if (getContext().getUserRole().compareTo(NCRole.DealerUpdater) == 0) {
				isRemoveDPGMRDOB = true;
			}
			searchRsp = staffServices.findStaffByDealerForView(searchReq,
					isRemoveDPGMRDOB);
			setEligibility();

			return new ForwardResolution(JSP_BASE
					+ "/staff/searchDealerStaffResultForView.jsp");
		} else {
			return new ForwardResolution(JSP_BASE
					+ "/staff/searchForViewDealerStaff.jsp");
		}
	}

	private void setEligibility() {
		HashMap<Long, Long> eligibleDealerIDs = usersDealersService
				.getEligibleDealerIDsFor(getContext().getUserDetails(),
						getContext().getUserRole());

		for (StaffByDealer staffByDealer : searchRsp.getStaffByDealers()) {
			if (eligibleDealerIDs.get(staffByDealer.getDealerID()) != null) {
				staffByDealer.setEligible("true");
			}else{				
				staffByDealer.setEligible("false");
			}
		}
	}

	@HandlesEvent(EVENT_VIEW)
	public Resolution view() {
		return new ForwardResolution(JSP_BASE + "/staff/viewDealerStaff.jsp");
	}

	@HandlesEvent("displaySavedSearches")
	public Resolution displaySavedSearches() {
		return new ForwardResolution(JSP_BASE + "/staff/savedSearches.jsp");
	}

	public String getSearchEventName() {
		return this.searchEventName;
	}

	public void setSearchEventName(String searchEventName) {
		this.searchEventName = searchEventName;
	}

	public DealerStaffSearchRequest getSearchReq() {
		return searchReq;
	}

	public void setSearchReq(DealerStaffSearchRequest searchReq) {
		this.searchReq = searchReq;
	}

	public String getSavedSearchName() {
		return savedSearchName;
	}

	public void setSavedSearchName(String savedSearchName) {
		this.savedSearchName = savedSearchName;
	}

	public List<Position> getPositions() {
		List<Position> positions = new ArrayList<Position>();
		for (Position position : positionService.getAllPositions()) {
			if (position.getDateRange().isActive()) {
				positions.add(position);
			}
		}
		return positions;
	}

	public List<Department> getDepartments() {
		return departments;
	}

	public void setDepartments(List<Department> departments) {
		this.departments = departments;
	}

	public int getSavedSearchesSize() {
		return getSavedSearches().size();
	}

	public boolean isHasSavedSearches() {
		return getSavedSearches().size() > 0;
	}

	public List<SavedSearch> getSavedSearches() {
		return savedSearchRegistry.getAllFor(SavedSearchType.STAFF,
				getContext().getLoginId());
	}

	public DealerStaffSearchResponse getSearchRsp() {
		return searchRsp;
	}

	public void setSearchRsp(DealerStaffSearchResponse searchRsp) {
		this.searchRsp = searchRsp;
	}

	public Object getRequestForDecoration() {
		return searchReq;
	}

	/**
	 * @param dealerStaffSearchRequest
	 * @return
	 */
	private DealerStaffSearchRequest populatePositionDescription(
			DealerStaffSearchRequest dealerStaffSearchRequest) {
		if (dealerStaffSearchRequest.getPosition() != null) {
			dealerStaffSearchRequest.setPositionDescription(positionService
					.get(dealerStaffSearchRequest.getPosition())
					.getDescription());
		}
		return dealerStaffSearchRequest;
	}

	private boolean isValidate(DealerStaffSearchRequest searchReq) {
		final DealerStaffSearchValidator validator = DealerStaffSearchValidatorFactory
				.createValidatorFor(searchReq, getContext().getUserRole());
		if (validator.isValid()) {
			return true;
		} else {
			addLocalizableGlobalError(validator.getValidationErrorMessageKey());
			return false;
		}
	}

	private void sendAlertMessageWhenAppointmentHasLinks() {
		for (Appointment appointment : appointmentServices.findAppointmentsForDealerStaffByDealer(getDealerStaffId(), getDealerId()))
		{
		    List<Appointment> appointmentLinks = appointmentServices.getActiveAppointmentsLinkToTrainingManager(appointment.getAppointmentId());
		    if(appointmentLinks != null && appointmentLinks.size() > 0){
		        context.getRequest().setAttribute(APPOINTMENT_LINKS_FOUND, "true");
		        break;
		    } 

		}
	}
	
}