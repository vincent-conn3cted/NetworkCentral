<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

    <stripes:layout-component name="html-head">
          <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/dealerLocation/nc-dealership.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: dealer update location page -->
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp"/>

        <div id="dealerLocationDetailsPage" class="pageContent_wrapper">
            <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean">
                <c:set var="pageName" value="EditDealership-Location" scope="page"/>
                <nc:pageName pageName="${pageName}"/>
                <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
                <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_dealerCommonForm.jsp" pageName="${pageName}"/>

                <div id="dealerDetails-locationSection" class="mainContent_wrapper">
                    <ul class="column-style-fieldset oneCol">
                        <li>
                            <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/locationInfo/components/_locationInfo.jsp" pageName="${pageName}"/>
                        </li>
                    </ul>
                    <div class="clear"></div>
                </div>
            </stripes:form>
        </div>
    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">
        <script type="text/javascript">

                function yuiLoadComplete(){
                    YAHOO.util.Event.onDOMReady(function(){
                    });
                }
        </script>
    </stripes:layout-component>

</stripes:layout-render>