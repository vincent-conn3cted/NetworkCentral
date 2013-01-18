<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:form id="saveSearchOverwriteForm" beanclass="au.com.toyota.nc.webapp.stripes.savedsearch.SaveSearchActionBean" method="post">
    <jsp:include page="/WEB-INF/jsp/nc/dealer/_exportHiddenFields.jsp"/>

    <stripes:hidden name="savedSearch.type"/>
    <stripes:hidden name="savedSearch.name"/>

    <div id="saveSearchOverwriteMessage"><fmt:message key="savedSearch.overwrite.message"/></div>

    <div id="cancelSaveSearchButton" class="default-button" onclick="hideSaveSearchDialog();"><fmt:message key="savedSearch.buttons.cancel"/></div>
    <div id="overwriteButton" class="default-button" onclick="overwriteSaveSearchDialog('overwriteLocationSaveSearchLabel');"><fmt:message key="savedSearch.buttons.overwrite"/></div>
</stripes:form>
