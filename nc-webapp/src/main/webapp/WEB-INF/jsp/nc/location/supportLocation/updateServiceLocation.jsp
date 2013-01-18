<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

      <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/dealerLocation/nc-dealership.css"/>
          <script type="text/javascript" src="${pageContext.request.contextPath}/js/nc-ajax.js"></script>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp"/>


        <div id="dealerLocationDetailsPage" class="pageContent_wrapper">

            <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean">
                <c:choose>
                    <c:when test="${actionBean.location.type.shipToPartyLocation eq true}">
                        <!-- for selenium tests: ship to party location page -->
                        <c:set var="pageName" value="EditShipToPartyLocation" scope="page"/>
                    </c:when>
                    <c:otherwise>
                        <!-- for selenium tests: other support location page -->
                        <c:set var="pageName" value="EditSupportLocation" scope="page"/>
                    </c:otherwise>
                </c:choose>

                <nc:pageName pageName="${pageName}"/>
                <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>


                <stripes:layout-render name="/WEB-INF/jsp/nc/location/_locationCommonForm.jsp" pageName="${pageName}" showLocationTabs="false"/>

                <div class="mainContent_wrapper">
                    <stripes:layout-render name="/WEB-INF/jsp/nc/location/generalInfo/components/_generalInfo.jsp" pageName="${pageName}"/>
                    <div class="clear"></div>

                    <stripes:layout-render name="/WEB-INF/jsp/nc/location/generalInfo/components/_addressInfo.jsp" pageName="${pageName}"/>
                    <div class="clear"></div>

                    <stripes:layout-render name="/WEB-INF/jsp/nc/location/generalInfo/components/_communicationEmailURLInfo.jsp" pageName="${pageName}"/>
                    <div class="clear"></div>
   
                    <stripes:layout-render name="/WEB-INF/jsp/nc/location/generalInfo/components/_datesInfo.jsp" pageName="${pageName}"/>
                    <div class="clear"></div>

                    <stripes:layout-render name="/WEB-INF/jsp/nc/location/generalInfo/components/_notesInfo.jsp" pageName="${pageName}"/>
                    <div class="clear"></div>

                    <stripes:layout-render name="/WEB-INF/jsp/nc/location/supportLocation/components/_tmcaInfo.jsp" pageName="${pageName}"/>
                    <div class="clear"></div>

                    <c:set var="initializeServiceTypeFunctionName" value="initializeServiceType"/>
                    <stripes:layout-render name="/WEB-INF/jsp/nc/location/tmcaInfo/components/_serviceType.jsp" pageName="${pageName}"
                                           initializeServiceTypeFunctionName="${initializeServiceTypeFunctionName}"/>

                    <stripes:layout-render name="/WEB-INF/jsp/nc/location/supportLocation/components/_deliveryInfo.jsp" pageName="${pageName}"/>
                    <div class="clear"></div>

                    <stripes:layout-render name="/WEB-INF/jsp/nc/location/tmcaInfo/components/_otherFranchise.jsp" pageName="${pageName}"/>
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
        <div id="changeLocationTypeDialog" class="dialog dialogWithDefaultCloseButton">
            <div class="bd" id="changeLocationTypeDialogBody">&nbsp;</div>
        </div>
    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">
        <jsp:include page="/WEB-INF/jsp/nc/location/_js.jsp"/>
        <script type="text/javascript">

                function yuiLoadComplete(){
                    YAHOO.util.Event.onDOMReady(function(){
                        <nc:ifWriteAccessAllowed name="location.serviceTypes">
                              ${initializeServiceTypeFunctionName}();
                          </nc:ifWriteAccessAllowed>
                        changeLocationTypeDialog.initDialog();

                        <nc:ifWriteAccessAllowed name="location.sharedFacilities">
                                LocationSharedFacilityHandler.initAll(); // handler declared inside _otherFranchise.jsp
                        </nc:ifWriteAccessAllowed>

                          <nc:ifWriteAccessAllowed name="location.sapCode">
                                SAPLocationVerificator.initAll(); // verificator declared inside _generalInfo.jsp
                        </nc:ifWriteAccessAllowed>
                    });
                }
        </script>
    </stripes:layout-component>
</stripes:layout-render>