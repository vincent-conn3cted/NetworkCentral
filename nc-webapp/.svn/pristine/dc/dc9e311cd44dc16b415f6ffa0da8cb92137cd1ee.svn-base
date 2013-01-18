<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:hidden name="searchReq.allowSearchByDealerName"/>
<stripes:hidden name="searchReq.allowSearchByDealerRegion"/>
<stripes:hidden name="searchReq.allowSearchByFranchise"/>
<stripes:hidden name="searchReq.allowSearchByLocationName"/>
<stripes:hidden name="searchReq.allowSearchByLocationType"/>
<stripes:hidden name="searchReq.allowSearchByLocationState"/>
<stripes:hidden name="searchReq.allowSearchByLocationSuburb"/>
<stripes:hidden name="searchReq.allowSearchByMetroFlag"/>
<stripes:hidden name="searchReq.allowSearchByPMA"/>
<stripes:hidden name="searchReq.allowSearchByProduct"/>
<stripes:hidden name="searchReq.allowSearchByStatus"/>
<stripes:hidden name="searchReq.allowSearchByWeight"/>
<stripes:hidden name="searchReq.searchForEdit"/>

<stripes:hidden name="searchReq.dealerName"/>
<stripes:hidden name="searchReq.dealerStatus[0]"/>
<stripes:hidden name="searchReq.locationName"/>
<stripes:hidden name="searchReq.locationType"/>
<stripes:hidden name="searchReq.locationStatus[0]"/>
<stripes:hidden name="searchReq.locationSuburb"/>
<stripes:hidden name="searchReq.locationState"/>
<stripes:hidden name="searchReq.dealerRegion"/>

<c:forEach items="${actionBean.toyotaWeightGroup}" var="weightGroupType" varStatus="i">
    <stripes:hidden name="searchReq.weights[${i.index}].type" value="${weightGroupType}"/>
    <stripes:hidden name="searchReq.weights[${i.index}].value"/>
</c:forEach>

<c:set var="lexusWeightGroupNewIndex" value="${fn:length(actionBean.toyotaWeightGroup)}"/>
<c:forEach items="${actionBean.lexusWeightGroup}" var="weightGroupType">
    <stripes:hidden name="searchReq.weights[${lexusWeightGroupNewIndex}].type" value="${weightGroupType}"/>
    <stripes:hidden name="searchReq.weights[${lexusWeightGroupNewIndex}].value"/>
    <c:set var="lexusWeightGroupNewIndex" value="${lexusWeightGroupNewIndex + 1}"/>
</c:forEach>

<stripes:hidden name="searchReq.dealerPMA"/>
<stripes:hidden name="searchReq.product"/>
<stripes:hidden name="searchReq.metroFlag"/>
<stripes:hidden name="searchReq.franchise"/>
