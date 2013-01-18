<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:form beanclass="${actionBean.class}" target="_blank">
    <jsp:include page="/WEB-INF/jsp/nc/dealer/_exportHiddenFields.jsp"/>
    <jsp:include page="/WEB-INF/jsp/nc/staff/_exportHiddenFields.jsp"/>

    <c:set var="namesWithoutAddresses" value="${actionBean.namesWithoutAddresses}" scope="page"/>
    <div id="locationsWithNoAddressBox">
    <c:if test="${fn:length(namesWithoutAddresses) > 0}">
        <div>Address details could not be found for:</div>
            <ol id="locationWithNoAddressList">
                <c:forEach var="name" items="${namesWithoutAddresses}">
                    <li><c:out value="${name}"/></li>
                </c:forEach>
            </ol>
    </c:if>
    </div>
    <div>
        <stripes:submit id="generateMailingLabelReportButton" name="generate">Generate Report</stripes:submit>
    </div>
</stripes:form>