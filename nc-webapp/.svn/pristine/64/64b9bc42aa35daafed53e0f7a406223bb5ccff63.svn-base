<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/nc-dealerinfo-layout.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <div id="myDealerLocationPage">
            <!-- for selenium tests: my dealer location search result page -->

            <div class="pageContent_main_header">
                <h1 id="pageTitle"><fmt:message key="mydealerlocation.header"/></h1>
            </div>

            <div id="searchFormLayoutSection" class="pageContent_wrapper">
                <div id="searchResultLayoutSection" class="mainContent_wrapper">
                    <div id="myDealerLocationDataTableSection">
                        <table id="myDealerLocationTable">
                                <thead>
                                    <tr>
                                        <th><fmt:message key="location.locationId"/> </th>
                                        <th><fmt:message key="location.locationName"/></th>
                                        <th><fmt:message key="label.location"/> <fmt:message key="label.suburb"/></th>
                                        <th><fmt:message key="location.type"/></th>
                                        <th><fmt:message key="pma.name"/></th>
                                        <th><fmt:message key="label.location"/> <fmt:message key="label.phone"/></th>
                                    </tr>
                                </thead>
                                 <tbody>
                                     <c:forEach items="${actionBean.locations}" var="location">
                                        <tr>
                                            <td>${location.locationId}</td>
                                            <td>${location.locationName}</td>
                                            <td>${location.contact.streetAddress.suburb}</td>
                                            <td>${location.type}</td>
                                            <td>${location.dealer.generalInfo.pma.name}</td>
                                            <td>${location.contact.phone }</td>
                                        </tr>
                                     </c:forEach>
                                 </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </stripes:layout-component>

     <stripes:layout-component name="yui-init-dependencies">
            loader.require("datatable", "connection", "paginator");
    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">
        <script type="text/javascript">
                function initializeSearchResultTable(){
                            YAHOO.log("Constructing my dealer & location search  result table","info");

                            YAHOO.log("Constructing my dealer & location link formatter","info");
                            var locationLinkFormatter=function(eCell, eRecord, oColumn, oData){
                                    <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean" event="editLocation" scope="page"/>
                                    if (eRecord.getData("locationName")!=""){
                                        var url = '${url}&<%=ManageLocationActionBean.REQUEST_PARAM_LOCATION_ID%>='+eRecord.getData("locationID");
                                        eCell.innerHTML='<a id="editLocationLink-'+eRecord.getData("locationID")+'" href="'+url+'">'+eRecord.getData("locationName")+'</a>';
                                    }
                            }

                            YAHOO.log("Constructing my dealer & location data table column definition","info");
                            var searchResultDataTableColumnDef = [
                                {key:"locationID", label:"Location ID",sortable:false, resizable:false, className:"locationID"},
                                {key:"locationName", label:"Location Name", sortable:false, resizable:false, formatter:locationLinkFormatter,className:"locationName"},
                                {key:"suburb", label:"Suburb", sortable:false, resizable:false, className:"locationSuburb"},
                                {key:"locationType", label:"Location Type", sortable:false, resizable:false, className:"locationType"},
                                {key:"pma", label:"PMA", sortable:false, resizable:false, className:"pma"},
                                {key:"telephone", label:"Telephone", sortable:false, resizable:false, className:"telephone"}
                            ];

                            YAHOO.log("Constructing my dealer & location data table data source: YAHOO.util.DataSource","info");
                            this.myDealerLocationSearchDataSource = new YAHOO.util.DataSource(YAHOO.util.Dom.get("myDealerLocationTable"));
                            this.myDealerLocationSearchDataSource.responseType = YAHOO.util.DataSource.TYPE_HTMLTABLE;
                            this.myDealerLocationSearchDataSource.responseSchema = {
                                fields:[
                                    {key:"locationID"},
                                    {key:"locationName"},
                                    {key:"suburb"},
                                    {key:"locationType"},
                                    {key:"pma"},
                                    {key:"telephone"}
                                ]
                            };

                            YAHOO.log("Constructing my dealer & location data table configuration: YAHOO.widget.Paginator","info");
                            var oConfigs = {
                                paginator: new YAHOO.widget.Paginator({
                                    rowsPerPage: 15
                                })
                            };
                             YAHOO.log("Constructing my dealer & location data table: YAHOO.widget.DataTable","info");
                            this.myDealerLocationDataTable = new YAHOO.widget.DataTable("myDealerLocationDataTableSection", searchResultDataTableColumnDef, this.myDealerLocationSearchDataSource, oConfigs);
                }



          function yuiLoadComplete(){
              // Save search initialisation & handling
               YAHOO.util.Event.onDOMReady(function(){
                    initializeSearchResultTable();
               });
          }
        </script>

    </stripes:layout-component>


</stripes:layout-render>
