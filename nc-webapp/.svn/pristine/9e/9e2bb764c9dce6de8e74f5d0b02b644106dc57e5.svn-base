<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<fmt:setBundle basename="nc-reports-resources" var="reports_resources" scope="page"/>
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/reporting/nc-reports.css"/>
    </stripes:layout-component>


    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: reports menu page -->
        <div class="pageContent_main_header">
            <h1><fmt:message key="globalMenu.reports.label"/></h1>
        </div>
        
        <div id="menu" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
            <ul class="menu_simple_vertical">
                <li>
                    <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.NetworkSummaryActionBean" event="menu" id="viewNetworkSummaryLink">
                        <fmt:message bundle="${reports_resources}" key="menu.networksummary.label"/>
                    </stripes:link>
                </li>
                <li>
                    <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.ReportsActionBean" event="displayDealerReportsMenu" id="viewHardCopyLink">
                        <fmt:message bundle="${reports_resources}" key="menu.dealerinfo.label"/>
                    </stripes:link>
                </li>
                <li><fmt:message bundle="${reports_resources}" key="menu.hyperion.label"/></li>
            </ul>
            <div class="clear"></div>
            </div>
        </div>
    </stripes:layout-component>

</stripes:layout-render>
