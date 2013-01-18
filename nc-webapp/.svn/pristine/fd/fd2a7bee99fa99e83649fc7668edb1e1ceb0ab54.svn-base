<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
<nc:pageName pageName="Header"/>
        <%--<div id="header_logo">
                <div><a id="headerHomeLink" href="${pageContext.request.contextPath}/Home.action" class="banner_main">
                    <img src="${pageContext.request.contextPath}/images/nc_logo.gif" alt="Network Central" />
                </a></div>
                <div class="banner_footer"><fmt:message key="label.networkCentral.footer"/></div>
        </div>--%>
        <h1 id="logo">
            <stripes:link id="logoHomeLink" beanclass="au.com.toyota.nc.webapp.stripes.HomeActionBean">
                Network Central
            </stripes:link>
        </h1>

        
        <div id="header_toolbar">
            <c:set var="user" value="${actionBean.context.userDetails}"/>
            <c:if test="${not empty user}">
                <div id="userInfo">
                    <fmt:message key="logout.title" var="logoutTitle" scope="page"/>
                    <fmt:message key="welcome.label">
                        <fmt:param value="${user.firstName} ${user.surname}"/>
                    </fmt:message>
                    <stripes:link id="logoutLink" beanclass="au.com.toyota.nc.webapp.stripes.LoginActionBean" title="${logoutTitle}">(<fmt:message key="logout.label"/>)</stripes:link>
                </div>
                <div style="display:none;"> <!-- for debugging purposes -->
                    CN: <c:out value="${user.cn}"/>
                    Role: <c:out value="${loggedInUserRole}"/>
                </div>
            </c:if>
            <div id="header_toolbar_application_name">
                Network Central
            </div>
        </div>
    <!-- clear floats -->
   	<stripes:layout-render name="/WEB-INF/jsp/layout/_helpLink.jsp"/>
    <stripes:layout-render name="/WEB-INF/jsp/layout/_globalMenu.jsp"/>
    <div class="clear"></div>

    <!-- global navigation -->
   <%-- <div id="global">
        <ul class="nav">
            <li><a href="${pageContext.request.contextPath}/Home.action">Home</a></li>
        </ul>--%>
    <%--</div><div class="clear"></div>--%><!-- end global navigation -->
</stripes:layout-definition>

