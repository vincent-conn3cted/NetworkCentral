<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>    
    <nc:pageViewMode readOnly="${readOnly}"/>
    <fieldset>
            <nc:label for="appointment.primaryPosition" name="appointment.primaryPosition"/>
            <nc:checkbox name="appointment.primaryPosition" id="appointment.primaryPosition"/>
            <span  class="sprite2 tips" title="<fmt:message key="positions.section.primaryPosition.tip"/>"></span>
            <br/>

            <nc:label for="appointment.twrsChampionFlag" name="appointment.twrsChampionFlag"/>
            <nc:checkbox name="appointment.twrsChampionFlag" id="appointment.twrsChampionFlag"/><br/>

            <nc:label for="appointment.privacyOfficerFlag" name="appointment.privacyOfficerFlag"/>
            <nc:checkbox name="appointment.privacyOfficerFlag" id="appointment.privacyOfficerFlag"/><br/>

            <nc:label for="appointment.trainingOfficerFlag" name="appointment.trainingOfficerFlag"/>
            <nc:checkbox name="appointment.trainingOfficerFlag" id="appointment.trainingOfficerFlag"/><br/>

            <nc:label for="appointment.authorisedTrainingApproverFlag" name="appointment.authorisedTrainingApproverFlag"/>
            <nc:checkbox name="appointment.authorisedTrainingApproverFlag" id="appointment.authorisedTrainingApproverFlag"/><br/>
            
            <c:set var="addToSapDivDisplayValue" value="none"/>
            <c:if test="${actionBean.isSalesPositionSelected}">
                <c:set var="addToSapDivDisplayValue" value="block"/>
            </c:if>
            <span id="addToSapDiv" style="display:<c:out value="${addToSapDivDisplayValue}"/>;">
                <nc:label for="appointment.salesIndicator" name="appointment.salesIndicator"/>
                <nc:checkbox name="appointment.salesIndicator" id="appointment.salesIndicator"/><br/>
            </span>
    </fieldset>
</stripes:layout-definition>
