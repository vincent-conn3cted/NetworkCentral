<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
        <nc:ifAccessAllowed name="dealerStaff.dealerStaffNo">
            <stripes:label for="dealerStaff.dealerStaffNo"/>
            <span><c:out value="${actionBean.dealerStaff.dealerStaffNumber}"/></span><br/>
        </nc:ifAccessAllowed>
</stripes:layout-definition>
