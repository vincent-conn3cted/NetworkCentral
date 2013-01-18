<%@ page import="au.com.toyota.nc.common.dealers.impl.SapDealer" %>
<%@ page import="au.com.toyota.nc.common.model.hibernate.AbstractDocument" %>
<%@ page import="au.com.toyota.nc.common.model.hibernate.DocumentType" %>
<%@ page import="au.com.toyota.nc.webapp.dataproxy.SAPCodeVerifier" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.DealerActivationDeactivationActionBean" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <nc:pageName pageName="ChangeDealerStatus"/>

        <%--
            Dont display the 'Change Dealer Status' button if user is only viewing
            Only allow change status if dealer has been saved before
        --%>
    <nc:ifWriteAccessAllowed name="dealer.generalInfo.status">
        <c:if test="${(actionBean.showAsReadOnly eq false) && (actionBean.dealer.dealerId ne null) && (!actionBean.dealer.generalInfo.status.inActive)}">
                <div id="changeStatusSection" style="margin:1em;">
                    <input id="changeDealerStatusButton" type="button" class="btn btn_changeStatus" value="Change Status" onclick="openChangeStatusDialog();"/>
                </div>
        </c:if>
        <div id="changeStatusDialog" class="dialog dialogWithDefaultCloseButton">
            <div class="hd">Change Status</div>
            <div class="bd" id="changeStatusDialogBody">
                        <stripes:hidden name="dealerId" value="${actionBean.dealer.dealerId}"/>
                        <stripes:hidden name="lastTabShown" value="${actionBean.lastTabShown}"/>
                        <%--
                            This span will be populated with the appropriate events (doActivation now / doDeactivation now/etc). This is because
                             YUI's dialog box by default does asynchronous form submit, and since we call this submit programmatically (indirectly, via YUI's mechanism),
                             it doesnt include the submit button name (as in the usual circumstance). The hack is to put this event as
                             hidden input, when user click the button.
                         --%>
                        <span id="eventSpan"></span>
                        
                        <c:if test="${actionBean.dealer.generalInfo.status.draft}">
                            <div id="dealerActivationDiv">
                                <!-- for selenium tests: activate dealer popup-->
                                <fieldset>
                                        <nc:label name="label.appointmentDate" for="appointmentDate"/>
                                        <nc:datetext name="appointmentDate" id="appointmentDate" class="dateField" buttonId="appointmentDateTrigger" showTime="true"/>
                                </fieldset>
                                <stripes:submit id="scheduleActivationButton" class="btn btn_schedule"  name="<%=DealerActivationDeactivationActionBean.EVENT_SCHEDULE_ACTIVATION%>" value="Schedule"/>
                                <stripes:submit id="activateNowButton" class="btn btn_doNow"
                                                name="<%=DealerActivationDeactivationActionBean.EVENT_ACTIVATE%>"
                                                value="Do Now" onclick="disableButton('activateNowButton');"/>
                            </div>
                        </c:if>
                        <c:if test="${actionBean.dealer.generalInfo.status.active}">
                            <div id="dealerDeactivationDiv">
                                        <!-- for selenium tests: deactivate dealer popup-->
                                        <fieldset>
                                            <nc:label name="label.cessationDate" for="cessationDate"/>
                                            <nc:datetext  name="cessationDate" id="cessationDate" class="dateField" buttonId="cessationDateTrigger" showTime="true"/><br/>

                                            <nc:label name="label.cessationReason" for="cessationReason"/>
                                            <nc:textarea id="cessationReason" name="cessationReason" rows="5" cols="50"/><br/>

                                            <nc:label name="label.franchiseCodeEvent" for="franchiseCodeEventId"/>
                                                <nc:select-active-values selectedObject="${actionBean.dealer.generalInfo.franchiseCodeEvent}"
                                                                 valueAttribute="commonValueId"
                                                                 labelAttribute="value"
                                                                 collections="${actionBean.allFranchiseCodeEvent}"
                                                                 name="franchiseCodeEventId"
                                                                 id="franchiseCodeEventId">
                                                <option value=""><fmt:message key="label.selectone"/></option>
                                            </nc:select-active-values>
                                       </fieldset>
                                       <div class="changeStatusAffectedEntitiesListings">
                                           <p> You are about to save this dealership and set it as <strong>Inactive</strong></p>
                                          <hr/>
                                          <p> The following locations will also be made <strong>Inactive</strong></p>
                                          <ol id="deActivatableDealersLocations" class="menu_simple_vertical">
                                              <c:forEach items="${actionBean.dealer.locations}" var="location">
                                                  <c:if test="${location.status.active}">
                                                      <li><c:out value="${location.locationName}"/></li>
                                                  </c:if>
                                              </c:forEach>
                                          </ol>
                                          <br/>
                                          <hr/>
                                          <p>The following staff members will be <strong>archived</strong></p>
                                          <ol id="deActivatableDealersAppointments" class="menu_simple_vertical">
                                              <c:forEach items="${actionBean.deActivatableDealersStaffNames}" var="deActivatableDealerStaffName">
                                                  <li><c:out value="${deActivatableDealerStaffName}"/></li>
                                              </c:forEach>
                                          </ol>
                                          <br/>                                           
                                       </div>
                                        <hr/>
                                        <br/><br/>
                                        <p> Are you sure that you want to proceed?</p>
                                        <stripes:submit id="scheduleDeActivationButton" class="btn btn_schedule" name="<%=DealerActivationDeactivationActionBean.EVENT_SCHEDULE_DEACTIVATION%>" value="Schedule"/>
                                        <stripes:submit id="deActivateNowButton" class="btn btn_doNow"
                                                        onclick="disableButton('deActivateNowButton');"
                                                        name="<%=DealerActivationDeactivationActionBean.EVENT_DEACTIVATE%>" value="Do Now"/>
                                 </div>
                        </c:if>
            </div>
        </div>

        <script type="text/javascript">
            function openChangeStatusDialog()
            {
                YAHOO.au.com.toyota.widget.ChangeStatusDialog.show();
            }

            var changeStatusDialog = {
                   initDialog : function(){
                      <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp" okButtonText="Close"
                               dialogName="ChangeStatusDialog" dialogId="changeStatusDialog" postmethod="form"/>

                       <c:choose>
                            <c:when test="${actionBean.dealer.generalInfo.status.draft}">
                                   $("#doNowButton").click(function(){
                                      $("#eventSpan").html("<input type='hidden' name='<%=DealerActivationDeactivationActionBean.EVENT_ACTIVATE%>'/>");
                                   });
                                   $("#scheduleActivationButton").click(function(){
                                      $("#eventSpan").html("<input type='hidden' name='<%=DealerActivationDeactivationActionBean.EVENT_SCHEDULE_ACTIVATION%>'/>");
                                   });
                            </c:when>
                           <c:otherwise>
                                   $("#doNowButton").click(function(){
                                      $("#eventSpan").html("<input type='hidden' name='<%=DealerActivationDeactivationActionBean.EVENT_DEACTIVATE%>'/>");
                                   });
                                   $("#scheduleDeActivationButton").click(function(){
                                      $("#eventSpan").html("<input type='hidden' name='<%=DealerActivationDeactivationActionBean.EVENT_SCHEDULE_DEACTIVATION%>'/>");
                                   });
                           </c:otherwise>
                       </c:choose>
                   }
               };
            dialogs.add(changeStatusDialog);
        </script>
    </nc:ifWriteAccessAllowed>

</stripes:layout-definition>
