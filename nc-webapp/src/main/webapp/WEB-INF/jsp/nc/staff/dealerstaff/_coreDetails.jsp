<%@ page import="au.com.toyota.nc.common.utils.NCConstants" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${readOnly}"/>
    <c:if test="${readOnly != true}">
    	<c:set var="madatoryClass" value="mandatory"/>
    </c:if>
    
    <!-- for selenium tests: dealer staff core details section -->
    <nc:label for="dealerStaff.title" name="dealerStaff.title" class="${madatoryClass}"/>
    <nc:select name="dealerStaff.title" readOnlyValue="${actionBean.dealerStaff.title}" style="text-align:left;" id="dealerStaff.title">
            <stripes:option value=""/>
            <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.Title"/>
    </nc:select><br/>

    <nc:label name="dealerStaff.firstname" for="dealerStaff.firstname" class="${madatoryClass}"/>
    <nc:text name="dealerStaff.firstname" id="dealerStaff.firstname"/><br/>

    <nc:label name="dealerStaff.surname" for="dealerStaff.surname" class="${madatoryClass}"/>
    <nc:text name="dealerStaff.surname" id="dealerStaff.surname" /><br/>

    <nc:ifWriteAccessAllowed name="dealerStaff.dob">
        <stripes:label name="dealerStaff.dob" for="dealerStaff.dob" class="${madatoryClass}"/>
        <span>
            <nc:datetext name="dealerStaff.dob"
                         id="dealerStaff.dob"
                         buttonId="dateOfBirthTrigger"
                         skipPermissions="true"/>
        </span><br/>
    </nc:ifWriteAccessAllowed>

    <c:if test="${actionBean.eligible=='true'}">
        <nc:ifReadOnlyAccess name="dealerStaff.dob">
            <stripes:label name="dealerStaff.dob"/>
            <span class="formValue" id="dealerStaff.dob.readonly"><fmt:formatDate value="${actionBean.dealerStaff.dob}" pattern="<%= NCConstants.FORMAT_DD_MM_YYYY%>"/></span><br/>
        </nc:ifReadOnlyAccess>
    </c:if>
</stripes:layout-definition>

