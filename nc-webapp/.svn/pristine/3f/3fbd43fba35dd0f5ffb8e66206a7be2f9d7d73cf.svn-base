<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/nc-dealerinfo-layout.css"/>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/nc-ajax.js"></script>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <nc:pageName pageName="ViewDealerStaff-SearchResult"/>
        <div class="pageContent_main_header">
            <h1>Search Dealer Staff</h1>
         </div>


        <div id="searchDealerStaffPage" class="pageContent_wrapper">
            <!-- for selenium tests: searches dealer staff results for view page -->
                <div id="searchFormLayoutSection" class="mainContent_wrapper">
                    <div id="searchResultLayoutSection">

                        <div id="messageBox" class="messageBox infoMessage searchResultMessage">
                             <ul>
                                     <li><nc:requestDecorator/></li>
                             </ul>
                        </div>

                       <div>${fn:length(actionBean.searchRsp.staffByDealers)} records matched your query </div>

                        
                        <stripes:form id="dealerStaffResultForm" beanclass="au.com.toyota.nc.webapp.stripes.staff.DealerStaffSearchActionBean" method="post">
                            <div id="dealerStaffDataTableSection">
                                <table id="resultTable" width="100%">
                                    <thead>
                                        <tr>
                                            <th>Dealer Staff No</th>
                                            <th>First name</th>
                                            <th>Last name</th>
                                            <th>Dealership</th>
                                            <th>Suburb</th>
                                            <th>State</th>
                                            <th>Primary Location</th>
                                            <th>Primary Position</th>
                                            <th>Telephone</th>
                                            <th>Dealer Code</th>
                                            <th>Department</th>
                                            <th>Email Address</th>
                                            <th class="hide">Eligible</th>
                                            <th class="hide">DealerName</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${actionBean.searchRsp.staffByDealers}" var="staffByDealer">
                                                <tr>
                                                    <td>${staffByDealer.personId}</td>
                                                    <td>${staffByDealer.firstname}</td>
                                                    <td>${staffByDealer.surname}</td>
                                                    <td>
                                                        <c:set var="dealerDrillDownValue" value="${staffByDealer.dealerName}"/>
                                                        <nc:ifAccessAllowed name="dealerStaff.search.result.drillDowns">
                                                            <c:set var="dealerDrillDownValue">
                                                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean"
                                                                              event="viewDealer"
                                                                              target="_blank">
                                                                    <stripes:param name="dealer.dealerId" value="${staffByDealer.dealerID}"/>
                                                                    ${staffByDealer.dealerName}
                                                                </stripes:link>
                                                            </c:set>
                                                        </nc:ifAccessAllowed>
                                                        <c:out value="${dealerDrillDownValue}" escapeXml="false"/>
                                                    </td>
                                                    <td>${staffByDealer.dealerSuburb}</td>
                                                    <th>${staffByDealer.state}</th>
                                                    <td>${staffByDealer.primaryLocationName}</td>
                                                    <td>${staffByDealer.primaryPositionDesc}</td>
                                                    <th>${staffByDealer.phone}</th>
                                                    <th>${staffByDealer.dealerCode}</th>
                                                    <th>${staffByDealer.departmentNames}</th>
                                                    <th>${staffByDealer.emailAddress}</th>
                                                    <th class="hide">${staffByDealer.eligible}</th>
                                                    <th class="hide">${staffByDealer.dealerName}</th>
                                                </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <c:if test="${fn:length(actionBean.searchRsp.staffByDealers) == 0}">
                                    <fmt:message  key="no.entities"/>
                                </c:if>
                            </div>
                        </stripes:form>

                        <div class="searchResultOptions">
                            <ul class="horizontalMenu">
                                <li>
                                    <stripes:form id="saveSearchForm" beanclass="au.com.toyota.nc.webapp.stripes.savedsearch.SaveSearchActionBean" method="post">
                                        <jsp:include page="/WEB-INF/jsp/nc/staff/_exportHiddenFields.jsp"/>
                                        <input id="saveSearchButton" class="btn btn_saveSearch" type="button" value="<fmt:message key="staff.search.savesearch"/>" onclick="openSaveSearchDialog('showStaffSaveSearchLabel');"/>
                                    </stripes:form>
                                </li>
                                <li>
                                     <stripes:form action="/reports/StaffSearchResultsReport-Full.xls" method="post" target="_blank">
                                         <jsp:include page="/WEB-INF/jsp/nc/staff/_exportHiddenFields.jsp"/>
                                          <stripes:submit name="export" class="btn btn_export" id="exportSearchResultsButton"><fmt:message key="staff.search.export.full"/></stripes:submit>
                                     </stripes:form>
                                </li>
                                <li>
                                    <stripes:form action="/reports/StaffSearchResultsReport-MailMerge.xls" method="post" target="_blank">
                                         <jsp:include page="/WEB-INF/jsp/nc/staff/_exportHiddenFields.jsp"/>
                                         <stripes:submit name="export" class="btn btn_export_mailMerge" id="exportSearchResultsButtonMailMerge"><fmt:message key="staff.search.export.mailmerge"/></stripes:submit>
                                    </stripes:form>
                                </li>
                                <li>
                                    <stripes:form id="mailingLabelForm" beanclass="au.com.toyota.nc.webapp.stripes.reports.MailingLabelAppointmentReportActionBean" method="post">
                                        <jsp:include page="/WEB-INF/jsp/nc/staff/_exportHiddenFields.jsp"/>
                                        <input id="createMailingLabelButton" type="button" class="btn btn_mailingLabel" value="Create mailing labels" onclick="openMailingLabelDialog();"/>
                                    </stripes:form>
                                </li>
                            </ul>
                        </div>
                        <div class="clear"></div>
                    </div>

                    <div id="saveSearchDialog" class="dialog dialogWithDefaultCloseButton">
                        <div class="bd" id="saveSearchDialogBody">&nbsp;</div>
                    </div>
                    <div id="mailingLabelDialog" class="dialog dialogWithDefaultCloseButton">
                        <div class="bd" id="mailingLabelDialogBody">&nbsp;</div>
                    </div>
                    <div class="clear"></div>
                </div>
            <div class="clear"></div>
        </div>
</stripes:layout-component>

<stripes:layout-component name="yui-init-dependencies">
        loader.require("datatable", "connection", "paginator", "menu");
</stripes:layout-component>

<stripes:layout-component name="init-event-handling">
    <jsp:include page="/WEB-INF/jsp/nc/savedsearch/_savedSearchPopupJs.jsp"/>
    <jsp:include page="/WEB-INF/jsp/nc/savedsearch/_mailingLabelPopupJs.jsp">
        <jsp:param name="mailingLabelBeanClass" value="au.com.toyota.nc.webapp.stripes.reports.MailingLabelAppointmentReportActionBean"/>
    </jsp:include>

    <script type="text/javascript">
        function initializeDealerStaffSearchResultTable(){
            YAHOO.log("Constructing staff data table column definition","info");

            <%-- Starts formatters here--%>
            var staffIDLinkFormatter =function(eCell, eRecord, oColumn, oData){
                var staffId = eRecord.getData("staffId");
                eCell.innerHTML = staffId;
                <nc:ifAccessAllowed name="dealerStaff.search.result.drillDowns">
                    <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffActionBean" event="edit" scope="page"/>
                     var url = '<a id="editDealerStaffLink-'+eRecord.getData("staffId")+'" href="'+'${url}&readOnly=true&dealerStaff.personId='+eRecord.getData("staffId") + '&eligible='+eRecord.getData("eligible");
                    eCell.innerHTML=url+'">'+staffId+'</a>';
                </nc:ifAccessAllowed>
            };

            var firstNameLinkFormatter =function(eCell, eRecord, oColumn, oData){
                var firstName = eRecord.getData("fname");
                eCell.innerHTML = '<span class="dealer_staff_search_results_firstname">' + firstName +'</span>';
                <nc:ifAccessAllowed name="dealerStaff.search.result.drillDowns">
                    <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffActionBean" event="edit" scope="page"/>
                     var url = '<a id="editDealerStaffFirstNameLink-'+eRecord.getData("staffId")+'" href="'+'${url}&readOnly=true&dealerStaff.personId='+eRecord.getData("staffId")+ '&eligible='+eRecord.getData("eligible");
                    eCell.innerHTML=url+'">'+ '<span class="dealer_staff_search_results_firstname">' + firstName + '</span>' + '</a>';
                </nc:ifAccessAllowed>
            };

            var lastNameLinkFormatter =function(eCell, eRecord, oColumn, oData){
                var lastName = eRecord.getData("lname");
                eCell.innerHTML = '<span class="dealer_staff_search_results_lastname">' + lastName +'</span>';
                <nc:ifAccessAllowed name="dealerStaff.search.result.drillDowns">
                    <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffActionBean" event="edit" scope="page"/>
                     var url = '<a id="editDealerStaffSurNameLink-'+eRecord.getData("staffId")+'" href="'+'${url}&readOnly=true&dealerStaff.personId='+eRecord.getData("staffId")+ '&eligible='+eRecord.getData("eligible");
                    eCell.innerHTML=url+'">' + '<span class="dealer_staff_search_results_lastname">' + lastName + '</span>' + '</a>';
                </nc:ifAccessAllowed>
            };

            var shareholdingSelectLinkFormatter=function(eCell, eRecord, oColumn, oData){
                <c:if test="${actionBean.returnTo=='Individual'}">
                    <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageIndividualEntityActionBean" event="selectedIndividual" scope="page"/>
                     var url = '<a id="selectIndividualLink-'+eRecord.getData("staffid")+'" href="'+'${url};
                </c:if>
                eCell.innerHTML=url+'">'+eRecord.getData("rowSelect")+'</a>';
            };

            var dealerStaffDataTableColumnDef = [
                {key:"staffId", label:"Dealer Staff No",sortable:true, hidden:true, resizable:true, className:"name", formatter: staffIDLinkFormatter},
                {key:"fname", label:"First name",sortable:true, hidden:true, resizable:true, className:"name", formatter: firstNameLinkFormatter},
                {key:"lname", label:"Last name",sortable:true, hidden:true, resizable:true, className:"type", formatter: lastNameLinkFormatter},
                {key:"dealership", label:"Dealership", sortable:true, hidden:true, resizable:true, className:"edit", sortOptions: {field: "dealerName"}},
                {key:"suburb", label:"Suburb", sortable:true, hidden:true, resizable:true, className:"edit"},
                {key:"state", label:"State", sortable:true, hidden:true, resizable:true, className:"edit"},
                {key:"primaryloc", label:"Primary Location", sortable:true, hidden:true, resizable:false, className:"edit"},
                {key:"primaryposition", label:"Primary Position", sortable:true, hidden:true, resizable:true, className:"edit"},
                {key:"phone", label:"Telephone", sortable:true, hidden:true, resizable:true, className:"edit"},
                {key:"dealerCode", label:"Dealer Code", sortable:true, hidden:true, resizable:true, className:"edit"},
                {key:"department", label:"Department", sortable:true, hidden:true, resizable:true, className:"edit"},
                {key:"emailAddress", label:"Email Address", sortable:true, hidden:true, resizable:false, className:"edit"},
                {key:"eligible", label:"Eligible", sortable:false, hidden:true, resizable:false, className:"rowSelect"},
                {key:"dealerName", label:"DealerName", sortable:false, hidden:true, resizable:false, className:"rowSelect"}
            ];
        <%-- End formatters here--%>

            YAHOO.log("Constructing o/e data table data source: YAHOO.util.DataSource","info");
            this.awardDataSource = new YAHOO.util.DataSource(YAHOO.util.Dom.get("resultTable"));
            this.awardDataSource.responseType = YAHOO.util.DataSource.TYPE_HTMLTABLE;

                this.awardDataSource.responseSchema = {
                    fields:[
                        {key:"staffId"},
                        {key:"fname"},
                        {key:"lname"},
                        {key:"dealership"},
                        {key:"suburb"},
                        {key:"state"},
                        {key:"primaryloc"},
                        {key:"primaryposition"},
                        {key:"phone"},
                        {key:"dealerCode"},
                        {key:"department"},
                        {key:"emailAddress"},
                        {key:"eligible"},
                        {key:"dealerName"}
                    ]
                };


            YAHOO.log("Constructing o/e data table configuration: YAHOO.widget.Paginato","info");
            var oConfigs = {
                paginator: new YAHOO.widget.Paginator({
                    rowsPerPage: 50
                })
            };
             YAHOO.log("Constructing o/e data table: YAHOO.widget.DataTable","info");

            var staffTable = new YAHOO.widget.DataTable("dealerStaffDataTableSection", dealerStaffDataTableColumnDef, this.awardDataSource, oConfigs);
            var allColumns = staffTable.getColumnSet().keys;

            <nc:ifAccessAllowed name="dealerStaff.search.result.staffId">staffTable.showColumn('staffId');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.fname">staffTable.showColumn('fname');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.lname">staffTable.showColumn('lname');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.dealership">staffTable.showColumn('dealership');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.suburb">staffTable.showColumn('suburb');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.primaryloc">staffTable.showColumn('primaryloc');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.primaryposition">staffTable.showColumn('primaryposition');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.phone">staffTable.showColumn('phone');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.dealerCode">staffTable.showColumn('dealerCode');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.state">staffTable.showColumn('state');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.department">staffTable.showColumn('department');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.emailAddress">staffTable.showColumn('emailAddress');</nc:ifAccessAllowed>
            this.resultTable = staffTable;
        }

        // On document ready, start perform search....
        function yuiLoadComplete(){
            YAHOO.util.Event.onDOMReady(function(){
                initializeDealerStaffSearchResultTable();

                YAHOO.au.com.toyota.widget.SaveSearchDialog = new YAHOO.widget.Dialog("saveSearchDialog",
                {
                    width: "30em",
                    fixedcenter:true,
                    visible:false,
                    constraintoviewport : true
                });
                YAHOO.au.com.toyota.widget.SaveSearchDialog.render();
                YAHOO.util.Event.addListener("saveSearchBtn", "click", YAHOO.au.com.toyota.widget.SaveSearchDialog.show, YAHOO.au.com.toyota.widget.SaveSearchDialog, true);

                YAHOO.au.com.toyota.widget.MailingLabelDialog = new YAHOO.widget.Dialog("mailingLabelDialog",
                {
                    width: "30em",
                    fixedcenter:true,
                    visible:false,
                    constraintoviewport : true
                });
                YAHOO.au.com.toyota.widget.MailingLabelDialog.render();
            });
        }
    </script>
</stripes:layout-component>


</stripes:layout-render>