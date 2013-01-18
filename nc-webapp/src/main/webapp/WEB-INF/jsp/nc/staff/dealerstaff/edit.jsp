<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
         <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/staff/nc-staff.css"/>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/nc-ajax.js"></script>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp"/>
        <!-- for selenium tests: manage dealer staff page -->
        <div class="pageContent_main_header">
            <h1 id="editStaffPageHeader">Manage Staff</h1>
         </div>


        <div id="dealerStaffDetailsPage" class="pageContent_wrapper">
            <div id="personalDetails" class="mainContent_wrapper">
                <stripes:form id="addDealerStaffForm" beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffActionBean" method="post">
                    <c:choose>
                        <c:when test="${actionBean.hasDpGmrAppointments}">
                            <c:set value="DealerStaff-Manage-dpgmr" var="pageName"/>
                        </c:when>
                        <c:otherwise>
                            <c:set value="DealerStaff-Manage" var="pageName"/>
                        </c:otherwise>
                    </c:choose>
                    <nc:evalAccess>
                        <c:set var="readOnly" value="false"/>
                        <c:if test="${! actionBean.staffIsAssociatedToUsersDealer}">
                            <nc:pageViewMode readOnly="true"/>
                            <c:set var="readOnly" value="true"/>
                        </c:if>
                    </nc:evalAccess>
                    <c:if test="${actionBean.readOnly}">
                        <nc:pageViewMode readOnly="true"/>
                        <c:set var="readOnly" value="true"/>
                    </c:if>
                    <c:import url="/WEB-INF/jsp/messages.jsp"/>

                    <stripes:hidden name="dealerStaff.personId"/>
                    <stripes:hidden name="oldFirstname" value="${actionBean.oldFirstname}"/>
                    <stripes:hidden name="oldLastname" value="${actionBean.oldLastname}"/>
                    <stripes:hidden name="oldDob" value="${actionBean.oldDob}"/>
                    <nc:pageName pageName="${pageName}"/>

                    <ul class="column-style-fieldset twoCols">
                        <li>
                            <fieldset id="staff-personal-details">
                                <legend>Personal Details</legend>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_dealerStaffNumber.jsp" pageName="${pageName}" readOnly="${readOnly}"/>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_coreDetails.jsp" pageName="${pageName}" readOnly="${readOnly}"/>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_languages.jsp" pageName="${pageName}" readOnly="${readOnly}"/>
                            </fieldset>
                        </li>
                        <li>
                            <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_spouseDetails.jsp" pageName="${pageName}" readOnly="${readOnly}"/>
                        </li>
                     </ul>
                    <div class="clear"></div>

                    <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_misc.jsp" pageName="${pageName}" readOnly="${readOnly}"/>


                    <c:if test="${readOnly != true}">
                        <nc:ifAccessAllowed name="dealerStaff.submit">
                            <!-- submit -->
                            <label class="spacer"></label>
                            	<stripes:submit name="checkWarning" id="checkWarningButton" class="btn btn_save" onclick="disableButton('checkWarningButton');">Save</stripes:submit>
                            <stripes:reset name="reset" value="Reset" id="resetButton" class="btn btn_reset"/>
                        </nc:ifAccessAllowed>
                    </c:if>

                     <nc:ifAccessAllowed name="dealerStaff.edit">
                        <c:if test="${actionBean.readOnly}">
                            <ul class="table-item-control-nav">
                                <li>
                                    <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffActionBean" event="edit" id="editStaffLink">
                                        <stripes:param name="dealerStaff.personId" value="${actionBean.dealerStaff.personId}"/>
                                        Edit Details
                                    </stripes:link>
                                </li>
                            </ul>
                        </c:if>
                    </nc:ifAccessAllowed>
                    <div class="clear"></div>

                    <div id="dealerStaffAppointments">
                        <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_addLinks.jsp" pageName="${pageName}" readOnly="${readOnly}"/>
                        <c:if test="${!actionBean.footerDisplayable}">
                        	<c:if test="${(actionBean.dealerStaff != null) && (actionBean.dealerStaff.maintenanceDate != null)}"> 
		                        <div align="center">
		                       		<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.dealerStaff.maintenanceDateAsString}"  />
		                       	</div>
	                       	</c:if>
                       	</c:if>
						<stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_appointments.jsp"/>
                    </div>

				<c:if test="${actionBean.showWarning eq true}">
					<input id="showConfirmationDialogFlag" type="hidden" value="true" />
				</c:if>
				
				<c:if test="${actionBean.showNationalAdminDuplicateConfirmation eq true}">
					<input id="showNationalAdminDuplicateConfirmationFlag" type="hidden" value="true" />
				</c:if>

					<div id="DealerStaffConfirmationDialog"
						class="dialog dialogWithDefaultCloseButton">
						<div class="hd">Warning</div>
						<div class="bd">
							<c:if test="${fn:length(actionBean.nameChangeWarning) > 0 }">
								<c:out value="${actionBean.nameChangeWarning}" />
								<br>
								<br>
							</c:if>
							<c:if test="${fn:length(actionBean.dobChangeWarning) > 0 }">
								<c:out value="${actionBean.dobChangeWarning}" />
							</c:if>
							<br> <br>
							<p>Do you wish to proceed?</p>
							<stripes:submit name="saveOrUpdate" id="saveOrUpdateButton"
								class="btn btn_saveContinue"
								onclick="disableButton('saveOrUpdateButton');">Save</stripes:submit>

							<input id="myCloseButton" type="button" class="btn btn_cancel"
								onclick="closeDialog();" />
						</div>
					</div>
					
					<div id="NationalAdminDuplicateStaffConfirmationDialog" class="dialog dialogWithDefaultCloseButton">
						<div class="hd">Duplicate Person Detected</div>
						<div class="bd">
								<p>This person already exists in Network Central.</p>
								<br>
								<p>Please confirm if you wish to continue.</p>
								<br>
							<stripes:submit name="nationalAdminSaveOrUpdate" id="nationalAdminSaveOrUpdateButton" 
								class="btn btn_saveContinue" onclick="disableButton('nationalAdminSaveOrUpdateButton');">Save</stripes:submit>
								
							<input id="nationalAdminCloseButton" type="button" class="btn btn_cancel" onclick="closeNationalAdminDialog();" />
						</div>
					</div>
   					<c:if test="${not empty requestScope.APPOINTMENT_LINKS_FOUND}">                            
                    <div id="alertDiscontinueDialog" class="dialog dialogWithDefaultCloseButton">
                    	<div class="hd">Warning - Training Approval Manager</div> 
                        <div class="bd" id="alertDiscontinueDialogBody"><fmt:message key="staff.discontinue.warning.message"/></div>
                    </div>                            
					</c:if>					
					
				</stripes:form>
            </div>
            <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_languageDialogBox.jsp" readOnly="${readOnly}"/>
        </div>
        
        
    </stripes:layout-component>


    <stripes:layout-component name="init-event-handling">
        <jsp:include page="/WEB-INF/jsp/nc/staff/dealerstaff/_js.jsp"/>
        <nc:ifWriteAccessAllowed name="dealerStaff.dob">
            <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarItem.jsp" inputField="dealerStaff.dob" button="dateOfBirthTrigger"/>
        </nc:ifWriteAccessAllowed>
        
        <script type="text/javascript">
        
        <c:if test="${not empty requestScope.APPOINTMENT_LINKS_FOUND}">
		
		// Instantiate the Dialog
		var alertDiscontinueDialog = new YAHOO.widget.Dialog("alertDiscontinueDialog", 
					{ width : "40em",
					  fixedcenter : true,
					  visible : false, 
					  constraintoviewport : false
					  } );
					  
		// Define various event handlers for Dialog 
		var handleAlertDiscontinueDialogSubmit = function() { 
			// do nothing
			alertDiscontinueDialog.hide();
		};						  
					 
		var myAlertDiscontinueButtons = [ { text : "Close", handler:handleAlertDiscontinueDialogSubmit, isDefault : true }];			 
		alertDiscontinueDialog.cfg.queueProperty("buttons", myAlertDiscontinueButtons);
		alertDiscontinueDialog.render();  	
		
    	</c:if>  
    	
        YAHOO.util.Event.onDOMReady(function(){

	        <c:if test="${not empty requestScope.APPOINTMENT_LINKS_FOUND}">
			
				alertDiscontinueDialog.show();  

            </c:if>
        });            
        		function closeDialog() {
        			 YAHOO.au.com.toyota.widget.DealerStaffConfirmationDialog.hide();
        		}
        		
        		function closeNationalAdminDialog() {
        			YAHOO.au.com.toyota.widget.NationalAdminDuplicateStaffConfirmationDialog.hide();
        		}
        
				function openDealerStaffConfirmationDialog() {
					YAHOO.au.com.toyota.widget.DealerStaffConfirmationDialog.show();
			    }
				
				function openNationalAdminDuplicateStaffConfirmationDialog() {
					YAHOO.au.com.toyota.widget.NationalAdminDuplicateStaffConfirmationDialog.show();
				}
				
		        var DealerStaffConfirmationDialog = {
		                initDialog : function(){
		                   <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp" dialogName="DealerStaffConfirmationDialog" dialogId="DealerStaffConfirmationDialog" noButtons="true" />
		                }
		            };
		        
		        var NationalAdminDuplicateStaffConfirmationDialog = {
		                initDialog : function(){
		                   <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp" dialogName="NationalAdminDuplicateStaffConfirmationDialog" dialogId="NationalAdminDuplicateStaffConfirmationDialog" noButtons="true" />
		                }
		            };
		         dialogs.add(DealerStaffConfirmationDialog);
		         dialogs.add(NationalAdminDuplicateStaffConfirmationDialog);
        </script>
        
    </stripes:layout-component>

</stripes:layout-render>
