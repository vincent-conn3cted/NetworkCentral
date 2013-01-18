<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${readOnly}"/>
    <fieldset>
        <legend><fmt:message key="positions.section.appointment"/></legend>
        <nc:label for="appointmentDepartments" name="appointmentDepartments" class="mandatory"/>
        <nc:select name="appointmentDepartments" id="appointmentDepartments" multiple="true" readOnlyValue="${actionBean.appointmentDepartmentsValues}">
            <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.Department" label="description"/>
        </nc:select><br/>
        <nc:ifReadOnlyAccess name="appointmentDepartments">
            <c:forEach items="${actionBean.appointmentDepartments}" var="appointmentDepartment" varStatus="appointmentDepartmentIndex">
                <stripes:hidden name="appointmentDepartments[${appointmentDepartmentIndex.index}]" value="${appointmentDepartment}"/>
            </c:forEach>
        </nc:ifReadOnlyAccess>

        <c:set var="now" value="<%=new java.util.Date()%>" />
        <nc:label for="appointment.appointmentDate.startDate" name="appointment.appointmentDate.startDate" class="mandatory"/>
        <nc:text name="appointment.appointmentDate.startDate" id="appointment.appointmentDate.startDate"><fmt:formatDate value="${now}" pattern="dd/MM/yyyy"/></nc:text><br/>

        <nc:label for="appointment.partTimeFlag" name="appointment.partTimeFlag"/>
        <nc:checkbox name="appointment.partTimeFlag" id="appointment.partTimeFlag"/>
		<br/>
        <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_trainingManagers.jsp" showTrainingManagersEvent="showTrainingManagersForDealer"/>
        <br/>
    </fieldset>    
</stripes:layout-definition>
