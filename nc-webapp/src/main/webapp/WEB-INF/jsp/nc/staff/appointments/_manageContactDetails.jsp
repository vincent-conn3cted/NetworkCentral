<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${readOnly}"/>
    <fieldset>
        <legend><fmt:message key="positions.section.contactdetails"/></legend>
        <nc:label for="appointment.contact.phone" name="appointment.contact.phone" class="mandatory"/>
        <nc:text name="appointment.contact.phone" id="appointment.contact.phone"/><br/>

        <nc:label for="appointment.contact.email" name="appointment.contact.email" class="mandatory"/>
        <nc:text name="appointment.contact.email" id="appointment.contact.email"/><br/>

        <nc:label for="appointment.contact.fax" name="appointment.contact.fax"/>
        <nc:text name="appointment.contact.fax" id="appointment.contact.fax"/><br/>

        <nc:label for="appointment.contact.mobile" name="appointment.contact.mobile"/>
        <nc:text name="appointment.contact.mobile" id="appointment.contact.mobile"/><br/>
    </fieldset>    
</stripes:layout-definition>
