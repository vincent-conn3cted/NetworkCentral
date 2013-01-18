<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
        <stripes:layout-component name="html-head">
         <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/changeOver/nc-changeOver.css"/>
        <jsp:include page="_exitWizard.jsp"/>
    </stripes:layout-component>


    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: list locations changeover page -->
        <div class="pageContent_main_header">
               <!-- PROCESS DEALER CHANGEOVER-->
           <h1>Process Dealer Changeover</h1>
       </div>


        <div class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerchangeover.ProcessDealerChangeoverActionBean">
                    <stripes:hidden name="dealerChangeover.dealerChangeoverId"/>

                   <div>
                        <ul class="table-item-control-nav">
                            <li>
                                <jsp:include page="_navigation.jsp">
                                    <jsp:param name="backEvent" value="selectEditDealers"/>
                                    <jsp:param name="dealerChangeoverId" value="${actionBean.dealerChangeover.dealerChangeoverId}" />
                                </jsp:include>
                             </li>
                        </ul>
                    </div>

                    <table id="changeOverTable-locations" class="resultsTable">
                        <thead>
                            <th><fmt:message key="location.locationType"/></th>
                            <th><fmt:message key="location.locationName"/></th>
                            <th>Copy</th>
                        </thead>
                        <tbody>
                            <tr class="darkRow">
                                <td width="30%">
                                    <div class="data-line">Principal Location</div>
                                </td>
                                <td>
                                     <div class="data-line">${actionBean.dealerChangeover.oldDealer.principalLocation.locationName}</div>
                                </td>
                                <td width="30%">
                                    <div class="data-line"><input type="checkbox" disabled="disabled" checked="checked"/></div>
                                    <input type="hidden" name="selectedLocationIds" value="${actionBean.dealerChangeover.oldDealer.principalLocation.locationId}"/>
                                </td>
                            </tr>
                            <c:forEach items="${actionBean.dealerChangeover.oldDealer.activeNonPrincipalLocations}" var="location" varStatus="loopStatus">
                                <tr class="${loopStatus.index %2==0 ? 'darkRow':'lightRow'}">
                                    <td>
                                        <div class="data-line">${location.type}</div>
                                    </td>
                                    <td>
                                        <div class="data-line">
                                            <stripes:layout-render name="/WEB-INF/jsp/nc/formatting/_locationNameSelection.jsp" location="${location}"/>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="data-line"><stripes:checkbox name="selectedLocationIds" value="${location.locationId}" /></div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                     <div class="formActionButtons">
                        <stripes:button name="list" value="Exit" onclick="exitWizard();" id="exitButton" class="btn btn_exit"/>
                        <stripes:submit name="saveLocations" value="Save and Continue" id="saveLocationsButton" class="btn btn_saveContinue"/>
                        <div class="clear"></div>
                    </div>
                </stripes:form>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </div>
    </stripes:layout-component>

</stripes:layout-render>
