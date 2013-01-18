<%@ page import="au.com.toyota.nc.webapp.stripes.staff.AppointmentSourceActionType" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <div id="languageDialogBox" class="dialog dialogWithDefaultCloseButton">
        <div class="bd" id="languageDialogBoxBody">
        <select id="addLanguageId">
            <c:forEach items="${actionBean.allLanguages}" var="language">
                    <option value="${language.commonValueId}"><c:out value="${language.value}"/></option>
            </c:forEach>
        </select>
        <input type="button" id="addLanguageButton" onclick="updateLanguages();" value="Save"/>
    </div>
</stripes:layout-definition>
