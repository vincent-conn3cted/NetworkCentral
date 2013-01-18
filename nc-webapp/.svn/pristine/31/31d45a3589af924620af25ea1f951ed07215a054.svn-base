<%@ page import="au.com.toyota.nc.common.model.hibernate.DocumentType" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<%--
    Defines all the common form attributes across different location tabs
--%>
<stripes:layout-definition>
    <!-- Start Location Common Form -->
    <c:import url="/WEB-INF/jsp/messages.jsp"/>

    <input type="hidden"  name="showAsReadOnly" value="${actionBean.showAsReadOnly}"/>

    <stripes:layout-render name="/WEB-INF/jsp/nc/location/_locationHeaderToolbar.jsp" pageName="${pageName}"/>
    <div class="clear">&nbsp;</div>
    <c:if test="${showLocationTabs eq true}">
        <stripes:layout-render name="/WEB-INF/jsp/nc/location/_tabs.jsp"/>
    </c:if>


    <stripes:hidden name="location.locationId"/>
    <stripes:hidden name="location.dealer.dealerId" id="dealerId"/>
    <stripes:hidden name="location.dealer.generalInfo.dealerName" id="dealerName"/>
    <stripes:hidden name="location.dealer.generalInfo.dealerCode" id="dealerCode"/>
    <stripes:hidden name="location.dealer.generalInfo.sapDealerCode" id="sapDealerCode"/>

    <stripes:hidden name="lastTabShown"/>
    <stripes:hidden name="location.status"/>
    <!-- End Location Common Form -->
</stripes:layout-definition>