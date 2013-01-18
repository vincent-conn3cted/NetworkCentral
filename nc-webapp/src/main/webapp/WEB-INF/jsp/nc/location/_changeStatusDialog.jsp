<%@ page import="au.com.toyota.nc.common.model.hibernate.DocumentType" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.BaseManageDealerLocationActionBean" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.LocationActivationDeactivationActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <nc:pageName pageName="ChangeLocationStatus"/>
    <%--
        Dont display the 'Change Location Status' button if user is only viewing, and only if the location has been saved
    --%>
    <nc:ifWriteAccessAllowed name="location.status">
        <c:if test="${(actionBean.showAsReadOnly eq false) && (actionBean.location.locationId ne null) && (!actionBean.location.status.inActive)}">
                <div id="changeStatusSection" style="margin:1em;">
                    <input id="changeLocationStatusButton" class="btn btn_changeStatus" type="button" value="Change Status" onclick="openChangeStatusDialog();"/>
                </div>
        </c:if>
        <div id="changeStatusDialog" class="dialog dialogWithDefaultCloseButton">
            <div class="bd" id="changeStatusDialogBody">
                        <stripes:hidden name="locationId" value="${actionBean.location.locationId}"/>
                        <stripes:hidden name="lastTabShown" value="${actionBean.lastTabShown}"/>
                        <%--
                            This span will be populated with the appropriate events (doActivation now / doDeactivation now/etc). This is because
                             YUI's dialog box by default does asynchronous form submit, and since we call this submit programmatically (indirectly, via YUI's mechanism),
                             it doesnt include the submit button name (as in the usual circumstance). The hack is to put this event as
                             hidden input, when user click the button.
                         --%>
                        <span id="eventSpan"></span>

                        <c:choose>
                            <c:when test="${actionBean.location.status.draft}">
                                <div id="locationActivationDiv">
                                    <!-- for selenium tests: activate location popup-->
                                    <fieldset>
                                        <nc:label name="label.appointmentDate" for="appointmentDate"/>
                                        <nc:datetext name="appointmentDate" id="appointmentDate" class="dateField" buttonId="appointmentDateTrigger" showTime="true"/>
                                    </fieldset>
                                    <stripes:submit id="scheduleActivationButton" class="btn btn_schedule" name="<%=LocationActivationDeactivationActionBean.EVENT_SCHEDULE_ACTIVATION%>" value="Schedule"/>
                                    <stripes:submit id="activateNowButton" class="btn btn_doNow" 
                                                    onclick="disableButton('activateNowButton');"
                                                    name="<%=LocationActivationDeactivationActionBean.EVENT_ACTIVATE%>" value="Do Now"/>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div id="locationDeactivationDiv">
                                        <!-- for selenium tests: deactivate location popup-->
                                        <fieldset>
                                            <nc:label name="label.cessationDate" for="cessationDate"/>
                                            <nc:datetext name="cessationDate" id="cessationDate" class="dateField" buttonId="cessationDateTrigger" showTime="true"/><br/>

                                            <nc:label name="label.cessationReason" for="cessationReason"/>
                                            <nc:textarea name="cessationReason" id="cessationReason"/><br/>

                                            <nc:label name="label.franchiseCodeEvent" for="franchiseCodeEventId"/>
                                            <nc:select-active-values selectedObject="${actionBean.location.franchiseCodeEvent}"
                                                                     valueAttribute="commonValueId"
                                                                     labelAttribute="value"
                                                                     collections="${actionBean.allFranchiseCodeEvent}"
                                                                     id="franchiseCodeEventId"
                                                                     name="franchiseCodeEventId">
                                                <option value=""><fmt:message key="label.selectone"/></option>
                                            </nc:select-active-values><br/>

                                            <c:if test="${actionBean.location.deactivationRequiresReplacementPrincipalLocation}">
                                                <stripes:label name="label.replacementPrincipalLocation" for="locationForPromotionId"/>
                                                <stripes:select name="locationForPromotionId" id="locationForPromotionId">
                                                    <option value=""><fmt:message key="label.selectone"/></option>
                                                    <stripes:options-collection collection="${actionBean.location.dealer.activeNonPrincipalLocations}" value="locationId" label="locationName"/>
                                                </stripes:select><br/>
                                            </c:if>
                                        </fieldset>
                                        <div class="changeStatusAffectedEntitiesListings">
                                            <p> You are about to save this location and set it as <strong>Inactive</strong></p>
                                            <p>The following staff members will be <strong>archived</strong></p>
                                            <ol id="deActivatableLocationsAppointments" class="menu_simple_vertical">
                                                <c:forEach items="${actionBean.location.appointments}" var="appointment">
                                                    <c:if test="${appointment.active}">
                                                        <li><c:out value="${appointment.person.fullName}"/></li>
                                                    </c:if>
                                                </c:forEach>
                                            </ol>
                                        </div>
                                        <hr/>
                                        <br/><br/>
                                        <p> Are you sure that you want to proceed? </p>
                                        <stripes:submit id="scheduleDeActivationButton" class="btn btn_schedule" name="<%=LocationActivationDeactivationActionBean.EVENT_SCHEDULE_DEACTIVATION%>" value="Schedule"/>
                                        <stripes:submit id="deActivateNowButton" class="btn btn_doNow" 
                                                        onclick="disableButton('deActivateNowButton');"
                                                        name="<%=LocationActivationDeactivationActionBean.EVENT_DEACTIVATE%>" value="Do Now"/>
                                </div>
                            </c:otherwise>
                        </c:choose>
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
                            <c:when test="${actionBean.location.status.draft}">
                                    $("#doNowButton").click(function(){
                                        $("#eventSpan").html("<input type='hidden' name='<%=LocationActivationDeactivationActionBean.EVENT_ACTIVATE%>'/>");

                                    });
                                    $("#scheduleActivationButton").click(function(){
                                        $("#eventSpan").html("<input type='hidden' name='<%=LocationActivationDeactivationActionBean.EVENT_SCHEDULE_ACTIVATION%>'/>");

                                    });
                            </c:when>
                            <c:otherwise>
                                   $("#doNowButton").click(function(){
                                       $("#eventSpan").html("<input type='hidden' name='<%=LocationActivationDeactivationActionBean.EVENT_DEACTIVATE%>'/>");

                                   });
                                   $("#scheduleDeActivationButton").click(function(){
                                       $("#eventSpan").html("<input type='hidden' name='<%=LocationActivationDeactivationActionBean.EVENT_SCHEDULE_DEACTIVATION%>'/>");

                                   });
                            </c:otherwise>
                   </c:choose>
               }
           };
        dialogs.add(changeStatusDialog);
    </script>
    </nc:ifWriteAccessAllowed>

</stripes:layout-definition>