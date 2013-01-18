<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<%--
 - Enables the display of a location name to be standadized to ensure that the name, followed by the suburbs in brackets,
 - is always displayed. This ensures a consistent display when a location must be, for example, selected from a
 - selection list
--%>
<stripes:layout-definition>
    <c:out value="${location.locationName}"/>
    <c:if test="${location.contact.streetAddress.suburb != ''}">
        (<c:out value="${location.contact.streetAddress.suburb}"/>)
    </c:if>
</stripes:layout-definition>
