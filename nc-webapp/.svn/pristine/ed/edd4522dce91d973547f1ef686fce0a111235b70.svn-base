<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<div id="agreementDialog">
    <stripes:form id="checkAgreementForm" beanclass="au.com.toyota.nc.webapp.stripes.staff.AddStaffAgreementActionBean" method="post">
        <c:import url="/WEB-INF/jsp/messages.jsp"/>

        <jsp:include page="/WEB-INF/jsp/nc/staff/_exportHiddenFields.jsp"/>

        <stripes:label for="savedSearch.name" name="savedSearch.name"/>
        <stripes:text id="savedSearch.name" name="savedSearch.name"/>

        <%--<stripes:hidden name="savedSearch.type" value="STAFF"/>--%>

        <input type="button" id="checkButton" value="<fmt:message key="agreement.buttons.agree"/>"/>
        <%--<input type="button" id="checkButton" onclick="checkAgreementDialog('checkAgreement');" value="<fmt:message key="agreement.buttons.agree"/>"/>--%>
    </stripes:form>
</div>
