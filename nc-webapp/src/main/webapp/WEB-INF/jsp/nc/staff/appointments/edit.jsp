<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/nc-ajax.js"></script>
        <c:if test="${not empty requestScope.INVALID_TRAINING_APPROVAL_MANAGER}">
     			<script type="text/javascript">
      			$(document).ready(function(){
      				if($('select[name=appointment.trainingManager.appointmentId]').length > 0){
      					$('select[name=appointment.trainingManager.appointmentId]').css('background-color', '#ff8080');
      				}	
      				
      				$('select[name=appointment.trainingManager.appointmentId]').live('click', function(e) {
          				if($('select[name=appointment.trainingManager.appointmentId]').val() == '${requestScope.INVALID_TRAINING_APPROVAL_MANAGER}'){
          					$('select[name=appointment.trainingManager.appointmentId]').css('background-color', '#ff8080');
          				}else{
          					$('select[name=appointment.trainingManager.appointmentId]').css('background-color', '#ffffff');
          				}	
      				});
      			});	
     			</script>
		</c:if>
                    <c:choose>
                        <c:when test="${actionBean.appointment.position.dpGmrFlag}">
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
                        </c:when>
                    </c:choose>        
    </stripes:layout-component>
    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: edit position for staff page -->
        <div class="pageContent_main_header">
            <h1>Edit Appointment</h1>
         </div>


        <div id="editAppointmentPage" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffPositionActionBean">
                	<c:set var="editModeFlag" value="true" scope="request"/>
                    <c:choose>
                        <c:when test="${actionBean.appointment.position.dpGmrFlag}">
                            <c:set var="pageName" value="Appointments-Manage-dpgmr"/>
                            <c:set var="isDpGmrFlag" value="true" scope="request"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="pageName" value="Appointments-Manage"/>
                        </c:otherwise>
                    </c:choose>
                    <nc:pageName pageName="${pageName}"/>
                    <c:set var="readOnly" value="false"/>
                    <nc:evalAccess>
                        <c:if test="${!actionBean.appointmentIsAssociatedToUsersDealer}">
                            <c:set var="readOnly" value="true"/>
                        </c:if>
                    </nc:evalAccess>
                    <nc:pageViewMode readOnly="${readOnly}"/>
                    <c:import url="/WEB-INF/jsp/messages.jsp"/>
                    <stripes:hidden name="sourceActionType" value="${actionBean.sourceActionType}"/>
                    <stripes:hidden name="oldSapUsername" value="${actionBean.oldSapUsername}"/>
                    <stripes:hidden name="appointment.appointmentId"/>
                    <stripes:hidden name="appointment.person.personId"/>
                    <stripes:hidden name="appointment.contact.contactId"/>
                    <stripes:hidden name="appointment.dealer.dealerId"/>
                    <stripes:hidden name="appointment.location.locationId"/>
                    <ul class="column-style-fieldset oneCol">
                        <li>
                            <fieldset>
                                <stripes:label for="appointment.dealer.dealerId"/>
                                <span class="formValue"><c:out value="${actionBean.appointment.dealer.generalInfo.dealerName}"/></span><br/>

                                <stripes:label for="appointment.location.locationId"/>
                                <span class="formValue">
                                    <stripes:layout-render name="/WEB-INF/jsp/nc/formatting/_locationNameSelection.jsp" location="${actionBean.appointment.location}"/>                        
                                </span><br/>

                      <c:choose>
                        <c:when test="${actionBean.appointment.position.dpGmrFlag}">
                            <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_positions.jsp" eligiblePositions="${actionBean.allDpGmrPositions}" pageName="${pageName}" readOnly="${readOnly}"/>
                        </c:when>
                          <c:otherwise>
                            <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_positions.jsp" eligiblePositions="${actionBean.allEligiblePositions}" pageName="${pageName}" readOnly="${readOnly}"/>
                        </c:otherwise>
                      </c:choose>


                            </fieldset>
                        </li>
                    </ul>
                    <div class="clear"></div>
                   <ul class="column-style-fieldset twoCols">
                        <li>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_manageEditableCoreDetails.jsp" pageName="${pageName}" readOnly="${readOnly}"/>
                         </li>
                         <li>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_manageContactDetails.jsp" pageName="${pageName}" readOnly="${readOnly}"/>
                          </li>
                    </ul>
                     <div class="clear"></div>
                    <ul class="column-style-fieldset oneCol">
                            <li>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_manageSystemInformation.jsp" pageName="${pageName}" readOnly="${readOnly}"/>
                             </li>
                     </ul>
                    <div class="clear"></div>
                    <ul class="column-style-fieldset oneCol">
                            <li>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_manageOtherDetails.jsp" pageName="${pageName}" readOnly="${readOnly}"/>
                            </li>
                    </ul>
                    <div class="clear"></div>
                    <stripes:submit id="saveButton" name="update" class="btn btn_save" value="Save" onclick="disableButton('saveButton');"/>
                    <stripes:reset class="btn btn_reset" name="reset"/>
                </stripes:form>
                <div class="clear"></div>
                </div>
                <div class="clear"></div>
        </div>
    </stripes:layout-component>
</stripes:layout-render>