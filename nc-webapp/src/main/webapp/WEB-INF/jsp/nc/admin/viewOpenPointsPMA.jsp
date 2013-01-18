<%@ page import="au.com.toyota.nc.webapp.stripes.admin.ManagePMAActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<fmt:setBundle basename="nc-admin-resources" var="admin_resources" scope="page"/>
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/admin/nc-admin.css" />
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <div class="pageContent_main_header">
            <h1><fmt:message bundle="${admin_resources}" key="manage.openpoints.header"/></h1>
        </div>

        <div id="openPointsPage" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                <fmt:message bundle="${admin_resources}" key="manage.openpoints.description"/>
                <c:import url="/WEB-INF/jsp/messages.jsp"/>

                <div id="viewOpenPointsSection">
                    <c:if test="${fn:length(openPointsPMA) > 0}">
                            <table id="openPointsPMATable" class="resultsTable">
                                <thead>
                                    <tr>
                                        <th>PMA</th>
                                        <th>Name</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${openPointsPMA}" var="openPoint" varStatus="loopStatus">
                                    <tr class="${loopStatus.index %2==0 ? 'darkRow':'lightRow'}">
                                        <td>
                                            <div class="data-line">${openPoint.code}</div>
                                        </td>
                                        <td>
                                            <div class="data-line">${openPoint.name}</div>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                    </c:if>
                    <c:if test="${fn:length(openPointsPMA) == 0}">
                        <fmt:message bundle="${admin_resources}" key="no.openpoints"/>
                    </c:if>
                </div>
        </div>
    </div>
    </stripes:layout-component>

</stripes:layout-render>