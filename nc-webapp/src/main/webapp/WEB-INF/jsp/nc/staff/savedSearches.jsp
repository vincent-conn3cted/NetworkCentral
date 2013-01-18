<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
         <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/savedSearches/nc-savedSearches.css"/>
    </stripes:layout-component>


    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: saved searches page -->
         <div class="pageContent_main_header">
            <h1>Saved Dealer Staff Searches</h1>
         </div>

        <div id="savedDealerSearchPage" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                <jsp:include page="/WEB-INF/jsp/nc/staff/_searchPagesRadioTabs.jsp">
                    <jsp:param name="selectedBox" value="savedSearches"/>
                    <jsp:param name="searchEventName" value="${actionBean.searchEventName}"/>
                </jsp:include>
                <div class="clear"></div>
        
                <div id="savedSearchesEntries">
                    <table id="savedSearches" class="resultsTable">
                        <thead>
                            <tr>
                                <th>Saved Search Name</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${actionBean.savedSearches}" var="savedSearch" varStatus="loopStatus">
                                <tr class="${loopStatus.index %2==0 ? 'darkRow':'lightRow'}">
                                    <td>
                                        <div class="data-line">
                                            <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.staff.DealerStaffSearchActionBean" event="${actionBean.searchEventName}">
                                                <c:forEach items="${savedSearch.parameters}" var="parameters">
                                                    <stripes:param name="${parameters.key}" value="${parameters.value}"/>
                                                </c:forEach>
                                                <c:out value="${savedSearch.name}"/>
                                            </stripes:link>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="data-line">
                                            <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.savedsearch.SaveSearchActionBean" event="deleteSavedDealerStaffSearch">
                                                <stripes:param name="savedSearch.savedSearchId" value="${savedSearch.savedSearchId}"/>
                                                <fmt:message key="savedSearch.action.remove"/>
                                            </stripes:link>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
          </div>
    </div>
    </stripes:layout-component>
</stripes:layout-render>
