<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

    <stripes:layout-component name="html-head">
         <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/dealerLocation/nc-dealership.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: location update tmca info page -->
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp" />

        <!-- Start TMCA  Information Tab -->
         <div id="dealerLocationDetailsPage" class="pageContent_wrapper">
            <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean">
                <%-- ==========================================
                    Secure page stuffs
                 =============================================--%>
                <c:set var="pageName" value="EditLocation-${actionBean.location.type}-TMCA" scope="page"/>
                 <nc:pageName pageName="${pageName}"/>
                 <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

                 <stripes:layout-render name="/WEB-INF/jsp/nc/location/_locationCommonForm.jsp" pageName="${pageName}" showLocationTabs="true"/>

                <div id="locationDetails-tmcaSection" class="mainContent_wrapper">
                <stripes:layout-render name="/WEB-INF/jsp/nc/location/tmcaInfo/components/_generalInfo.jsp" pageName="${pageName}"/>
                <div class="clear"></div>


                <c:set var="initializeOtherProductsFunctionName" value="initializeOtherProduct" scope="page"/>
                <stripes:layout-render name="/WEB-INF/jsp/nc/location/tmcaInfo/components/_otherProducts.jsp" pageName="${pageName}"
                        initializeOtherProductsFunctionName="${initializeOtherProductsFunctionName}"/>
                <div class="clear"></div>

                
                <ul class="column-style-fieldset twoCols">
                    <stripes:layout-render name="/WEB-INF/jsp/nc/location/tmcaInfo/components/_weightsInfo.jsp" pageName="${pageName}"/>
                    <stripes:layout-render name="/WEB-INF/jsp/nc/location/tmcaInfo/components/_customerServiceInfo.jsp" pageName="${pageName}"/>
                </ul>
                <div class="clear"></div>

                <stripes:layout-render name="/WEB-INF/jsp/nc/location/tmcaInfo/components/_capacityInfo.jsp" pageName="${pageName}"/>
                <div class="clear"></div>

                <stripes:layout-render name="/WEB-INF/jsp/nc/location/tmcaInfo/components/_csdInfo.jsp" pageName="${pageName}"/>
                <div class="clear"></div>
                 

                <ul class="column-style-fieldset twoCols">
                    <stripes:layout-render name="/WEB-INF/jsp/nc/location/tmcaInfo/components/_dealerGroupMembershipInfo.jsp" pageName="${pageName}"/>
                    <stripes:layout-render name="/WEB-INF/jsp/nc/location/tmcaInfo/components/_tmcaFieldRepInfo.jsp" pageName="${pageName}"/>

                <c:set var="initializeGetTMCAFieldRepInfoFunctionName" value="attachGetTMCAFieldRepInfoBehaviour" scope="page"/>
                <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/tmcaInfo/components/_tmcaFieldRepsInfoDialog.jsp"
                        initializeGetTMCAFieldRepInfoFunctionName="${initializeGetTMCAFieldRepInfoFunctionName}"/>
                </ul>
                <div class="clear"></div>
                    


                <stripes:layout-render name="/WEB-INF/jsp/nc/location/tmcaInfo/components/_deliveryInfo.jsp" pageName="${pageName}"/>
                    <div class="clear"></div>

                <stripes:layout-render name="/WEB-INF/jsp/nc/location/tmcaInfo/components/_businessImprovement.jsp" pageName="${pageName}"/>
                    <div class="clear"></div>

              <c:set var="initializeFinancialBenchmarkFunctionName" value="initializeFinancialBenchmarkDialog"/>
                <stripes:layout-render name="/WEB-INF/jsp/nc/location/tmcaInfo/components/_financialBenchmark.jsp" pageName="${pageName}"
                        initializeFinancialBenchmarkFunctionName="${initializeFinancialBenchmarkFunctionName}"/>
                    <div class="clear"></div>


                <c:set var="initializeServiceTypeFunctionName" value="initializeServiceType"/>
                <stripes:layout-render name="/WEB-INF/jsp/nc/location/tmcaInfo/components/_serviceType.jsp" pageName="${pageName}"
                        initializeServiceTypeFunctionName="${initializeServiceTypeFunctionName}"/>
                    <div class="clear"></div>


                <stripes:layout-render name="/WEB-INF/jsp/nc/location/tmcaInfo/components/_dealerCommittee.jsp" pageName="${pageName}"/>
                    <div class="clear"></div>

                  <stripes:layout-render name="/WEB-INF/jsp/nc/location/tmcaInfo/components/_otherFranchise.jsp" pageName="${pageName}"/>
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
             <div class="clear"></div>
        </div>
        <!-- End TMCA Information Tab -->
    </stripes:layout-component>


    <stripes:layout-component name="init-event-handling">
        <script type="text/javascript">
            function yuiLoadComplete(){
                YAHOO.util.Event.onDOMReady(function(){

                 <nc:ifWriteAccessAllowed name="location.financialBenchmark">
                        ${initializeFinancialBenchmarkFunctionName}();
                    </nc:ifWriteAccessAllowed>

                    <nc:ifWriteAccessAllowed name="location.serviceTypes">
                        ${initializeServiceTypeFunctionName}();
                    </nc:ifWriteAccessAllowed>

                    ${initializeGetTMCAFieldRepInfoFunctionName}();
                    ${initializeOtherProductsFunctionName}();

                    <nc:ifWriteAccessAllowed name="location.sharedFacilities">
                        LocationSharedFacilityHandler.initAll(); // handler declared inside _otherFranchise.jsp
                    </nc:ifWriteAccessAllowed>
                });
                disableReadOnlyCheckboxes();
            }
        </script>
    </stripes:layout-component>

</stripes:layout-render>
