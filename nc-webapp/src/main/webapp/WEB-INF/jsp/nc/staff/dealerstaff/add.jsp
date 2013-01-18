<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<nc:pageName pageName="DealerStaff-Manage"/>
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
            <h1 id="addStaffPageHeader">Add Staff</h1>
        </div>

        <div id="dealerStaffDetailsPage" class="pageContent_wrapper">
            <div id="personalDetails" class="mainContent_wrapper">
                <stripes:form id="addDealerStaffForm" beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffActionBean"
                              method="post">
                    <c:import url="/WEB-INF/jsp/messages.jsp"/>

                    <ul class="column-style-fieldset twoCols">
                        <li>
                            <fieldset id="staff-personal-details">
                                <legend class="legend">Personal Details</legend>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_dealerStaffNumber.jsp" pageName="DealerStaff-Manage" readOnly="false"/>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_coreDetails.jsp" pageName="DealerStaff-Manage" readOnly="false"/>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_languages.jsp" pageName="DealerStaff-Manage" readOnly="false"/>
                            </fieldset>
                        </li>
                        <li>
                            <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_spouseDetails.jsp" pageName="DealerStaff-Manage" readOnly="false"/>
                        </li>
                    </ul>
                    <div class="clear"></div>
                    <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_misc.jsp" pageName="DealerStaff-Manage" readOnly="false"/>

                    <div id="dealerStaffAppointments">
                        <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_addLinks.jsp" pageName="DealerStaff-Manage" readOnly="false"/>
                    </div>

                    <c:set var="showWarningMessage" value="false"/>
                    <nc:ifAccessAllowed name="dealerStaff.add.warning">
                        <c:set var="showWarningMessage" value="true"/>
                    </nc:ifAccessAllowed>
                    <!-- submit -->
                    <script type="text/javascript">
                        function showConfirmationMessage()
                        {
                            <c:choose>
                                <c:when test="${showWarningMessage == 'true'}">
                                    return confirm('You are about to add a staff member\'s details to the Network Central System. The following details will be able to be viewed by authorised Network Central users should they conduct a search on this staff member\'s full name:\r\n- Name\r\n- Position Details\r\n- Contact Details\r\n\r\nPlease ensure that your staff member is aware and has consented to their information being viewed in this way via the Network Central System.\r\nClicking OK indicates that you understand the process described above and have received the staff member\'s consent to add their details to the Network Central system.');
                                </c:when>
                                <c:otherwise>
                                    return true;
                                </c:otherwise>
                            </c:choose>
                        }
                    </script>
                    <stripes:submit name="saveOrUpdate" id="saveOrUpdateButton" class="btn btn_save" onclick='return showConfirmationMessage();'/>
                    <stripes:reset name="reset" value="Reset" class="btn btn_reset"/>
                    <div class="clear"></div>
                    
                    <c:if test="${actionBean.showNationalAdminDuplicateConfirmation eq true}">
						<input id="showNationalAdminDuplicateConfirmationFlag" type="hidden" value="true" />
					</c:if>
				
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
					
                </stripes:form>
            </div>
            <div class="clear"></div>
        </div>


        <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_languageDialogBox.jsp" readOnly="false"/>
    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">
        <jsp:include page="/WEB-INF/jsp/nc/staff/dealerstaff/_js.jsp"/>
        <nc:ifWriteAccessAllowed name="dealerStaff.dob">
            <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarItem.jsp" inputField="dealerStaff.dob" button="dateOfBirthTrigger"/>
        </nc:ifWriteAccessAllowed>
        
        <script type="text/javascript">

        		function closeNationalAdminDialog() {
        			YAHOO.au.com.toyota.widget.NationalAdminDuplicateStaffConfirmationDialog.hide();
        		}
        
				function openNationalAdminDuplicateStaffConfirmationDialog() {
					YAHOO.au.com.toyota.widget.NationalAdminDuplicateStaffConfirmationDialog.show();
				}
				
		        var NationalAdminDuplicateStaffConfirmationDialog = {
		                initDialog : function(){
		                   <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp" dialogName="NationalAdminDuplicateStaffConfirmationDialog" dialogId="NationalAdminDuplicateStaffConfirmationDialog" noButtons="true" />
		                }
		            };

		        dialogs.add(NationalAdminDuplicateStaffConfirmationDialog);
        </script>
        
    </stripes:layout-component>

</stripes:layout-render>
