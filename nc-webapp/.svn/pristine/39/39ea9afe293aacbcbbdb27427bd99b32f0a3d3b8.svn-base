<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<%--
    Defines all the common form attributes across different dealer tabs
--%>
<stripes:layout-definition>
    <!-- Start Dealer Common Form -->
    <c:import url="/WEB-INF/jsp/messages.jsp"/>

    <input type="hidden"  name="showAsReadOnly" value="${actionBean.showAsReadOnly}"/>

    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_dealerHeaderToolbar.jsp" pageName="${pageName}"/>
    <div class="clear">&nbsp;</div>
    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_tabs.jsp"/>

    <stripes:hidden name="dealer.dealerId" id="dealerId"/>
    <stripes:hidden name="lastTabShown"/>

    <!-- End Dealer  Common Form -->
</stripes:layout-definition>