<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
        <stripes:layout-component name="html-head">
          <jsp:include page="_exitWizard.jsp"/>
         <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/changeOver/nc-changeOver.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: setup automation changeover page -->
          <div class="pageContent_main_header">
               <h1>Process Dealer Changeover</h1>
        </div>


        <div class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerchangeover.ProcessDealerChangeoverActionBean">
                    <c:import url="/WEB-INF/jsp/messages.jsp"/>

                    <div>
                        <ul class="table-item-control-nav">
                            <li>
                                <jsp:include page="_navigation.jsp">
                                    <jsp:param name="backEvent" value="selectEditStaff"/>
                                    <jsp:param name="dealerChangeoverId" value="${actionBean.dealerChangeover.dealerChangeoverId}" />
                                </jsp:include>
                            </li>
                        </ul>
                    </div>

                    <fieldset>
                        <stripes:label for="dealerChangeover.scheduledDate"/>
                        <nc:datetext name="dealerChangeover.scheduledDate"
                                     id="dealerChangeover.scheduledDate"
                                     buttonId="changeoverDateTrigger"
                                     class="dateField"
                                     formatType="datetime"
                                     skipPermissions="true"/>
                    </fieldset>
                    <div class="clear"></div>

                    <div id="dealerChangeoverAutomationMessage">
                        <div>
                            This is what will happen:
                        </div>
                        <div id="sourceDetail">
                            Immediately before the time selected above Dealership <strong><c:out value="${actionBean.dealerChangeover.oldDealer.generalInfo.dealerName}"/></strong> will:
                            <ol>
                                <li>
                                    Have its <em>Status</em> automatically set to inactive and all locations belonging to the dealership will be set to inactive
                                </li>
                                <li>
                                    Have its <em>Cessation date</em> set to immediately before the time selected
                                </li>
                                <li>
                                    Disable all Non admin users from being able to search for and view the dealership
                                </li>
                                <li>
                                    Disable all Non admin users from being able to search for and view archived staff
                                </li>
                            </ol>
                        </div>
                        <div id="targetDetail">
                            Dealership <strong><c:out value="${actionBean.dealerChangeover.newDealer.generalInfo.dealerName}"/></strong> at the time selected above:
                            <ol>
                                <li>
                                    <em>Status</em> will be made active
                                </li>
                                <li>
                                    <em>Appointment date</em> will be set to the same date
                                </li>
                                <li>
                                    The dealership will be returned in searches by all users
                                </li>
                                <li>
                                    Locations will be set to active
                                </li>
                                <li>
                                    Positions for transferred staff and new staff created and assigned to the dealership will have a start date
                                    of the same date
                                </li>
                                <li>
                                    Security access for transferred staff will remain the same, with a new password being supplied to users
                                    who have a recorded email address, or a manual password reset required before the users can log in,
                                    for those that have no recorded email address.
                                </li>
                            </ol>
                        </div>
                        <div>
                            For the changeover to be effective, you must enter <strong>ALL</strong> mandatory information before the changeover date.
                        </div>
                    </div>

                    <stripes:hidden name="dealerChangeover.dealerChangeoverId"/>

                     <div class="formActionButtons">
                            <stripes:button name="exit" value="Exit" onclick="exitWizard();" id="exitButton" class="btn btn_exit"/>
                            <stripes:submit name="showConfirmation" value="Save and Finish" id="showConfirmationButton" class="btn btn_saveFinish"/>
                            <div class="clear"></div>
                    </div>

                    <div class="clear"></div>
                    
                    <c:if test="${actionBean.showConfirmation eq true}">
						<input id="showConfirmationFlag" type="hidden" value="true" />
					</c:if>
					
					<div id="openConfirmationDialog" class="dialog dialogWithDefaultCloseButton">
						<div class="hd">Warning</div>
						<div class="bd">
								<p>
									You have changed one or more fields on this screen. <br/>
									Please confirm that you want to save the changes.
								</p>
							<stripes:submit name="saveAutomation" id="saveButton" class="btn btn_saveFinish" onclick="disableButton('saveButton');" />
								
							<input id="confirmationDialogCloseButton" type="button" class="btn btn_cancel" onclick="closeDialog();" />
						</div>
					</div>

                </stripes:form>
                </div>
        </div>
    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">

        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp"/>
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarItem.jsp" inputField="dealerChangeover.scheduledDate" button="changeoverDateTrigger" showsTime="true"/>
       <script type='text/javascript'>
            function yuiLoadComplete()
            {
            	YAHOO.util.Event.onDOMReady(function() {

            		var flagElem = $('#showConfirmationFlag');
        			if (flagElem && flagElem.val() == 'true'){
        				openConfirmationDialogBox();
        			}
                });
            }
            
            function closeDialog() {
    			YAHOO.au.com.toyota.widget.openConfirmationDialog.hide();
    		}
            
            function openConfirmationDialogBox() {
				YAHOO.au.com.toyota.widget.openConfirmationDialog.show();
			}
            
            var openConfirmationDialog = {
	                initDialog : function(){
	                   <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp" dialogName="openConfirmationDialog" dialogId="openConfirmationDialog" noButtons="true" />
	                }
	            };

	        dialogs.add(openConfirmationDialog);
	        
        </script>
    </stripes:layout-component>

</stripes:layout-render>
