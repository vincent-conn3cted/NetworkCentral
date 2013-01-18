<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

   <stripes:layout-component name="html-head">
          <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/dealerLocation/nc-dealership.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp"/>


        <div id="dealerLocationDetailsPage" class="pageContent_wrapper">
               <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean">
                    <%-- ==========================================
                    Secure page stuffs
                 =============================================--%>
                <c:set var="pageName" value="EditLocation-${actionBean.location.type}-Marketing" scope="page"/>
                 <nc:pageName pageName="${pageName}"/>
                <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

                 <stripes:layout-render name="/WEB-INF/jsp/nc/location/_locationCommonForm.jsp" pageName="${pageName}" showLocationTabs="true"/>

               <div id="locationDetails-marketingSection" class="mainContent_wrapper">
                    <stripes:layout-render name="/WEB-INF/jsp/nc/location/marketingInfo/components/_subscriptionInfo.jsp" pageName="${pageName}"/>
                   <div class="clear"></div>
               </div>
               <div class="clear"></div>
            </stripes:form>
            <div class="clear"></div>
        </div>

    </stripes:layout-component>



</stripes:layout-render>