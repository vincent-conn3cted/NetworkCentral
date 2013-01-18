<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <%-- ==========================================
    Secure page stuffs
    =============================================--%>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

    <nc:label name="dealer.generalInfo.mainFranchise" for="dealer.generalInfo.mainFranchise"/>
    <nc:select name="dealer.generalInfo.mainFranchise" id="dealer.generalInfo.mainFranchise" readOnlyValue="${actionBean.dealer.generalInfo.mainFranchise}">
        <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_franchiseOptions.jsp" selectedValue="${actionBean.dealer.generalInfo.mainFranchise}"/>
    </nc:select><br/>
</stripes:layout-definition>