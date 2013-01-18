<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

    <stripes:layout-component name="html-head">
         <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/dealerLocation/nc-dealership.css"/>
    </stripes:layout-component>


    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: dealer update marketing  page -->
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp" />

        <div id="dealerLocationDetailsPage" class="pageContent_wrapper">
            <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean">
                <%-- ==========================================
                        Secure page stuffs
                     =============================================--%>
                <c:set var="pageName" value="EditDealership-Marketing" scope="page"/>

                <nc:pageName pageName="${pageName}"/>
                <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
                <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_dealerCommonForm.jsp" pageName="${pageName}"/>


                <div id="dealerDetails-marketingSection" class="mainContent_wrapper">
                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/marketingInfo/_subscriptionDialog.jsp" pageName="${pageName}"/>
                </div>
            </stripes:form>
        </div>
    </stripes:layout-component>



    <stripes:layout-component name="init-event-handling">
        <script type="text/javascript">
                function yuiLoadComplete(){
                    YAHOO.util.Event.onDOMReady(function(){
                        <nc:ifWriteAccessAllowed name="dealer.marketingSubscription">
                                initializeSubscriptionDialog();
                        </nc:ifWriteAccessAllowed>

                    });
                }
        </script>
    </stripes:layout-component>

</stripes:layout-render>
