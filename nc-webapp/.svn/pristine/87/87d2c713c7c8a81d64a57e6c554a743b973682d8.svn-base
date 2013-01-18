<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css"
              href="${pageContext.request.contextPath}/css/wib/dealerLocation/nc-dealership.css"/>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/nc-ajax.js"></script>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <div class="pageContent_main_header">
            <h1>Search For Dealership</h1>
        </div>


        <div id="searchDealerPage" class="pageContent_wrapper">
            <!-- for selenium tests: search dealer result page -->
            <c:import url="/WEB-INF/jsp/messages.jsp"/>
            
            <div id="searchFormLayoutSection" class="mainContent_wrapper">
                <div id="searchResultLayoutSection">

                    <div id="messageBox" class="messageBox infoMessage searchResultMessage">
                         <ul>
                             <li><c:out value="${actionBean.searchReqForRendering}"/></li>
                         </ul>
                     </div>

                    <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" method="post">
                     <c:import url="/WEB-INF/jsp/nc/dealer/_exportHiddenFields.jsp"/>
                    <div id="dealerDataTableSection">
                        <table id="dealerTable" width="100%">
                                <thead>
                                    <tr>
                                        <c:if test="${actionBean.searchReq.searchForEdit eq true}">
                                             <%-- only display the select box  when in edit mode --%>
                                            <th><fmt:message key="label.select"/> </th>
                                        </c:if>
                                        <th><fmt:message key="dealer.dealerId"/></th>
                                        <th><fmt:message key="location.locationId"/> </th>
                                        <th><fmt:message key="code.dealer"/></th>
                                        <th><fmt:message key="dealer.generalInfo.dealerName"/></th>
                                        <th><fmt:message key="location.locationName"/></th>
                                        <th><fmt:message key="label.location"/> <fmt:message key="label.suburb"/></th>
                                        <th><fmt:message key="label.location"/> <fmt:message key="label.state"/></th>
                                        <th><fmt:message key="dealer.generalInfo.region"/></th>
                                        <th><fmt:message key="location.type"/></th>
                                        <th><fmt:message key="label.location"/> <fmt:message key="label.phone"/></th>
                                        <th><fmt:message key="label.location"/> <fmt:message key="label.shortDial"/></th>
                                        <th><fmt:message key="code.dealer.sap"/></th>
                                        <th><fmt:message key="dealer.generalInfo.status"/></th>
                                        <th><fmt:message key="dealer.generalInfo.metroFlag"/></th>
                                        <th><fmt:message key="dealer.generalInfo.mainFranchise"/></th>
                                        <th><fmt:message key="pma.name"/></th>
                                    </tr>
                                </thead>
                                 <tbody>
                                     <c:forEach items="${actionBean.searchLocations}" var="location">
                                        <tr>
                                            <c:if test="${actionBean.searchReq.searchForEdit eq true}">
                                                <%-- only display the select box  when in edit mode --%>
                                                <td></td>
                                            </c:if>
                                            <td>${location.dealer.dealerId}</td>
                                            <td>${location.locationId}</td>
                                            <td>${location.dealer.generalInfo.dealerCode}</td>
                                            <td>${location.dealer.generalInfo.dealerName}</td>
                                            <td>${location.locationName}</td>
                                            <td>${location.contact.streetAddress.suburb}</td>
                                            <td>${location.contact.streetAddress.state}</td>
                                            <td>${location.dealer.generalInfo.region}</td>
                                            <td>${location.type.description}</td>
                                            <td>${location.contact.phone }</td>
                                            <td>${location.contact.shortDial}</td>
                                            <td>${location.dealer.generalInfo.sapDealerCode}</td>
                                            <td>${location.dealer.generalInfo.status}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${location.dealer.generalInfo.metroFlag ne null && location.dealer.generalInfo.metroFlag eq true}">
                                                        Metro
                                                    </c:when>
                                                    <c:otherwise>
                                                        Rural
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${location.dealer.generalInfo.mainFranchise}</td>
                                            <td>${location.dealer.generalInfo.pma.name}</td>
                                        </tr>
                                     </c:forEach>
                                 </tbody>
                        </table>
                    </div>
                     <c:if test="${fn:length(actionBean.searchLocations)>0 && actionBean.searchReq.searchForEdit eq true}">
                         <%-- only display bulk update button on edit mode, and if there's any result returned --%>
                         <div class="bulkUpdateResultOption">
                            <stripes:submit name="selectDealersForBulkUpdate" id="selectDealerForBulkUpdateButton" class="btn btn_editSelected"><fmt:message key="label.edit.selected"/></stripes:submit>
                        </div>
                    </c:if>
                    </stripes:form>

                    <%-- Dont display 'export' when displaying search result for edit --%>
                    <c:if test="${actionBean.searchReq.searchForEdit eq false}">
                        <div class="searchResultOptions">
                                 <ul class="horizontalMenu">
                                     <li>
                                         <stripes:form id="saveSearchForm" beanclass="au.com.toyota.nc.webapp.stripes.savedsearch.SaveSearchActionBean" method="POST">
                                        <jsp:include page="/WEB-INF/jsp/nc/dealer/_exportHiddenFields.jsp"/>
                                        <input type="button" id="saveSearchButton" class="btn btn_saveSearch" value="<fmt:message key="label.search.save"/>" onclick="openSaveSearchDialog('showLocationSaveSearchLabel');"/>
                                    </stripes:form>
                                     </li>
                                     <li>
                                         <stripes:form action="/reports/LocationSearchResultsReport-Full.xls" method="post" target="_blank">
                                        <jsp:include page="/WEB-INF/jsp/nc/dealer/_exportHiddenFields.jsp"/>
                                        <stripes:submit name="export" class="btn btn_export" id="exportSearchResultsButton"><fmt:message key="label.search.exportfull"/></stripes:submit>
                                    </stripes:form>
                                     </li>
                                     <li>
                                         <stripes:form action="/reports/LocationSearchResultsReport-MailMerge.xls" method="post" target="_blank">
                                        <jsp:include page="/WEB-INF/jsp/nc/dealer/_exportHiddenFields.jsp"/>
                                        <stripes:submit name="export" class="btn btn_export_mailMerge" id="exportSearchResultsButtonMailMerge"><fmt:message key="label.export.mailmerge"/></stripes:submit>
                                    </stripes:form>
                                     </li>
                                     <li>
                                         <stripes:form id="mailingLabelForm" beanclass="au.com.toyota.nc.webapp.stripes.reports.MailingLabelLocationReportActionBean" method="post">
                                            <jsp:include page="/WEB-INF/jsp/nc/dealer/_exportHiddenFields.jsp"/>
                                            <input type="button" class="btn btn_mailingLabel" id="createMailingLabelButton" value="Create mailing labels" onclick="openMailingLabelDialog();"/>
                                        </stripes:form>
                                     </li>
                                 </ul>
                        </div>
                        <div class="clear"></div>
                    </c:if>
                </div>

                <%-- Dont display 'save search' and 'mailing label' when displaying search result for edit --%>
                <c:if test="${actionBean.searchReq.searchForEdit eq false}">
                    <div id="saveSearchDialog" class="dialog dialogWithDefaultCloseButton">
                        <div class="bd" id="saveSearchDialogBody">&nbsp;</div>
                    </div>
                    <div id="mailingLabelDialog" class="dialog dialogWithDefaultCloseButton">
                        <div class="bd" id="mailingLabelDialogBody">&nbsp;</div>
                    </div>
                </c:if>

                 <div class="clear"></div>
            </div>
        </div>
    </stripes:layout-component>

     <stripes:layout-component name="yui-init-dependencies">
            loader.require("datatable", "connection", "paginator", "menu");
    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">

        <%-- Dont display 'save search' and 'mailing label' when displaying search result for edit --%>
        <c:if test="${actionBean.searchReq.searchForEdit eq false}">
            <jsp:include page="/WEB-INF/jsp/nc/savedsearch/_savedSearchPopupJs.jsp"/>
            <jsp:include page="/WEB-INF/jsp/nc/savedsearch/_mailingLabelPopupJs.jsp">
                <jsp:param name="mailingLabelBeanClass" value="au.com.toyota.nc.webapp.stripes.reports.MailingLabelLocationReportActionBean"/>
            </jsp:include>
        </c:if>

        <script type="text/javascript">
                function initializeDealerSearchResultTable(){
                            YAHOO.log("Constructing dealer result table","info");
                            var dealerLinkFormatter=function(eCell, eRecord, oColumn, oData){
                                    <c:if test="${actionBean.searchReq.searchForEdit eq true}">
                                    <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" event="editDealer" scope="page"/>
                                    </c:if>
                                    <c:if test="${actionBean.searchReq.searchForEdit eq false}">
                                    <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" event="viewDealer" scope="page"/>
                                    </c:if>
                                        var url = '${url}&<%=ManageDealerLocationActionBean.REQUEST_PARAM_DEALER_ID%>='+eRecord.getData("dealerID");
                                        eCell.innerHTML='<a class="editDealerNameLink" id="editDealerLink-'+eRecord.getData("dealerID")+'" href="'+url+'">'+eRecord.getData("dealerName")+'</a>';
                            };
                            var locationLinkFormatter=function(eCell, eRecord, oColumn, oData){
                                    <c:if test="${actionBean.searchReq.searchForEdit eq true}">
                                        <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean" event="editLocation" scope="page"/>
                                    </c:if>
                                    <c:if test="${actionBean.searchReq.searchForEdit eq false}">
                                        <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean" event="viewLocation" scope="page"/>
                                    </c:if>
                                    if (eRecord.getData("locationName")!=""){
                                        var url = '${url}&<%=ManageLocationActionBean.REQUEST_PARAM_LOCATION_ID%>='+eRecord.getData("locationID");
                                        eCell.innerHTML='<a id="editLocationLink-'+eRecord.getData("locationID")+'" href="'+url+'">'+eRecord.getData("locationName")+'</a>';
                                    }
                            };
                            <c:if test="${actionBean.searchReq.searchForEdit eq true}">
                                <%-- only display the select box  when in edit mode --%>
                                var dealerSelectorFormatter=function(eCell, eRecord, oColumn, oData){
                                    eCell.innerHTML='<input type="checkbox" id="select-dealer-'+  eRecord.getData("dealerID")  +'" name="<%=ManageDealerLocationActionBean.PROP_DEALERIDS_FOR_BULK_UPDATE%>" value="'+ eRecord.getData("dealerID")+'"/>';
                                };
                            </c:if>



                            YAHOO.log("Constructing dealer data table column definition","info");
                            var dealerDataTableColumnDef = [
                                <c:if test="${actionBean.searchReq.searchForEdit eq true}">
                                    <%-- only display the select box  when in edit mode --%>
                                    {key:"select",label:"Select",formatter:dealerSelectorFormatter, className:"select", maxAutoWidth:30},
                                </c:if>
                                {key:"dealerID", label:"Dealer ID",sortable:true, resizable:false, className:"dealerID"},
                                {key:"locationID", label:"Location ID",sortable:true, resizable:false, className:"locationID"},
                                <c:if test="${actionBean.searchReq.searchForEdit eq false}">
                                    {key:"dealerCode", label:"Dealer Code", sortable:true, resizable:false, className:"dealerCode", maxAutoWidth:40},
                                </c:if>
                                {key:"dealerName", label:"Dealer Name", sortable:true, resizable:false, formatter: dealerLinkFormatter, className:"dealerName", minWidth:150, maxAutoWidth:150},
                                {key:"locationName", label:"Location Name", sortable:true, resizable:false, formatter:locationLinkFormatter,className:"locationName", minWidth:150, maxAutoWidth:150},
                                {key:"suburb", label:"Suburb", sortable:true, resizable:false, className:"locationSuburb", minWidth:95, maxAutoWidth:95},
                                <c:if test="${actionBean.searchReq.searchForEdit eq false}">
                                   {key:"state", label:"State", sortable:true, resizable:false, className:"locationState", maxAutoWidth:25},
                                </c:if>
                                <c:if test="${actionBean.searchReq.searchForEdit eq false}">
                                    {key:"telephone", label:"Telephone", sortable:true, resizable:false, className:"telephone", maxAutoWidth:65},
                                </c:if>
                                <c:if test="${actionBean.searchReq.searchForEdit eq false}">
                                    {key:"shortDial", label:"Short Dial", sortable:true, resizable:false, className:"shortDial", maxAutoWidth:30},
                                </c:if>
                                {key:"locationType", label:"Location Type", sortable:true, resizable:false, className:"locationType", maxAutoWidth:60},
                                {key:"region", label:"Region", sortable:true, resizable:false, className:"region", maxAutoWidth:50},
                                <c:if test="${actionBean.searchReq.searchForEdit eq false}">
                                    {key:"sapDealerCode", label:"SAP Dealer Code", sortable:true, resizable:false, className:"sapDealerCode", maxAutoWidth:33},
                                </c:if>
                                <c:if test="${actionBean.searchReq.searchForEdit eq true}">
                                    {key:"dealerStatus", label:"Dealer Status", sortable:true, resizable:false, className:"dealerStatus", maxAutoWidth:40},
                                </c:if>
                                <c:if test="${actionBean.searchReq.searchForEdit eq true}">
                                    {key:"metroFlag", label:"Metro / Rural", sortable:true, resizable:false, className:"metroFlag", maxAutoWidth:50},
                                </c:if>
                                <c:if test="${actionBean.searchReq.searchForEdit eq true}">
                                    {key:"mainFranchise", label:"Franchise", sortable:true, resizable:false, className:"mainFranchise", maxAutoWidth:50},
                                </c:if>
                                {key:"pma", label:"PMA", sortable:true, resizable:false, className:"pma"}
                            ];


                            YAHOO.log("Constructing dealer data table data source: YAHOO.util.DataSource","info");
                            this.dealerSearchDataSource = new YAHOO.util.DataSource(YAHOO.util.Dom.get("dealerTable"));
                            this.dealerSearchDataSource.responseType = YAHOO.util.DataSource.TYPE_HTMLTABLE;
                            this.dealerSearchDataSource.responseSchema = {
                                fields:[
                                    <c:if test="${actionBean.searchReq.searchForEdit eq true}">
                                        {key:"select"},
                                     </c:if>
                                    {key:"dealerID"},
                                    {key:"locationID"},
                                    {key:"dealerCode"},
                                    {key:"dealerName"},
                                    {key:"locationName"},
                                    {key:"suburb"},
                                    {key:"state"},
                                    {key:"region"},
                                    {key:"locationType"},
                                    {key:"telephone"},
                                    {key:"shortDial"},
                                    {key:"sapDealerCode"},
                                    {key:"dealerStatus"},
                                    {key:"metroFlag"},
                                    {key:"mainFranchise"},
                                    {key:"pma"}
                                ]
                            };

                            YAHOO.log("Constructing dealer data table configuration: YAHOO.widget.Paginato","info");
                            var oConfigs = {
                                height:"30em",
                                width:"950px"
                                <%-- Dont paginate when displaying search result for editing --%>
                                <c:if test="${actionBean.searchReq.searchForEdit eq false}">
                                    , paginator: new YAHOO.widget.Paginator({
                                        rowsPerPage: 50
                                    })
                                </c:if>
                            };
                             YAHOO.log("Constructing dealer data table: YAHOO.widget.ScrollingDataTable","info");
                            this.dealerDataTable = new YAHOO.widget.ScrollingDataTable("dealerDataTableSection", dealerDataTableColumnDef, this.dealerSearchDataSource, oConfigs);
                }
          var the_table = 'nil';
                
          function yuiStyleHack_remove_class() {
              //                    //Hack to force static posistion
                   the_table = YAHOO.util.Dom.getElementsByClassName("yui-dt-hd")[0];
                   YAHOO.util.Dom.removeClass(the_table, 'yui-dt-hd');

               setTimeout('yuiStyleHack_add_class();', 200);
          }
                
         function yuiStyleHack_add_class() {
             YAHOO.util.Dom.addClass(the_table, 'yui-dt-hd-override');
         }


          function yuiLoadComplete(){
              // Save search initialisation & handling

               YAHOO.util.Event.onDOMReady(function(){
                    initializeDealerSearchResultTable();

                     setTimeout('yuiStyleHack_remove_class();', 200);

                    <%-- Dont display 'save search' and 'mailing label' when displaying search result for edit --%>
                    <c:if test="${actionBean.searchReq.searchForEdit eq false}">
                           YAHOO.au.com.toyota.widget.SaveSearchDialog = new YAHOO.widget.Dialog("saveSearchDialog",
                           {
                               width: "30em",
                               fixedcenter:true,
                               visible:false,
                               constraintoviewport : true
                           });
                           YAHOO.au.com.toyota.widget.SaveSearchDialog.render();

                           YAHOO.au.com.toyota.widget.MailingLabelDialog = new YAHOO.widget.Dialog("mailingLabelDialog",
                           {
                               width: "30em",
                               fixedcenter:true,
                               visible:false,
                               constraintoviewport : true
                           });
                           YAHOO.au.com.toyota.widget.MailingLabelDialog.render();
                   </c:if>
               });
          }
        </script>


    </stripes:layout-component>


</stripes:layout-render>
