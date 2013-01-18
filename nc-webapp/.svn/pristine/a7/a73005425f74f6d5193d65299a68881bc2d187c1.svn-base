<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<c:set var="disableSavedSearch" value="disabled=disabled"/>
<c:if test="${actionBean.hasSavedSearches}">
    <c:set var="disableSavedSearch" value=" "/>
</c:if>

<c:set var="newSearchSelected" value="checked='checked'"/>
<c:set var="saveSearchSelected" value=""/>
<c:if test="${param['selectedBox'] == 'savedSearches'}">
    <c:set var="saveSearchSelected" value="checked='checked'"/>
    <c:set var="newSearchSelected" value=""/>
</c:if>

<script type="text/javascript">
    function loadNewSearchPage()
    {
        location.href = '<stripes:url beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" event="displaySearchPage" />';
    }

    function loadSavedSearchPage()
    {
        location.href = '<stripes:url beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" event="displaySavedSearches" />';
    }
</script>

<div class="savedSearchesOptions">
    <ul class="searchTypeOptions">
        <li>
            <input id="newSearchOption"
                   name="searchType"
                   type="radio"
                   onclick="loadNewSearchPage();"
                   <c:out value="${newSearchSelected}"/>> <!-- whether to select or not-->
            <span class="label">New Search</span>
        </li>
        <li>
            <input id="savedSearchOption"
                   name="searchType"
                   type="radio"
                   onclick="loadSavedSearchPage();"
                   <c:out value="${disableSavedSearch}"/>
                   <c:out value="${saveSearchSelected}"/>> <!-- whether to select or not-->
            <span class="label">My Saved Search (<span id="savedSearchCount"><c:out value="${actionBean.savedSearchesSize}"/></span>)</span>
        </li>
    </ul>    
</div>
