<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<nc:pageName pageName="Appointments-Manage"/>
<nc:pageViewMode readOnly="${readOnly}"/>
<stripes:layout-definition>
     <nc:ifWriteAccessAllowed name="appointment.positionDefinition">
	     <stripes:label for="appointment.positionDefinition" class="mandatory"/>
	     <stripes:select name="selectedPositionDefinitionId" id="selectedPositionDefinitionId">
	         <c:if test="${fn:length(actionBean.positionDefinitions) > 1}">
	         	<stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
	         </c:if>
	         <stripes:options-collection collection="${actionBean.positionDefinitions}" label="description" value="commonValueId"/>
	     </stripes:select><br/>
	</nc:ifWriteAccessAllowed>
    <nc:ifReadOnlyAccess name="appointment.positionDefinition">
        <stripes:hidden name="selectedPositionDefinitionId"/>
        <stripes:label for="appointment.positionDefinition"/>
        <span class="formValue"><c:out value="${actionBean.appointment.positionDefinition.description}"/></span><br/>
    </nc:ifReadOnlyAccess>
    <stripes:hidden name="selectedPositionId" value="${actionBean.selectedPositionId}"/>    
</stripes:layout-definition>