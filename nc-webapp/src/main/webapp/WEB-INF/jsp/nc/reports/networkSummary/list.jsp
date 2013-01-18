<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<fmt:setBundle basename="nc-reports-resources" var="reports_resources" scope="page"/>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/reporting/nc-reports.css"/>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/nc-reports.js"></script>
    </stripes:layout-component>
    
    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: network summary reports page -->
        <div class="container_col_left">
            <jsp:include page="/WEB-INF/jsp/nc/reports/networkSummary/_subMenu.jsp"/>
        </div>

        <div class="container_col_right">
            <div class="pageContent_wrapper">
                    <div id="networkSummaryTitle" class="pageContent_main_header">
                        <h1><fmt:message bundle="${reports_resources}" key="menu.networksummary.submenu.title"/></h1>
                    </div>
                    <div id="networkSummaryContent" class="mainContent_wrapper">
                        <table id="networkSummaryTable" class="resultsTable">
                            <thead>
                                <th>
                                    <fmt:message bundle="${reports_resources}" key="table.networksummary.results.heading.label"/>
                                </th>
                                <th class="networkData" >
                                    <fmt:message bundle="${reports_resources}" key="table.networksummary.results.heading.principalAndBranches"/>
                                </th>
                                <th class="networkData">
                                    <fmt:message bundle="${reports_resources}" key="table.networksummary.results.heading.dealerships"/>
                                </th>
                                <th class="networkData">
                                    <fmt:message bundle="${reports_resources}" key="table.networksummary.results.heading.branches"/>
                                </th>
                                <th class="networkData">
                                    <fmt:message bundle="${reports_resources}" key="table.networksummary.results.heading.satelliteServices"/>
                                </th>
                                <th class="networkData">
                                    <fmt:message bundle="${reports_resources}" key="table.networksummary.results.heading.otherLocations"/>
                                </th>
                                <th class="networkData">
                                    <fmt:message bundle="${reports_resources}" key="table.networksummary.results.heading.metro"/>
                                </th>
                                <th class="networkData">
                                    <fmt:message bundle="${reports_resources}" key="table.networksummary.results.heading.rural"/>
                                </th>
                            </thead>
                            <tbody>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/reports/networkSummary/_listRow.jsp"
                                                       level="1"
                                                       rowParent=""
                                                       rowNamePrefix="listNetworkSummary"
                                                       networkSummaryTableEntities="${actionBean.networkSummaryTableEntities}"/>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/reports/networkSummary/_listRow.jsp"
                                                       level="1"
                                                       rowParent=""
                                                       rowNamePrefix="listNetworkSummary"
                                                       networkSummaryTableEntities="${actionBean.totalSummary}"/>
                            </tbody>
                        </table>
                    </div>
            </div>
            <div class="clear"></div>
        </div>
    </stripes:layout-component>

</stripes:layout-render>
