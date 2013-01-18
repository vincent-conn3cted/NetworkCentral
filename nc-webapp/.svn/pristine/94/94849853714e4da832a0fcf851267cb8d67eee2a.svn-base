<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/dealerLocation/nc-dealership.css"/>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/nc-ajax.js"></script>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: location update general info page -->
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp"/>


        <div id="dealerLocationDetailsPage" class="pageContent_wrapper">
            <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean">
                <%-- ==========================================
                    Secure page stuffs
                =============================================--%>
                <c:set var="pageName" value="EditLocation-${actionBean.location.type}-General" scope="page"/>

                <nc:pageName pageName="${pageName}"/>
                <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

                 <stripes:layout-render name="/WEB-INF/jsp/nc/location/_locationCommonForm.jsp" pageName="${pageName}" showLocationTabs="true"/>

                <div id="locationDetails-generalSection" class="mainContent_wrapper">
                   <stripes:layout-render name="/WEB-INF/jsp/nc/location/generalInfo/components/_generalInfo.jsp" pageName="${pageName}"/>
                    <div class="clear"></div>

                   <stripes:layout-render name="/WEB-INF/jsp/nc/location/generalInfo/components/_addressInfo.jsp" pageName="${pageName}"/>
                    <div class="clear"></div>

                   <stripes:layout-render name="/WEB-INF/jsp/nc/location/generalInfo/components/_communicationInfo.jsp" pageName="${pageName}"/>
                   <stripes:layout-render name="/WEB-INF/jsp/nc/location/generalInfo/components/_corporateInfo.jsp" pageName="${pageName}"/>
                    <div class="clear"></div>

                   <stripes:layout-render name="/WEB-INF/jsp/nc/location/generalInfo/components/_franchiseInfo.jsp" pageName="${pageName}"/>
                    <div class="clear"></div>

                   <stripes:layout-render name="/WEB-INF/jsp/nc/location/generalInfo/components/_datesInfo.jsp" pageName="${pageName}"/>
                    <div class="clear"></div>
                   <stripes:layout-render name="/WEB-INF/jsp/nc/location/generalInfo/components/_notesInfo.jsp" pageName="${pageName}"/>
                    <div class="clear"></div>
                    <c:if test="${!actionBean.footerDisplayable}">
	                    <c:if test="${(actionBean.location != null) && (actionBean.location.maintenanceDate != null) }">  
				            <div align="center">
					        	<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.location.maintenanceDateAsString}"  />
					        </div>
					    </c:if>
					</c:if>
                </div>
            </stripes:form>
        </div>
        <div class="clear"></div>

        <div id="changeLocationTypeDialog" class="dialog dialogWithDefaultCloseButton">
            <div class="hd"><fmt:message key="location.type.change.header"/></div>
            <div class="bd" id="changeLocationTypeDialogBody">&nbsp;</div>
        </div>
    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">
        <jsp:include page="/WEB-INF/jsp/nc/location/_js.jsp"/>
        <script type="text/javascript">

                function yuiLoadComplete(){
                    YAHOO.util.Event.onDOMReady(function(){
                        changeLocationTypeDialog.initDialog();
                    });
                }
        </script>
    </stripes:layout-component>
</stripes:layout-render>
