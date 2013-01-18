<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/nc-dealerinfo-layout.css"/>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/nc-ajax.js"></script>		
    </stripes:layout-component>
    
    <stripes:layout-component name="page-contents">
        <nc:pageName pageName="DealerStaff-SearchResult"/>
         <div class="pageContent_main_header">
            <h1>Manage Dealer Staff</h1>
        </div>

        <!-- for selenium tests: searches dealer staff results page -->
        <div id="searchDealerStaffPage" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
            <c:import url="/WEB-INF/jsp/messages.jsp"/>
             <div id="messageBox" class="messageBox infoMessage searchResultMessage">
                         <ul>
                             <li><nc:requestDecorator/></li>
                         </ul>
             </div>
            <div class="noOfRecords"> ${fn:length(actionBean.searchRsp.staffByDealers)} records matched your query </div>

                    <div id="searchFormLayoutSection">
                        <div id="searchResultLayoutSection">
                            <stripes:form id="dealerStaffResultForm" beanclass="au.com.toyota.nc.webapp.stripes.staff.DealerStaffSearchActionBean" method="post">
                                <div id="dealerStaffDataTableSection">
                                    <table id="resultTable">
                                        <thead>
                                            <tr>
                                                <th width="10%">Dealer Staff No</th>
                                                <th width="10%">First name</th>
                                                <th width="10%">Last name</th>
                                                <th width="10%">Add Position</th>
                                                <th width="10%">Add DP/GMR position</th>
                                                <th width="10%">Dealership</th>
                                                <th width="10%">Suburb</th>
                                                <th width="10%">Primary Location&nbsp;</th>
                                                <th width="10%">Primary Position</th>
                                                <th width="10%">Reset password</th>
                                                <th width="10%">Discontinue staff member from dealership</th>
                                                <c:if test="${actionBean.searchRsp.returnTo!=null}">
                                                    <th>Select</th>
                                                </c:if>
                                                <th class="hide">Eligible</th>
                                                <th class="hide">Dealer Id</th>
                                                <th class="hide">Dealer Name</th>
                                                <th class="hide">hasAppointment</th>
                                                <th class="hide">isProvisional</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${actionBean.searchRsp.staffByDealers}" var="staffByDealer">
                                                    <tr>
                                                        <td>${staffByDealer.personId}</td>
                                                        <td>${staffByDealer.firstname}</td>
                                                        <td>${staffByDealer.surname}</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td>
                                                            <%--
                                                            only show the dealer link if a dealerId is present. otherwise the link will link
                                                            to nowhere!
                                                            --%>
                                                            <c:if test="${staffByDealer.dealerID ne null}">
                                                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean"
                                                                              event="viewDealer"
                                                                              class="viewDealerLink"
                                                                              target="_blank">
                                                                    <stripes:param name="dealer.dealerId" value="${staffByDealer.dealerID}"/> 
                                                                    ${staffByDealer.dealerName}
                                                                </stripes:link> 
                                                                                                                            
                                                            </c:if>
                                                        </td>
                                                        <td>${staffByDealer.dealerSuburb}</td>
                                                        <td>${staffByDealer.primaryLocationName}</td>
                                                        <td>${staffByDealer.primaryPositionDesc}</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td>Select</td>
                                                        <td class="hide">${staffByDealer.eligible}</td>
                                                        <td class="hide">${staffByDealer.dealerID}</td>
                                                        <td class="hide">${staffByDealer.dealerName}</td>
                                                        <td class="hide"><c:out value="${staffByDealer.hasAppointment}"/></td>
                                                        <td class="hide"><c:out value="${staffByDealer.isProvisonal}"/></td>
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
                                    <nc:ifAccessAllowed name="dealerStaff.search.result.addstaff">
                                        <li>
                                            <%--<stripes:form id="checkAgreementForm" beanclass="au.com.toyota.nc.webapp.stripes.staff.AddStaffAgreementActionBean" method="post">--%>
                                                <%--<jsp:include page="/WEB-INF/jsp/nc/staff/addStaffAgreement.jsp"/>--%>
                                                <%--<input id="addNewDealerAgreement" class="btn btn_addNewStaff" type="button" value="<fmt:message key="staff.add.agreement"/>" onclick="openAgreementDialog('showAddStaffAgreement');"/>--%>
                                            <%--</stripes:form>--%>
                                            <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffActionBean"
                                                id="addNewDealerStaffLink"
                                                event="add" onclick="openAgreementDialog('showStaffSaveSearchLabel');">&nbsp;
                                             </stripes:link>
                                        </li>
                                    </nc:ifAccessAllowed>
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
                            <div id="AgreementDialog" class="dialog dialogWithDefaultCloseButton">
                                <div class="bd" id="agreementDialogBody">&nbsp;</div>
                            </div>
                            <div id="saveSearchDialog" class="dialog dialogWithDefaultCloseButton">
                                <div class="bd" id="saveSearchDialogBody">&nbsp;</div>
                            </div>
                            <div id="mailingLabelDialog" class="dialog dialogWithDefaultCloseButton">
                                <div class="bd" id="mailingLabelDialogBody">&nbsp;</div>
                            </div>
        					<c:if test="${not empty requestScope.APPOINTMENT_LINKS_FOUND}">                            
		                    <div id="alertDiscontinueDialog" class="dialog dialogWithDefaultCloseButton">
		                    	<div class="hd">Warning - Training Approval Manager</div> 
		                        <div class="bd" id="alertDiscontinueDialogBody"><fmt:message key="staff.discontinue.warning.message"/></div>
		                    </div>                            
							</c:if>
                            <div class="clear"></div>
                        </div>
                        <div class="clear"></div>
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
    <jsp:include page="/WEB-INF/jsp/nc/staff/_staffAddAgreementJs.jsp"/>
    <jsp:include page="/WEB-INF/jsp/nc/savedsearch/_mailingLabelPopupJs.jsp">
        <jsp:param name="mailingLabelBeanClass" value="au.com.toyota.nc.webapp.stripes.reports.MailingLabelAppointmentReportActionBean"/>
    </jsp:include>


    <script type="text/javascript">
		
        function initializeDealerStaffSearchResultTable(){
            YAHOO.log("Constructing staff data table column definition","info");
    
            <%-- Starts formatters here--%>
            var staffIDLinkFormatter =function(eCell, eRecord, oColumn, oData){
                <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffActionBean" event="edit" scope="page"/>
                 var url = '<a id="editDealerStaffLink-'+eRecord.getData("staffId")+'" href="'+'${url}&dealerStaff.personId='+eRecord.getData("staffId") + '&eligible='+eRecord.getData("eligible");
                eCell.innerHTML=url+'">'+eRecord.getData("staffId")+'</a>';
            };

            var firstNameLinkFormatter =function(eCell, eRecord, oColumn, oData){
                <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffActionBean" event="edit" scope="page"/>
                 var url = '<a id="editDealerStaffFirstNameLink-'+eRecord.getData("staffId")+'" href="'+'${url}&dealerStaff.personId='+eRecord.getData("staffId") + '&eligible='+eRecord.getData("eligible");
                eCell.innerHTML=url+'">' + '<span class="dealer_staff_search_results_firstname">' +eRecord.getData("fname") + '</span>' +'</a>';
            };

            var lastNameLinkFormatter =function(eCell, eRecord, oColumn, oData){
                <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffActionBean" event="edit" scope="page"/>
                 var url = '<a id="editDealerStaffSurNameLink-'+eRecord.getData("staffId")+'" href="'+'${url}&dealerStaff.personId='+eRecord.getData("staffId") + '&eligible='+eRecord.getData("eligible");
                eCell.innerHTML=url+'">' + '<span class="dealer_staff_search_results_lastname">' +eRecord.getData("lname") + '</span>' + '</a>';
            };

            var shareholdingSelectLinkFormatter =function(eCell, eRecord, oColumn, oData){
                <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageIndividualEntityActionBean" event="editIndividual" scope="page"/>
                 var url = '<a id="editDealerStaffShareholdingLink-'+eRecord.getData("staffId")+'" href="'+'${url}&dealerStaff.personId='+eRecord.getData("staffId")+'&returnTo=${actionBean.searchRsp.returnTo}';
                eCell.innerHTML=url+'">'+eRecord.getData("rowSelect")+'</a>';
            };

            var addDPGMRFormatter =function(eCell, eRecord, oColumn, oData){
                <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffPositionActionBean" event="addDpGmr" scope="page"/>
                 var url = '<a id="addDpGmrPositionForStaffLink-'+eRecord.getData("staffId")+'" href="'+'${url}&appointment.person.personId='+eRecord.getData("staffId") + '">';
                eCell.innerHTML=url+'Add DP/GMR</a>';
            }

            var addPositionFormatter =function(eCell, eRecord, oColumn, oData){
                <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffPositionActionBean" event="add" scope="page"/>
                 var url = '<a id="addPositionForStaffLink-'+eRecord.getData("staffId")+'" href="'+'${url}&appointment.person.personId='+eRecord.getData("staffId") + '">';
                eCell.innerHTML=url+'Add</a>';
            }

            var resetPasswordFormatter =function(eCell, eRecord, oColumn, oData){
                if(eRecord.getData('hasPositions') == 'true' && eRecord.getData("eligible")=='true' && eRecord.getData("isProvisonal")=='false')
                {
                    <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.ResetDealerStaffPasswordActionBean" event="showResetOthersPassword" scope="page"/>
                    var url = '<a class="resetPasswordLink" id="resetPassword-dealerId-'+eRecord.getData("dealerID")+'-staffId-'+eRecord.getData("staffId")+'" href="'+'${url}&dealer.dealerId='+eRecord.getData("dealerID")+'&dealerStaff.personId='+eRecord.getData("staffId") + '">';
                    eCell.innerHTML=url+'Reset</a>';
                }
            }

            var discontinuePositionsFormatter =function(eCell, eRecord, oColumn, oData){
                if (eRecord.getData('hasPositions') == 'true' && eRecord.getData("eligible")=='true'){
                    <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.staff.DealerStaffSearchActionBean" event="removeAllAppointments" scope="page"/>
                    var disId = "discontinuePosition-dealerId"+eRecord.getData("dealerID")+'-staffId-'+eRecord.getData("staffId");
                    var params = "?&dealer.id="+eRecord.getData("dealerID") + "&dealerStaff.id="+eRecord.getData("staffId");
                    var excludeMessage = "non Dealer Principal or GMR ";

                    <isd:ifUserInRole role="NationalAdministrator">
                    	excludeMessage = "";
                    </isd:ifUserInRole>
                    
                    var url = '<a onclick="return confirm(\'Discontinue all ' + excludeMessage + 'positions from '+eRecord.getData("fname")+' '+eRecord.getData("lname")+' at '+eRecord.getData("dealerName")+'\');" class="discontinueStaffLink" id="'+disId+'" href="'+ '${url}' + params + '">';
                    eCell.innerHTML=url+'Discontinue</a>';
                }
            }

            <%-- End formatters here--%>
            var dealerStaffDataTableColumnDef = [
                {key:"staffId", label:"Dealer Staff No",sortable:true, hidden:true, resizable:true, className:"name", formatter: staffIDLinkFormatter},
                {key:"fname", label:"First name",sortable:true, hidden:true, resizable:true, className:"name", formatter: firstNameLinkFormatter},
                {key:"lname", label:"Last name",sortable:true, hidden:true, resizable:true, className:"type", formatter: lastNameLinkFormatter},
                {key:"addposition", label:"Add Position", sortable:false, hidden:true, resizable:false, className:"status", formatter: addPositionFormatter},
                {key:"gpgmr", label:"Add DP/GMR position", sortable:false, hidden:true, resizable:false, className:"status", formatter: addDPGMRFormatter},
                {key:"dealership", label:"Dealership", sortable:true, hidden:true, resizable:true, className:"edit", sortOptions: {field: "dealerName"}},
                {key:"suburb", label:"Suburb", sortable:true, hidden:true, resizable:true, className:"edit"},
                {key:"primaryloc", label:"Primary Location", sortable:true, hidden:true, resizable:false, className:"edit"},
                {key:"primaryposition", label:"Primary Position", sortable:true, hidden:true, resizable:true, className:"edit"},
                {key:"resetpassword", label:"Reset password", sortable:false, hidden:true, resizable:true, className:"edit", formatter: resetPasswordFormatter},
                {key:"discontinuepositions", label:"Discontinue staff member from dealership", sortable:false, hidden:true, resizable:true, className:"edit", formatter: discontinuePositionsFormatter},
                {key:"rowSelect", label:"Select", sortable:false, hidden:true, resizable:true, className:"rowSelect", formatter:shareholdingSelectLinkFormatter},
                {key:"eligible", label:"Eligible", sortable:false, hidden:true, resizable:false, className:"rowSelect"},
                {key:"dealerID", label:"Dealer Id", sortable:false, hidden:true, resizable:false, className:"rowSelect"},
                {key:"dealerName", label:"Dealer Name", sortable:false, hidden:true, resizable:false, className:"rowSelect"},
                {key:"hasPositions", label:"Has Positions", sortable:false, hidden:true, resizable:false, className:"rowSelect"},
                {key:"isProvisonal", label:"Provisonal Appointment", sortable:false, hidden:true, resizable:false, className:"rowSelect"}
            ];

            YAHOO.log("Constructing staff data table data source: YAHOO.util.DataSource","info");
            this.awardDataSource = new YAHOO.util.DataSource(YAHOO.util.Dom.get("resultTable"));
            this.awardDataSource.responseType = YAHOO.util.DataSource.TYPE_HTMLTABLE;

                this.awardDataSource.responseSchema = {
                    fields:[
                        {key:"staffId"},
                        {key:"fname"},
                        {key:"lname"},
                        {key:"addposition"},
                        {key:"gpgmr"},
                        {key:"dealership"},
                        {key:"suburb"},
                        {key:"primaryloc"},
                        {key:"primaryposition"},
                        {key:"resetpassword"},
                        {key:"discontinuepositions"},
                        {key:"rowSelect"},
                        {key:"eligible"},
                        {key:"dealerID"},
                        {key:"dealerName"},
                        {key:"hasPositions"},
                        {key:"isProvisonal"}
                    ]
                };

            YAHOO.log("Constructing staff data table configuration: YAHOO.widget.Paginator","info");
            var oConfigs = {
                paginator: new YAHOO.widget.Paginator({
                    rowsPerPage: 50
                })
            };
             YAHOO.log("Constructing staff data table: YAHOO.widget.DataTable","info");
            var staffTable = new YAHOO.widget.DataTable("dealerStaffDataTableSection", dealerStaffDataTableColumnDef, this.awardDataSource, oConfigs);

            <nc:ifAccessAllowed name="dealerStaff.search.result.staffId">staffTable.showColumn('staffId');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.fname">staffTable.showColumn('fname');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.lname">staffTable.showColumn('lname');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.addposition">staffTable.showColumn('addposition');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.gpgmr">staffTable.showColumn('gpgmr');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.dealership">staffTable.showColumn('dealership');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.suburb">staffTable.showColumn('suburb');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.primaryloc">staffTable.showColumn('primaryloc');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.primaryposition">staffTable.showColumn('primaryposition');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.resetpassword">staffTable.showColumn('resetpassword');</nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealerStaff.search.result.discontinuepositions">staffTable.showColumn('discontinuepositions');</nc:ifAccessAllowed>
            <c:if test="${actionBean.searchRsp.returnTo!=null}">
                staffTable.showColumn('rowSelect');
            </c:if>
            this.resultTable = staffTable;

        }

        <c:if test="${not empty requestScope.APPOINTMENT_LINKS_FOUND}">
		
			// Instantiate the Dialog
			var alertDiscontinueDialog = new YAHOO.widget.Dialog("alertDiscontinueDialog", 
						{ width : "40em",
						  fixedcenter : true,
						  visible : false, 
						  constraintoviewport : false
						  } );
						  
			// Define various event handlers for Dialog 
			var handleAlertDiscontinueDialogSubmit = function() { 
				// do nothing
				alertDiscontinueDialog.hide();
			};						  
						 
			var myAlertDiscontinueButtons = [ { text : "Close", handler:handleAlertDiscontinueDialogSubmit, isDefault : true }];			 
			alertDiscontinueDialog.cfg.queueProperty("buttons", myAlertDiscontinueButtons);
			alertDiscontinueDialog.render();  	
			
        </c:if>

	   
        // On document ready, start perform search....
        function yuiLoadComplete(){
            YAHOO.util.Event.onDOMReady(function(){
                initializeDealerStaffSearchResultTable();

		        <c:if test="${not empty requestScope.APPOINTMENT_LINKS_FOUND}">
				
					alertDiscontinueDialog.show();  

                </c:if>
                
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

                YAHOO.au.com.toyota.widget.agreementDialog = new YAHOO.widget.Dialog("agreementDialog",
                {
                    model: true,
                    width: "30em",
                    fixedcenter:true,
                    visible:false,
                    constraintoviewport : true,
                    buttons : [ { text:"Submit", handler:handleSubmit },
                                { text:"Cancel", handler:handleCancel, isDefault:true } ]                    
                });
                YAHOO.au.com.toyota.widget.AgreementDialog.render();
//                YAHOO.util.Event.addListener("addNewDealerAgreement", "click", YAHOO.au.com.toyota.widget.agreementDialog.show, YAHOO.au.com.toyota.widget.agreementDialog, true);



            });
        }
    </script>
</stripes:layout-component>


</stripes:layout-render>