<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<nc:pageName pageName="Appointments-Manage"/>
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/nc-ajax.js"></script>
        <script type="text/javascript">
			$(document).ready(function(){
				if($('select[name=appointment.trainingManager.appointmentId]').length > 0){
													    
				    // set selected value
				    if($('select[name=appointment.trainingManager.appointmentId] option').length == 2 
				    		&& 
				    		$('select[name=appointment.trainingManager.appointmentId]').val() == "-1"
				    		){
				    	$('select[name=appointment.trainingManager.appointmentId] option:eq(1)').attr("selected", "selected");
				    }									    
				}
				
			});
		</script> 
        
    </stripes:layout-component>
    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: add position for staff page -->
         <div class="pageContent_main_header">
            <h1>Add Appointment</h1>
         </div>
        <div id="addAppointmentPage" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                    <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffPositionActionBean">
                        <stripes:hidden name="sourceActionType" value="<%= au.com.toyota.nc.webapp.stripes.staff.AppointmentSourceActionType.MAINTAIN_STAFF %>"/>
                        <c:import url="/WEB-INF/jsp/messages.jsp"/>

                        <stripes:hidden name="appointment.person.personId"/>
                        <ul class="column-style-fieldset oneCol">
                            <li>
                                <fieldset id="primaryAttributesSection">
                                    <legend>Dealer/Location Details</legend>
                                    <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_dealerships.jsp"/>
                                    <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_locations.jsp" showLocationsEvent="showLocationsForDealer"/>
                                    <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_positions.jsp" eligiblePositions="${actionBean.allEligiblePositions}" pageName="${pageName}" readOnly="${readOnly}"/>
                                </fieldset>
                            </li>
                        </ul>
                        <div class="clear"></div>
                        <ul class="column-style-fieldset twoCols">
                            <li>
                                    <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_manageEditableCoreDetails.jsp" pageName="Appointments-Manage" readOnly="false"/>
                             </li>
                             <li>
                                 <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_manageContactDetails.jsp" pageName="Appointments-Manage" readOnly="false"/>
                             </li>
                        </ul>
                         <div class="clear"></div>
                         <ul class="column-style-fieldset oneCol">
                            <li>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_manageSystemInformation.jsp" pageName="Appointments-Manage" readOnly="false"/>
                            </li>
                         </ul>
                        <div class="clear"></div>
                        <ul class="column-style-fieldset oneCol">
                            <li>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_manageOtherDetails.jsp" pageName="Appointments-Manage" readOnly="false"/>
                            </li>
                        </ul>
                        <div class="clear"></div>
                        <stripes:submit id="saveButton" name="create"  class="btn btn_save" value="Save" onclick="disableButton('saveButton');"/>
                        <stripes:reset name="reset" class="btn btn_reset" value="Reset"/>
                    </stripes:form>
                    <div class="clear"></div>
                </div>
                <div class="clear"></div>
        </div>
    </stripes:layout-component>
</stripes:layout-render>