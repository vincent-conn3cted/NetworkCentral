<%@ page import="au.com.toyota.nc.webapp.search.dealer.LocationTypeSearchOptionsFactory" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
          <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/dealerLocation/nc-dealership.css"/>
         <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/savedSearches/nc-savedSearches.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
    <!-- for selenium tests: search dealer page -->
         <div class="pageContent_main_header">
            <h1>Search For Dealership</h1>
         </div>

        
        <div id="searchDealerPage" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
            <c:import url="/WEB-INF/jsp/messages.jsp"/>
            <div id="searchFormLayoutSection">
                <stripes:form id="dealerSearchForm" beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" method="post">

                    <stripes:hidden name="searchReq.allowSearchByDealerName"/>
                    <stripes:hidden name="searchReq.allowSearchByDealerCode"/>
                    <stripes:hidden name="searchReq.allowSearchByDealerRegion"/>
                    <stripes:hidden name="searchReq.allowSearchByFranchise"/>
                    <stripes:hidden name="searchReq.allowSearchByLocationName"/>
                    <stripes:hidden name="searchReq.allowSearchByLocationType"/>
                    <stripes:hidden name="searchReq.allowSearchByLocationState"/>
                    <stripes:hidden name="searchReq.allowSearchByLocationSuburb"/>
                    <stripes:hidden name="searchReq.allowSearchByMetroFlag"/>
                    <stripes:hidden name="searchReq.allowSearchByPMA"/>
                    <stripes:hidden name="searchReq.allowSearchByProduct"/>
                    <stripes:hidden name="searchReq.allowSearchByStatus"/>
                    <stripes:hidden name="searchReq.allowSearchByWeight"/>
                    <stripes:hidden name="searchReq.searchForEdit"/>


                    <c:if test="${actionBean.searchReq.searchForEdit eq false}">
                        <jsp:include page="/WEB-INF/jsp/nc/dealer/_searchPagesRadioTabs.jsp">
                            <jsp:param name="selectedBox" value="newSearch"/>
                        </jsp:include>
                    </c:if>

                    <table class="form searchParameters" style="float:right;">
                        <caption>Location Details</caption>
                        <tbody>
                        <c:if test="${actionBean.searchReq.allowSearchByLocationName}">
                                <tr class="rowHighLight">
                                    <th><stripes:label name="location.locationName" for="searchReq.locationName"/></th>
                                    <td>
                                        <div class="yui-ac">
                                            <stripes:text id="searchReq.locationName" name="searchReq.locationName" class="yui-ac-input"/>
                                            <div id="locationNameSearchResultContainer"></div>
                                        </div>
                                    </td>
                                </tr>
                        </c:if>
                        <c:if test="${actionBean.searchReq.allowSearchByLocationType}">
                            <tr class="rowHighLight">
                                <th><stripes:label name="location.locationType" for="searchReq.locationType"/></th>
                                <td>
                                    <stripes:select name="searchReq.locationType" id="searchReq.locationType">
                                        <stripes:option value="">All</stripes:option>
                                        <stripes:options-collection collection="<%= LocationTypeSearchOptionsFactory.createSearchOptions()%>"
                                                                    value="id"
                                                                    label="description"/>
                                    </stripes:select>
                                </td>
                            </tr>
                        </c:if>
                          <c:if test="${actionBean.searchReq.allowSearchByStatus}">
                            <tr class="rowHighLight">
                                <th><stripes:label name="location.status" for="searchReq.locationStatus[0]"/></th>
                                <td>
                                    <c:choose>
                                        <c:when test="${fn:length(actionBean.allowedStatusSearchParameter)==1}">
                                            <c:out value="${actionBean.allowedStatusSearchParameter[0]}"/>
                                            <stripes:hidden name="searchReq.locationStatus[0]" value="${actionBean.allowedStatusSearchParameter[0]}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <stripes:select id="searchReq.locationStatus[0]" name="searchReq.locationStatus[0]">
                                                <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                                <stripes:options-collection collection="${actionBean.allowedStatusSearchParameter}"/>
                                            </stripes:select>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${actionBean.searchReq.allowSearchByLocationSuburb}">
                            <tr class="rowHighLight">
                                <th><stripes:label name="label.suburb" for="searchReq.locationSuburb"/></th>
                                <td><stripes:text name="searchReq.locationSuburb"/></td>
                            </tr>
                        </c:if>
                        <c:if test="${actionBean.searchReq.allowSearchByLocationState}">
                            <tr class="rowHighLight">
                                <th><stripes:label name="label.state" for="searchReq.locationState"/></th>
                                <td>
                                    <stripes:select name="searchReq.locationState">
                                        <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                        <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.State"/>
                                    </stripes:select>
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                    
                    <table class="form searchParameters">
                        <caption>Dealer Details</caption>
                        <tbody>
                        <c:if test="${actionBean.searchReq.allowSearchByDealerName}">
                            <tr class="rowHighLight">
                                    <th><stripes:label name="dealer.generalInfo.dealerName" for="searchReq.dealerName"/></th>
                                    <td>
                                        <div class="yui-ac">
                                            <stripes:text id="searchReq.dealerName" name="searchReq.dealerName" class="yui-ac-input"/>
                                            <div id="dealerNameSearchResultContainer"></div>
                                        </div>
                                    </td>
                            </tr>
                        </c:if>

                        <c:if test="${actionBean.searchReq.allowSearchByDealerCode}">
                            <tr class="rowHighLight">
                                <th><stripes:label name="dealer.generalInfo.dealerCode" for="searchReq.dealerCode"/></th>
                                <td>
                                    <div class="yui-ac">
                                        <stripes:text id="searchReq.dealerCode" name="searchReq.dealerCode" class="yui-ac-input"/>
                                        <div id="dealerCodeSearchResultContainer"></div>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                         <c:if test="${actionBean.searchReq.allowSearchByStatus}">
                            <tr class="rowHighLight">
                                <th><stripes:label name="dealer.generalInfo.status" for="searchReq.dealerStatus[0]"/></th>
                                <td>
                                    <c:choose>
                                        <c:when test="${fn:length(actionBean.allowedStatusSearchParameter)==1}">
                                            <c:out value="${actionBean.allowedStatusSearchParameter[0]}"/>
                                            <stripes:hidden name="searchReq.locationStatus[0]" value="${actionBean.allowedStatusSearchParameter[0]}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <stripes:select id="searchReq.dealerStatus[0]" name="searchReq.dealerStatus[0]">
                                                <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                                <stripes:options-collection collection="${actionBean.allowedStatusSearchParameter}"/>
                                            </stripes:select>                                            
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:if>
                        <%--  Search by region parameters --------%>
                       <c:set var="restrictRegionForUser" value="false"/>
                       <c:if test="${actionBean.usersRegion != null && actionBean.searchReq.searchForEdit}">
                           <c:set var="restrictRegionForUser" value="true"/>
                       </c:if>
                       <c:choose>
                           <c:when test="${restrictRegionForUser == 'true'}">
                               <stripes:hidden name="searchReq.dealerRegion" value="${actionBean.usersRegion}"/>
                           </c:when>
                           <c:otherwise>
                               <c:if test="${actionBean.searchReq.allowSearchByDealerRegion}">
                                    <tr class="rowHighLight">
                                       <th><stripes:label name="dealer.generalInfo.region" for="searchReq.dealerRegion"/></th>
                                       <td>
                                           <stripes:select id="searchReq.dealerRegion" name="searchReq.dealerRegion">
                                               <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                               <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.Region"/>
                                            </stripes:select>
                                       </td>
                                    </tr>
                               </c:if>
                           </c:otherwise>
                       </c:choose>

                        <c:if test="${actionBean.searchReq.allowSearchByPMA}">
                            <tr class="rowHighLight">
                                <th><stripes:label name="pma.name" for="searchReq.dealerPMA"/></th>
                                <td>
                                    <stripes:select id="searchReq.dealerPMA" name="searchReq.dealerPMA">
                                        <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                        <stripes:options-collection collection="${actionBean.allPMA}" label="name" value="pmaId"/>
                                    </stripes:select>
                                </td>
                             </tr>
                        </c:if>

                       <c:if test="${actionBean.searchReq.allowSearchByMetroFlag}">
                            <tr class="rowHighLight">
                                 <th><stripes:label name="dealer.generalInfo.metroFlag" for="searchReq.metroFlag"/></th>
                                 <td>
                                     <stripes:select name="searchReq.metroFlag" id="searchReq.metroFlag">
                                         <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                         <stripes:option value="true"><fmt:message key="label.metro"/></stripes:option>
                                         <stripes:option value="false"><fmt:message key="label.rural"/></stripes:option>
                                     </stripes:select>
                                 </td>
                             </tr>
                        </c:if>
                        <c:if test="${actionBean.searchReq.allowSearchByProduct}">
                            <tr class="rowHighLight">
                               <th><stripes:label name="dealer.otherProducts" for="searchReq.product"/></th>
                                <td>
                                    <stripes:select name="searchReq.product">
                                        <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                        <stripes:options-collection collection="${actionBean.allOtherProduct}" label="value" value="commonValueId"/>
                                    </stripes:select>
                                </td>
                            </tr>
                        </c:if>

                            <%--  Search by franchise parameters --------%>
                        <c:set var="restrictFranchiseForUser" value="false"/>
                        <c:set var="lexusFranchiseValue" value="<%= au.com.toyota.nc.common.model.hibernate.ToyotaFranchise.Lexus %>"/>
                        <c:if test="${ (lexusFranchiseValue == actionBean.context.franchise) && actionBean.searchReq.searchForEdit }">
                            <c:set var="restrictFranchiseForUser" value="true"/>
                        </c:if>
                        <c:choose>
                            <c:when test="${restrictFranchiseForUser == 'true'}">
                                <stripes:hidden name="searchReq.franchise" value="${actionBean.context.franchise}"/>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${actionBean.searchReq.allowSearchByDealerRegion}">
                                        <tr class="rowHighLight">
                                            <th><stripes:label name="label.franchise" for="searchReq.franchise"/></th>
                                            <td>
                                                <stripes:select name="searchReq.franchise">
                                                    <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_franchiseOptions.jsp" selectedValue="${actionBean.searchReq.franchise}"/>
                                                </stripes:select>
                                            </td>
                                        </tr>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                       </tbody>
                    </table>

                    <c:if test="${actionBean.searchReq.allowSearchByWeight}">
                    <table class="form searchParameters">
                        <caption>Weight Details</caption>
                        <c:set var="toyotaWeightGroups" value="${actionBean.toyotaWeightGroup}"/>
                        <c:set var="lexusWeightGroups" value="${actionBean.lexusWeightGroup}"/>

                        <c:set var="allToyotaWeightGroupValues" value="${actionBean.allToyotaWeightGroupValues}" scope="page"/>
                        <c:forEach items="${toyotaWeightGroups}" var="weightGroupType" varStatus="i">
                            <tr class="rowHighLight">
                                <th>
                                    <label for="searchReq.weights[${i.index}].value">
                                    ${weightGroupType.description}
                                    </label>
                                </th>
                                <td>
                                    <stripes:hidden name="searchReq.weights[${i.index}].type" value="${weightGroupType}"/>
                                    <stripes:select name="searchReq.weights[${i.index}].value">
                                        <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                        <stripes:options-collection collection="${allToyotaWeightGroupValues}" label="value" value="commonValueId"/>
                                    </stripes:select>
                                </td>
                            </tr>
                        </c:forEach>

                        <%-- Set initial index of lexus weight group to be the last index of the toyota weight group, and continue from there on --%>
                        <c:set var="lexusWeightGroupNewIndex" value="${fn:length(toyotaWeightGroups)}"/>
                        <c:set var="allLexusWeightGroupValues" value="${actionBean.allLexusWeightGroupValues}" scope="page"/>
                        <c:forEach items="${lexusWeightGroups}" var="weightGroupType" varStatus="i">
                            <tr class="rowHighLight">
                               <th>
                                   <label for="searchReq.weights[${lexusWeightGroupNewIndex}].value">
                                    ${weightGroupType.description}
                                    </label>
                               </th>
                               <td>
                                   <stripes:hidden name="searchReq.weights[${lexusWeightGroupNewIndex}].type" value="${weightGroupType}"/>
                                    <stripes:select name="searchReq.weights[${lexusWeightGroupNewIndex}].value">
                                        <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                        <stripes:options-collection collection="${allLexusWeightGroupValues}" label="value" value="commonValueId"/>
                                    </stripes:select>
                                    <c:set var="lexusWeightGroupNewIndex" value="${lexusWeightGroupNewIndex + 1}"/>
                               </td>
                             </tr>
                        </c:forEach>
                     </table>
                    </c:if>

                    <div class="clear">&nbsp;</div>
                    <div class="formActionButtons">
                        <stripes:submit name="searchDealer" id="performSearch" class="btn btn_search" value="Search"/>
                        <stripes:reset name="reset" id="resetForm" class="btn btn_reset" value="Reset"/>
                        <div class="clear"></div>
                    </div>
                    <div class="clear">&nbsp;</div>
                
                </stripes:form>
            </div>
                <div class="clear"></div>

             </div>
            <div class="clear"></div>
        </div>
    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">
        <script type="text/javascript">
            /**
             * Attach behaviours after DOM is built
             */
             function yuiLoadComplete(){
                 YAHOO.util.Event.onDOMReady(function(){
                     attachDealerNameSearchAutoCompleteBehaviour();
                     attachLocationNameSearchAutoCompleteBehaviour();
                 });
             }

            function attachDealerNameSearchAutoCompleteBehaviour(){
                   // Attach dealer name search
                     YAHOO.log("Attach dealer name search behaviour","info");

                    <stripes:url beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.SearchDealerLocationActionBean" event="searchDealerName" var="searchURL"/>
                     var oDS = new YAHOO.util.XHRDataSource("${searchURL}");
                     oDS.responseType = YAHOO.util.XHRDataSource.TYPE_JSON;
                     oDS.responseSchema= {
                        resultsList :  "Result",
                         fields: ["dealerName"]
                     };
                     var oAC = new YAHOO.widget.AutoComplete("searchReq.dealerName","dealerNameSearchResultContainer",oDS);
                     oAC.queryDelay= .5;
                     oAC.generateRequest = function(sQuery){
                        return "&request.dealerName="+$("#searchReq\\.dealerName").val()+"&showAsReadOnly=<c:out value="${actionBean.searchReq.searchForEdit eq false}"/>";
                     };
            }

            /**
             * Attach location name search auto complete behaviour
             */
            function attachLocationNameSearchAutoCompleteBehaviour(){
                // attach location name search
                YAHOO.log("Attach location name search behaviour","info");

                <stripes:url beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.SearchDealerLocationActionBean" event="searchLocationName" var="searchURL"/>
                var oDS = new YAHOO.util.XHRDataSource("${searchURL}");
                oDS.responseType = YAHOO.util.XHRDataSource.TYPE_JSON;
                oDS.responseSchema= {
                    resultsList : "Result",
                    fields: ["locationName"]
                };
                var oAC = new YAHOO.widget.AutoComplete("searchReq.locationName","locationNameSearchResultContainer",oDS);
                oAC.queryDelay= .5;
                oAC.generateRequest = function(sQuery){
                    var dealerName=$("#searchReq\\.dealerName").val();
                    var locationName=$("#searchReq\\.locationName").val();
                    var url = "&showAsReadOnly=<c:out value="${actionBean.searchReq.searchForEdit eq false}"/>";
                    if (dealerName != ""){
                        url += "&request.dealerName=" + dealerName;
                    }
                    if (locationName!=""){
                        url += "&request.locationName="+locationName;
                    }
                    return url;
                };
            }


        </script>
    </stripes:layout-component>

 <stripes:layout-component name="yui-init-dependencies">
            loader.require("datasource", "autocomplete", "animation", "connection");
    </stripes:layout-component>

</stripes:layout-render>
