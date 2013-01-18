<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<nc:pageName pageName="Appointments-Manage"/>
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/nc-ajax.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){

				if($("input:checkbox[name=appointment.authorisedTrainingApproverFlag]").length > 0){
					
					// make checkbox checked and disabled
					$("input:checkbox[name=appointment.authorisedTrainingApproverFlag]").attr('checked', true);
					$("input:checkbox[name=appointment.authorisedTrainingApproverFlag]").attr('disabled', true);

					// add hidden field to make the checked box default selected be submitted
				    $('form').append(
						$('<input/>')
							.attr('type', 'hidden')
							.attr('name', 'appointment.authorisedTrainingApproverFlag')
							.val('true')
					);
			    
				}	
				
			});
				
		</script>
    </stripes:layout-component>
    <stripes:layout-component name="page-contents">
        <c:set var="isDpGmrFlag" value="true" scope="request"/>
        <!-- for selenium tests: add dp/gmr position for staff page -->
        <div class="pageContent_main_header">
            <h1>Add DP/GMR Position</h1>
         </div>

        <div id="addDpGmrPage" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffPositionActionBean">
                    <stripes:hidden name="sourceActionType" value="<%= au.com.toyota.nc.webapp.stripes.staff.AppointmentSourceActionType.MAINTAIN_STAFF %>"/>
                    <c:import url="/WEB-INF/jsp/messages.jsp"/>

                    <stripes:hidden name="appointment.person.personId"/>
                       <ul class="column-style-fieldset oneCol">
                            <li>
                                <fieldset id="primaryAttributesSection">
                                    <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_dealerships.jsp"/>
                                    <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_locations.jsp" showLocationsEvent="showPrincipalLocationForDealer"/>
                                    <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_positions.jsp" eligiblePositions="${actionBean.allDpGmrPositions}" pageName="${pageName}" readOnly="${readOnly}"/>
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
                    <stripes:submit id="saveButton" class="btn btn_save" name="create" value="Save" onclick="disableButton('saveButton');"/>
                    <stripes:reset name="reset" class="btn btn_reset" value="Reset"/>
                </stripes:form>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </div>
    </stripes:layout-component>
</stripes:layout-render>