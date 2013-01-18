<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

    <stripes:layout-component name="html-head">
          <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/dealerLocation/nc-dealership.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: dealer update legal info page -->
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp" />

        <div id="dealerLocationDetailsPage" class="pageContent_wrapper">

            <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean">
                    <%-- ==========================================
                    Secure page stuffs
                    =============================================--%>
                <c:set var="pageName" value="EditDealership-Legal" scope="page"/>
                <nc:pageName pageName="${pageName}"/>
                <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
                <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_dealerCommonForm.jsp" pageName="${pageName}"/>

                <div id="dealerDetails-legalSection" class="mainContent_wrapper">
                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/legalInfo/components/_dealerAgreementInfo.jsp" pageName="${pageName}"/>
                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/legalInfo/components/_financialInfo.jsp" pageName="${pageName}"/>
                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/legalInfo/components/_ownershipInfo.jsp" pageName="${pageName}"/>
                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/legalInfo/components/_specialConditionDialog.jsp" pageName="${pageName}"/>
                    <div class="clear"></div>
                <c:if test="${!actionBean.footerDisplayable}"> 
	                <c:if test="${(actionBean.dealer != null) && (actionBean.dealer.maintenanceDate != null) }"> 
			            <div align="center">
				        	<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.dealer.maintenanceDateAsString}"  />
				        </div>
				    </c:if>    
				</c:if>    
                </div>
            </stripes:form>
            <div class="clear"></div>
        </div>
    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">
        <script type="text/javascript">
            function yuiLoadComplete(){
                YAHOO.util.Event.onDOMReady(function(){

                    <nc:ifWriteAccessAllowed name="dealer.specialConditions">
                             initializeSpecialConditionDialog();
                    </nc:ifWriteAccessAllowed>

                    initializeSpecialConditionDetailsDialog();

                });
            }
        </script>
    </stripes:layout-component>

</stripes:layout-render>