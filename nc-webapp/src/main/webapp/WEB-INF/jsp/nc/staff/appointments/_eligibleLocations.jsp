<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<nc:pageName pageName="Appointments-Manage"/>
<stripes:layout-definition>
    <nc:ifWriteAccessAllowed name="appointment.location.locationId">
        <stripes:label for="appointment.location.locationId" class="mandatory"/>
        <stripes:select name="appointment.location.locationId" id="appointment.location.locationId">
            <stripes:option value=""/>
            <c:forEach items="${eligibleLocations}" var="eligibleLocation">
                <stripes:option value="${eligibleLocation.locationId}">
                    <stripes:layout-render name="/WEB-INF/jsp/nc/formatting/_locationNameSelection.jsp" location="${eligibleLocation}"/>
                </stripes:option>
            </c:forEach>
        </stripes:select><br/>
    </nc:ifWriteAccessAllowed>
    <stripes:hidden name="selectedDealerId" value="${actionBean.selectedDealerId}"/>
</stripes:layout-definition>
