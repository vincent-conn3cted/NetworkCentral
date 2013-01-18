<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:form id="saveSearchOverwriteForm" beanclass="au.com.toyota.nc.webapp.stripes.savedsearch.SaveSearchActionBean" method="post">
    <jsp:include page="/WEB-INF/jsp/nc/staff/_exportHiddenFields.jsp"/>

    <stripes:hidden name="savedSearch.type"/>
    <stripes:hidden name="savedSearch.name"/>

    <div id="saveSearchOverwriteMessage"><fmt:message key="savedSearch.overwrite.message"/></div>
    
    <input type="button" id="overwriteButton" onclick="overwriteSaveSearchDialog('overwriteLocationSaveSearchLabel');" value="<fmt:message key="savedSearch.buttons.overwrite"/>"/>
    <input type="button" id="cancelSaveSearchButton" onclick="hideSaveSearchDialog();" value="<fmt:message key="savedSearch.buttons.cancel"/>"/>
</stripes:form>
