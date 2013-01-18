<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
     <stripes:layout-component name="html-head">
         <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/changeOver/nc-changeOver.css"/>
          <jsp:include page="_exitWizard.jsp"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <div class="pageContent_main_header">
             <!-- PROCESS DEALER CHANGEOVER-->
            <h1>Process Dealer Changeover</h1>
        </div>


        <!-- for selenium tests: list staff changeover page -->
         <div class="pageContent_wrapper">
             <div class="mainContent_wrapper">
                <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerchangeover.ProcessDealerChangeoverActionBean">
                    <c:import url="/WEB-INF/jsp/messages.jsp"/>

                    <div class="links">
                        <ul class="table-item-control-nav">
                            <li>
                                <jsp:include page="_navigation.jsp">
                                    <jsp:param name="backEvent" value="selectEditLocations"/>
                                    <jsp:param name="dealerChangeoverId" value="${actionBean.dealerChangeover.dealerChangeoverId}" />
                                </jsp:include>
                            </li>
                        </ul>
                    </div>
                    <table id="changeOverTable-staff" class="resultsTable" >
                        <thead>
                            <tr>
                                <th>
                                    <fmt:message key="dealerChangeover.staff.table.header.archive"/>
                                </th>
                                <th>
                                    <fmt:message key="dealerChangeover.staff.table.header.transfer"/>
                                </th>
                                <th>

                                </th>
                                <th>
                                    <fmt:message key="dealerChangeover.staff.table.header.position"/>
                                </th>
                                <th>
                                    <fmt:message key="dealerChangeover.staff.table.header.oldLocation"/>
                                </th>
                                <th>
                                    <fmt:message key="dealerChangeover.staff.table.header.newLocation"/>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="displayStaffCount" scope="request" value="0"/>
                            <c:forEach items="${actionBean.eligibleAppointmentsForChangeover}" var="oldDealerAppointment" varStatus="loopStatus">
                                <c:set var="adjustedRowCount" value="${displayStaffCount}"/>
                                <c:set var="radioButtonName" value="selectedChangeoverActions[${adjustedRowCount}]"/>
                                <c:set var="noActionSelected" value="false"/>
                                <c:if test="${actionBean.selectedChangeoverActions[adjustedRowCount] == null}">
                                    <c:set var="noActionSelected" value="true"/>
                                </c:if>
                                <stripes:hidden name="selectedDealerStaffIds[${adjustedRowCount}]" value="${oldDealerAppointment.person.personId}"/>
                                <stripes:hidden name="selectedOldLocationIds[${adjustedRowCount}]" value="${oldDealerAppointment.location.locationId}"/>
                                <tr class="${loopStatus.index %2==0 ? 'darkRow':'lightRow'}">
                                    <td>
                                        <div class="data-line"><stripes:radio value="Archive" name="${radioButtonName}"/></div>
                                    </td>
                                    <td>
                                        <div class="data-line">
                                            <c:choose>
                                                <c:when test="${noActionSelected == 'true'}">
                                                    <input type="radio" name="<c:out value="${radioButtonName}"/>" value="Transfer" checked="checked"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <stripes:radio value="Transfer" name="${radioButtonName}"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="data-line">
                                            <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffActionBean"
                                                          event="edit"
                                                          target="_blank"
                                                          class="viewStaffDetailsLink">
                                                <stripes:param name="readOnly" value="true"/>
                                                <stripes:param name="dealerStaff.personId" value="${oldDealerAppointment.person.personId}"/>
                                                <c:out value="${oldDealerAppointment.person.fullName}"/>
                                            </stripes:link>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="data-line"><c:out value="${oldDealerAppointment.position.description}"/></div>
                                    </td>
                                    <td>
                                        <div class="data-line">
                                            <stripes:layout-render name="/WEB-INF/jsp/nc/formatting/_locationNameSelection.jsp" location="${oldDealerAppointment.location}"/>                        
                                        </div>
                                    </td>
                                    <td>
                                        <div class="data-line">
                                            <stripes:select name="selectedLocationIds[${adjustedRowCount}]" class="selectLocationIdsSelectionBox">
                                                <stripes:option selected="selected" value="${actionBean.dealerChangeover.newPrincipalLocation.locationId}">
                                                    <stripes:layout-render name="/WEB-INF/jsp/nc/formatting/_locationNameSelection.jsp" location="${actionBean.dealerChangeover.newPrincipalLocation}"/>
                                                </stripes:option>
                                                <c:forEach items="${actionBean.dealerChangeover.newNonPrincipalLocations}" var="newNonPrincipalLocation">
                                                    <c:if test="${newNonPrincipalLocation.type.ableToSupportAppointments}">
                                                        <stripes:option value="${newNonPrincipalLocation.locationId}">
                                                            <stripes:layout-render name="/WEB-INF/jsp/nc/formatting/_locationNameSelection.jsp" location="${newNonPrincipalLocation}"/>
                                                        </stripes:option>
                                                    </c:if>
                                                </c:forEach>
                                            </stripes:select>
                                        </div>
                                    </td>
                                </tr>
                                <c:set var="displayStaffCount" scope="request" value="${displayStaffCount + 1}"/>
                            </c:forEach>
                        </tbody>
                    </table>


                    <stripes:hidden name="dealerChangeover.dealerChangeoverId"/>

                    <input type="hidden" name="totalCountOfDisplayedStaff" value="${displayStaffCount}"/>

                     <div class="formActionButtons">
                            <stripes:button name="list" value="Exit" onclick="exitWizard();" id="exitButton" class="btn btn_exit"/>
                            <stripes:submit name="saveStaff" value="Save and Continue" id="submitButton" class="btn btn_saveContinue"/>
                       <div class="clear"></div>
                   </div>
                </stripes:form>
                 <div class="clear"></div>
                </div>
             <div class="clear"></div>
        </div>

    </stripes:layout-component>
</stripes:layout-render>
