<%--<%@ page import="au.com.toyota.nc.webapp.adapter.LocationJSONAdapter" %>--%>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/entity/nc-entity.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: ownership entity search results page -->
        <div class="pageContent_main_header">
           <h1 class="head">Manage Ownership Entities and Shareholding Details</h1>
        </div>


        <nc:pageName pageName="MaintainOperatingEntity"/>
        <nc:ifAccessAllowed name="operatingentity.search.result">
            <div id="searchOwnerEntityPage" class="pageContent_wrapper">
            <stripes:form id="ownershipEntityResultForm" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.OwnershipEntitySearchActionBean" method="post">
                <div id="searchFormLayoutSection" class="mainContent_wrapper">
                     <div id="messageBox" class="messageBox infoMessage searchResultMessage">
                         <ul>
                             <li><nc:requestDecorator/></li>
                         </ul>
                     </div>
                    <div class="noOfRecords"> ${fn:length(actionBean.searchRsp.party)} records matched your query </div>
                    <div id="resultTableSection">
                        <%--<c:if test="${fn:length(actionBean.searchRsp.party) > 0}">--%>
                        <table id="resultTable" WIDTH="100%" border="1">
                            <thead>
                                <tr>
                                    <th>id</th>
                                    <th>Name</th>
                                    <th class="partyType">Type</th>
                                    <th class="partyStatus">Status</th>
                                    <th class="rowEdit">Edit</th>
                                    <th class="rowSelect">Select</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${actionBean.searchRsp.party}" var="party">
                                    <tr>
                                        <td>${party.id}</td>
                                        <td>${party.name}</td>
                                        <td>${party.type}</td>
                                        <td>${party.status}</td>
                                        <td><fmt:message  key="menu.search.header.edit"/></td>
                                        <td><fmt:message  key="menu.search.header.select"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <%--</c:if>--%>
                        <c:if test="${fn:length(actionBean.searchRsp.party) == 0}">
                            <fmt:message  key="no.entities"/>
                        </c:if>
                    </div>
                </div>
            </stripes:form>
            </div>
        </nc:ifAccessAllowed>
    </stripes:layout-component>

     <stripes:layout-component name="yui-init-dependencies">
            loader.require("datatable", "connection", "paginator", "menu");
    </stripes:layout-component>

   <stripes:layout-component name="init-event-handling">
       <script type="text/javascript">
           function initializeOwnershipEntitySearchResultTable(){
               YAHOO.log("Constructing o/e result table","info");

               var ownershipEntityViewLinkFormatter=function(eCell, eRecord, oColumn, oData){
                   if (eRecord.getData("type")=="Individual"){
                       <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ViewIndividualEntityActionBean" event="viewIndividual" scope="page"/>
                        var url = '<a id="viewIndividualEntityLink-'+eRecord.getData("id")+'" href="'+'${url}&individual.id='+eRecord.getData("id");
                   }

                   if (eRecord.getData("type")!="Individual"){
                       <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ViewCorporateEntityActionBean" event="viewCompany" scope="page"/>
                       var url = '<a id="viewCompanyEntityLink-'+eRecord.getData("id")+'" href="'+'${url}&company.id='+eRecord.getData("id");
                   }
                   eCell.innerHTML=url+'">'+eRecord.getData("name")+'</a>';
               };

               var shareholdingSelectLinkFormatter=function(eCell, eRecord, oColumn, oData){
                   <c:if test="${actionBean.returnTo=='ownedCompany'}">
                       <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.OwnershipEntitySearchActionBean" event="selectCompanyOwned" scope="page"/>
                        var url = '<a id="selectOwnedCompanyLink-'+eRecord.getData("id")+'" href="'+'${url}&company.id='+eRecord.getData("id");
                   </c:if>

                   <c:if test="${actionBean.returnTo!='ownedCompany'}">
                       if (eRecord.getData("type")=="Individual"){
                           <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.OwnershipEntitySearchActionBean" event="selectIndividualOwner" scope="page"/>
                            var url = '<a id="viewIndividualEntityLink-'+eRecord.getData("id")+'" href="'+'${url}&individual.id='+eRecord.getData("id");
                       }
                       if (eRecord.getData("type")!="Individual"){
                           <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.OwnershipEntitySearchActionBean" event="selectCompanyOwner" scope="page"/>
                            var url = '<a id="selectCompanyLink-'+eRecord.getData("id")+'" href="'+'${url}&company.id='+eRecord.getData("id");
                       }
                   </c:if>
                   eCell.innerHTML=url+'">'+eRecord.getData("rowSelect")+'</a>';
               };

               var ownershipEntityEditLinkFormatter=function(eCell, eRecord, oColumn, oData){
                   if (eRecord.getData("type")=="Individual"){
                       <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageIndividualEntityActionBean" event="editIndividual" scope="page"/>
                        var url = '<a id="editIndividualEntityLink-'+eRecord.getData("id")+'" href="'+'${url}&individual.id='+eRecord.getData("id");
                   }
                   if (eRecord.getData("type")!="Individual"){
                       <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageCorporateEntityActionBean" event="editCompany" scope="page"/>
                           var url = '<a id="editCompanyEntityLink-'+eRecord.getData("id")+'" href="'+'${url}&company.id='+eRecord.getData("id");
                   }
                   eCell.innerHTML=url+'">'+eRecord.getData("edit")+'</a>';
               };

               YAHOO.log("Constructing owner data table column definition","info");

               <%--<c:if test="${actionBean.returnTo!=null}">--%>
               var ownerEntityDataTableColumnDef = [
                   {key:"id", label:"ID",sortable:true, resizable:false, hidden:true},
                   {key:"name", label:"Name",sortable:true, resizable:false, formatter: ownershipEntityViewLinkFormatter, className:"name"},
                   {key:"type", label:"Type",sortable:true, resizable:false, className:"type"},
                   {key:"status", label:"Status", sortable:true, resizable:false, className:"status"},
                   {key:"edit", label:"Edit", sortable:false, resizable:false, hidden:true, formatter: ownershipEntityEditLinkFormatter, className:"edit"},
                   {key:"rowSelect", label:"Select", sortable:false, resizable:false, hidden:true, formatter: shareholdingSelectLinkFormatter, className:"rowSelect"}
               ];
               <%--</c:if>--%>

               <%--<c:if test="${actionBean.returnTo==null}">--%>
                  <%--var ownerEntityDataTableColumnDef = [--%>
                       <%--{key:"id", label:"ID",sortable:true, resizable:false, className:"hide"},--%>
                       <%--{key:"name", label:"Name",sortable:true, resizable:false, formatter: ownershipEntityViewLinkFormatter, className:"name"},--%>
                       <%--{key:"type", label:"Type",sortable:true, resizable:false, className:"type"},--%>
                       <%--{key:"status", label:"Status", sortable:true, resizable:false, className:"status"},--%>
                       <%--{key:"edit", label:"Edit", sortable:false, hidden:true, resizable:false, formatter: ownershipEntityEditLinkFormatter, className:"edit"}--%>
                   <%--];--%>
               <%--</c:if>--%>

               YAHOO.log("Constructing o/e data table data source: YAHOO.util.DataSource","info");
               this.ownerEntitySearchDataSource = new YAHOO.util.DataSource(YAHOO.util.Dom.get("resultTable"));
               this.ownerEntitySearchDataSource.responseType = YAHOO.util.DataSource.TYPE_HTMLTABLE;

/*
               <%--<c:if test="${actionBean.returnTo==null}">--%>
                   this.ownerEntitySearchDataSource.responseSchema = {
                       fields:[
                           {key:"id"},
                           {key:"name"},
                           {key:"type"},
                           {key:"status"},
                           {key:"edit"}
                       ]
                   };
               <%--</c:if>--%>
*/

               <%--<c:if test="${actionBean.returnTo!=null}">--%>
                   this.ownerEntitySearchDataSource.responseSchema = {
                       fields:[
                           {key:"id"},
                           {key:"name"},
                           {key:"type"},
                           {key:"status"},
                           {key:"edit"},
                           {key:"rowSelect"}
                       ]
                   };
               <%--</c:if>--%>

               YAHOO.log("Constructing o/e data table configuration: YAHOO.widget.Paginato","info");
               var oConfigs = {
                   paginator: new YAHOO.widget.Paginator({
                       rowsPerPage: 15
                   })
               };

                var ownerEntityTable = new YAHOO.widget.DataTable("resultTableSection", ownerEntityDataTableColumnDef, this.ownerEntitySearchDataSource, oConfigs);

                <nc:ifAccessAllowed name="operatingentity.search.result.edit">
                    ownerEntityTable.showColumn('edit');
                   <c:if test="${actionBean.returnTo!=null}">
                      ownerEntityTable.showColumn('rowSelect');
                   </c:if>
                </nc:ifAccessAllowed>

                YAHOO.log("Constructing o/e data table: YAHOO.widget.DataTable","info");
               this.resultTable = ownerEntityTable;
                YAHOO.log("dONE!","info");

           }

         function yuiLoadComplete(){
             // Save search initialisation & handling
              YAHOO.util.Event.onDOMReady(function(){
                   initializeOwnershipEntitySearchResultTable();
              });
         }
       </script>

   </stripes:layout-component>


</stripes:layout-render>
