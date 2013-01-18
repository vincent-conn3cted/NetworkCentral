<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:form id="saveSearchLabelForm" beanclass="au.com.toyota.nc.webapp.stripes.savedsearch.SaveSearchActionBean" method="post"
              onsubmit="saveSaveSearchDialog('saveLocationSaveSearchLabel');return false;">
    <c:import url="/WEB-INF/jsp/messages.jsp"/>

    <jsp:include page="/WEB-INF/jsp/nc/dealer/_exportHiddenFields.jsp"/>

    <stripes:label for="savedSearch.name" name="savedSearch.name"/>
    <stripes:text id="savedSearch.name" name="savedSearch.name"/>

    <stripes:hidden name="savedSearch.type" value="LOCATION"/>

    <span id="saveButton" class="default-button" onclick="saveSaveSearchDialog('saveLocationSaveSearchLabel');"/><fmt:message key="savedSearch.buttons.ok"/></span>
</stripes:form>