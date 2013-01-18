<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<fmt:setBundle basename="nc-reports-resources" var="reports_resources" scope="page"/>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
      <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/reporting/nc-reports.css"/>
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
                    <p>High level summary report of network information</p>
                </div>
                <div class="clear"></div>
        </div>
    </stripes:layout-component>

</stripes:layout-render>
