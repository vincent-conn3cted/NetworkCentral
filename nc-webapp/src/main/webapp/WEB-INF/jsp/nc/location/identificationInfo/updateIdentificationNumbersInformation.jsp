<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/dealerLocation/nc-dealership.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <!-- Start Identification Numbers Information Tab -->
        <!-- for selenium tests: location identification number page -->
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp"/>

        <div id="dealerLocationDetailsPage" class="pageContent_wrapper">
            <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean">
                 <%-- ==========================================
                    Secure page stuffs
                 =============================================--%>
                 <c:set var="pageName" value="EditLocation-${actionBean.location.type}-Identification" scope="page"/>
                 <nc:pageName pageName="${pageName}"/>
                 <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

                <stripes:layout-render name="/WEB-INF/jsp/nc/location/_locationCommonForm.jsp" pageName="${pageName}" showLocationTabs="true"/>

                <div id="locationDetails-identificationSection" class="mainContent_wrapper">
                    <stripes:layout-render name="/WEB-INF/jsp/nc/location/identificationInfo/components/_identificationInfo.jsp" pageName="${pageName}"/>
                    <div class="clear"></div>
                    <c:if test="${!actionBean.footerDisplayable}">
	                    <c:if test="${(actionBean.location != null) && (actionBean.location.maintenanceDate != null) }">  
				            <div align="center">
					        	<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.location.maintenanceDateAsString}"  />
					        </div>
					    </c:if>
					</c:if>
                </div>
                <div class="clear"></div>
            </stripes:form>
            <div class="clear"></div>
        </div>
        <!-- End Identification Numbers Information Tab -->
    </stripes:layout-component>


    <stripes:layout-component name="init-event-handling">
            <script type="text/javascript">
                function yuiLoadComplete(){
                    YAHOO.util.Event.onDOMReady(function(){
                          <nc:ifWriteAccessAllowed name="location.sapCode">
                                SAPLocationVerificator.initAll(); // verificator declared inside _identificationInfo.jsp
                        </nc:ifWriteAccessAllowed>
                    });
                }
            </script>


    </stripes:layout-component>

</stripes:layout-render>