<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<%@ page import="au.com.toyota.nc.common.model.hibernate.ToyotaFranchise" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" %>

<stripes:layout-definition>
    <c:set var="toyotaValue" value="<%= ToyotaFranchise.Toyota%>"/>
    <c:set var="lexusValue" value="<%= ToyotaFranchise.Lexus%>"/>
    <option value="<c:out value="${toyotaValue}"/>" <c:if test="${toyotaValue == selectedValue}">selected="selected"</c:if>><c:out value="${toyotaValue}"/></option>
    <option value="<c:out value="${lexusValue}"/>" <c:if test="${lexusValue == selectedValue}">selected="selected"</c:if>><c:out value="${lexusValue}"/></option>
    <c:if test="${selectedValue != null && selectedValue != toyotaValue && selectedValue != lexusValue}">
        <option value="<c:out value="${selectedValue}"/>" selected="selected"><c:out value="${selectedValue}"/></option>
    </c:if>
</stripes:layout-definition>