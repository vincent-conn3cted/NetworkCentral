<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<nc:pageName pageName="Appointments-Manage"/>
<stripes:layout-definition>
<c:choose>
    <c:when test="${empty editModeFlag and not empty isDpGmrFlag}">
		<c:set var="trainingManagerValue" value="" scope="request"/>
	</c:when>
	<c:when test="${empty editModeFlag and eligibleTrainingManagers != null and fn:length(eligibleTrainingManagers) == 1}">
		<c:forEach items="${eligibleTrainingManagers}" var="trainningMgr">
			<c:if test="${trainningMgr != null}">
			 	<c:set var="trainingManagerValue" value="${trainningMgr.appointment_id}" scope="request"/>
			</c:if>
		</c:forEach>
	</c:when>
 </c:choose> 

        <nc:ifWriteAccessAllowed name="appointment.trainingApprovalManager">   
        	<stripes:label for="appointment.trainingApprovalManager" class="mandatory"/>
			<c:choose>
			    <c:when test="${empty editModeFlag}">
            		<stripes:select name="appointment.trainingManager.appointmentId" id="appointment.trainingManager.appointmentId" value="${trainingManagerValue}">
           			<stripes:option value="-1">Select One</stripes:option>
    				<stripes:options-collection collection="${eligibleTrainingManagers}" label="description" value="appointment_id"/>
                  	<c:if test="${not empty isDpGmrFlag}">
                       	<stripes:option value="" >None Required</stripes:option>
                   	</c:if>
            		</stripes:select>
				</c:when>
				<c:otherwise>
            		<stripes:select name="appointment.trainingManager.appointmentId" id="appointment.trainingManager.appointmentId">
           			<stripes:option value="-1">Select One</stripes:option>
    				<stripes:options-collection collection="${eligibleTrainingManagers}" label="description" value="appointment_id"/>
                  	<c:if test="${(not empty isDpGmrFlag) && (empty trainingManagerValue)}">
                       	<stripes:option value=""   selected="selected">None Required</stripes:option>
                   	</c:if>
                   	<c:if test="${(not empty isDpGmrFlag) && (not empty trainingManagerValue)}">
                       	<stripes:option value="">None Required</stripes:option>
                   	</c:if>
            		</stripes:select>
				</c:otherwise>
			 </c:choose> 
            <br/>
        </nc:ifWriteAccessAllowed> 
    <stripes:hidden name="selectedDealerId" value="${actionBean.selectedDealerId}"/>    
          
</stripes:layout-definition>
