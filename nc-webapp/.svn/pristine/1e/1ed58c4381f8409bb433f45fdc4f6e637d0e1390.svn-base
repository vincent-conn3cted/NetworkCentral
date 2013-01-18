<%@ page import="au.com.toyota.nc.webapp.search.staff.RegionSearchOptionsFactory" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

    <stripes:layout-component name="html-head">
      <link rel="stylesheet" media="screen" type="text/css"
              href="${pageContext.request.contextPath}/css/wib/staff/nc-staff.css"/>
         <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/savedSearches/nc-savedSearches.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <nc:pageName pageName="ViewDealerStaff-SearchCriteria"/>
        <!-- SEARCH FOR DEALER STAFF -->
        <!-- for selenium tests: search dealer staff for view page -->
       <div class="pageContent_main_header">
            <h1>Search Dealer Staff</h1>
         </div>

        <div id="searchDealerStaffPage" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
            	<c:import url="/WEB-INF/jsp/messages.jsp"/>
                <stripes:form id="viewDealerStaffSearchForm" beanclass="au.com.toyota.nc.webapp.stripes.staff.DealerStaffSearchActionBean" method="post">
	                <div id="searchFormLayoutSection">
                          <jsp:include page="/WEB-INF/jsp/nc/staff/_searchPagesRadioTabs.jsp">
                            <jsp:param name="selectedBox" value="newSearch"/>
                            <jsp:param name="searchEventName" value="searchForView"/>
                        </jsp:include>


                        <nc:ifAccessAllowed name="dealerStaff.search.criteria.superRolesAndSearcherUpdaterOnly">
                             <table class="form searchParameters">
                                <caption>Staff Details</caption>
                                <tbody>
                                        <nc:ifAccessAllowed name="dealerStaff.search.criteria.dealerSearcherUpdaterOnly">
                                            <tr class="rowHighLight">
                                                <th><stripes:label for="searchReq.myDealer"/></th>
                                                <td><stripes:checkbox name="searchReq.myDealer" checked="true" value="true">Test</stripes:checkbox></td>
                                            </tr>
                                        </nc:ifAccessAllowed>

                                        <tr class="rowHighLight">
                                                <th><stripes:label for="searchReq.dealerStaffNo"/></th>
                                                <td><stripes:text name="searchReq.dealerStaffNo"/></td>
                                        </tr>
                                        <tr class="rowHighLight">
                                                <th><stripes:label for="searchReq.firstname"/></th>
                                                <td><stripes:text name="searchReq.firstname"/></td>
                                        </tr>
                                        <tr class="rowHighLight">
                                                <th><stripes:label for="searchReq.surname"/></th>
                                                <td><stripes:text name="searchReq.surname"/></td>
                                        </tr>
                                </tbody>
                            </table>
                        </nc:ifAccessAllowed>
                        <nc:ifAccessAllowed name="dealerStaff.search.criteria.superRolesOnly">
                            <table class="form searchParameters">
                                <caption>Dealer Details</caption>
                                <tbody>
                                <tr class="rowHighLight">
                                    <th><stripes:label for="searchReq.dealerName"/></th>
                                    <td><stripes:text name="searchReq.dealerName"/></td>
                                </tr>
                                <tr class="rowHighLight">
                                    <th><stripes:label for="searchReq.locationSuburb"/></th>
                                    <td><stripes:text name="searchReq.locationSuburb"/></td>
                                </tr>
                                <tr class="rowHighLight">
                                    <th><stripes:label for="searchReq.locationState"/></th>
                                    <td>
                                        <stripes:select name="searchReq.locationState">
                                            <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                            <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.State"/>
                                        </stripes:select>
                                    </td>
                                </tr>
                                <tr class="rowHighLight">
                                    <th><stripes:label for="searchReq.dealerRegion"/></th>
                                    <td>
                                        <stripes:select name="searchReq.dealerRegion">
                                            <stripes:option label="Select One" value=""/>
                                            <stripes:options-collection collection="<%= RegionSearchOptionsFactory.createSearchOptions()%>"
                                                                        value="id"
                                                                        label="description"/>
                                        </stripes:select>
                                    </td>
                                </tr>
                                <tr class="rowHighLight">
                                    <th><stripes:label for="searchReq.department"/></th>
                                    <td>
                                        <stripes:select name="searchReq.department">
                                            <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                            <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.Department" label="description"/>
                                        </stripes:select>
                                    </td>
                                </tr>
                                <tr class="rowHighLight">
                                    <th><stripes:label for="searchReq.position"/></th>
                                    <td>
                                        <stripes:select name="searchReq.position">
                                            <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                            <stripes:options-collection collection="${actionBean.positions}" label="description" value="positionId"/>
                                        </stripes:select>
                                    </td>
                                </tr>
                                <tr class="rowHighLight">
                                    <th><stripes:label for="searchReq.franchise"/></th>
                                    <td>
                                        <stripes:select name="searchReq.franchise" id="searchReq.franchise">
                                            <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                            <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_franchiseOptions.jsp" selectedValue="${actionBean.searchReq.franchise}"/>
                                        </stripes:select>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </nc:ifAccessAllowed>
                        <div class="clear">&nbsp;</div>
                        <nc:ifAccessAllowed name="dealerStaff.search.criteria.superRolesAndSearcherUpdaterOnly">
                            <div class="formActionButtons">
                                <stripes:submit name="searchForView" id="performSearch" class="btn btn_search">Search</stripes:submit>
                                <stripes:reset name="reset" id="resetForm" class="btn btn_reset">Reset</stripes:reset>
                                <div class="clear"></div>
                            </div>
                        </nc:ifAccessAllowed>
                        <div class="clear">&nbsp;</div>
                </div><!--end of searchFormLayoutSection -->
                <div class="clear">&nbsp;</div>
                <!-- add content messsage -->
                <div id="searchFormInstruction" class="instructions">
                	<c:choose>
	                	<c:when test="${actionBean.context.userRole.delearUpdateOrDelearSearch}">
	                    	<jsp:include page="/WEB-INF/jsp/nc/staff/searchMessageForDealerSearcherORUpdater.jsp"/>
	                    </c:when>
	                	<c:otherwise>
	                    	<jsp:include page="/WEB-INF/jsp/nc/staff/searchMessageForTKUsers.jsp"/>
	                    </c:otherwise>
                    </c:choose>
                </div>
            </stripes:form>                
            <div class="clear"></div>
            </div>
        </div>
    </stripes:layout-component>
    <stripes:layout-component name="init-event-handling">
         <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerStaffDataTableDef.jsp"/>
        <script type="text/javascript">
            function yuiLoadComplete(){
            }
        </script>
    </stripes:layout-component>
</stripes:layout-render>