<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<%--
 - Enables the display of a dealer name to be standadized to ensure that the name, followed by the PMA in brackets,
 - is always displayed. This ensures a consistent display when a dealer must be, for example, selected from a
 - selection list..

 - If the PMA is not present then none should be shown
--%>
<stripes:layout-definition>
    <c:out value="${dealer.generalInfo.dealerName}"/>
    <c:if test="${dealer.generalInfo.pma != null || dealer.generalInfo.dealerCode != null}">
        (
            <c:if test="${dealer.generalInfo.pma != null}">
                <c:out value="${dealer.generalInfo.pma.name}"/><c:if test="${dealer.generalInfo.dealerCode != null}">,&nbsp;</c:if>
            </c:if>
            <c:if test="${dealer.generalInfo.dealerCode != null}">
                <c:out value="${dealer.generalInfo.dealerCode}"/>
            </c:if>
        )
    </c:if>
</stripes:layout-definition>
