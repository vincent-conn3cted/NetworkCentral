<%@ include file="/WEB-INF/jsp/taglibs.jsp"%>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
	<stripes:layout-component name="init-event-handling">

		<script type="text/javascript">
			$(document).ready(function() {
				$("#resultTableDiv .yui-dt-bd").css("width", "960px"); 	
				
			});
		</script>


		<script type="text/javascript">
			function changeColor() {
				var list = ${actionBean.trainingMgrPersonIdList};
				$('table select').each(function(index) {
					var selctedPersonId = $(this).find("option:selected").attr("personId");
					var selectedDesc = $(this).find("option:selected").text();
					var appointmentId =  $('table input[type="hidden"][name$="\.id"]:eq(' + index + ')').val();
					var appointmentPersonId =  $('table input[type="hidden"][name$="\.personId"]:eq(' + index + ')').val();
					var dpGmrFlag =  $('table input[type="hidden"][name$="\.dpGmrFlag"]:eq(' + index + ')').val();
					
					
					if (selctedPersonId == appointmentPersonId ) {
						$(this).css("background-color", "#ff8080");
					}
					else if ((jQuery.inArray(selctedPersonId, list) >= 0) &&  (dpGmrFlag == "true")) {
						$(this).css("background-color", "#ff8080");
					}
					
					else if ((jQuery.inArray(selctedPersonId, list) >= 0) ||  (selectedDesc == "None Required")) {
						$(this).css("background-color", "#ffffff");
					} else {
						$(this).css("background-color", "#ff8080");
					}
										
				    $('table input[type="hidden"][name$="trainMgrDesc"]:eq(' + index + ')').val(selectedDesc);
				});
			}

			
			function checkChange(){
				var nochange = true;
				$('table select').each(function(index) {
					var selectedId = $(this).val();
					var previous_id = $('table input[type="hidden"][name$="currentTrainMgrId"]:eq(' + index + ')').val();
					if (selectedId != previous_id)
					{
						nochange = false;
					}
				});	

				if (!nochange)
				{
					var result = confirm("You have unsaved changes, do you want to continue with that action without save first?");
					return result;					
				}
				else
				{
					return true;
				}
				
				
			}
			
			
			
			function init_jquery_event() {
									
				$('a:not(.yui-dt-sortable),input[value="Print"]').click(function(event)  {
					if (!checkChange())
					{
						event.preventDefault();
						return;
					}	
					
				});

				$('input[value="Save"]').click(function(){
					
					$('table input[type="hidden"][name$="trainPersonId"]').each(
							function(index) {	
																
								var aaa = $('table option:selected:eq(' + index + ')').attr("personId");	
								$(this).val(aaa);
							});
					
					$('form').attr('target','_self');
				});
				
				$('input[value="Search"]').click(function(event){
					
					var nochange= true;
					$('table select').each(function(index) {
						var selectedId = $(this).val();
						var previous_id = $('table input[type="hidden"][name$="currentTrainMgrId"]:eq(' + index + ')').val();
						if (selectedId != previous_id)
						{
						    nochange = false;
						}
					});	
					if (nochange)
					{
					    $('form').attr('target','_self');
					    //$('table input[type="hidden"]').remove();
					}
					else
					{
						var result = confirm("You have unsaved changes, do you want to continue with that action without save first?");
						if (!result)
						{
							event.preventDefault();
							return;
						}
						else
						{
						    $('form').attr('target','_self');
						    $('table input[type="hidden"]').remove();
							
						}
						
					}

				});
				
				
				
				$('input[value="Print"]').click(
						function() {
							$('form').attr('target','_blank');
							$('table select').each(
									function(index) {
										$(this).attr(
												"name",
												"changeAppointment[" + index
														+ "].trainMgr");
										
										var selectedDesc = $(this).find("option:selected").text();
										
									    $('table input[type="hidden"][name$="trainMgrDesc"]:eq(' + index + ')').val(selectedDesc);
										
									});
							

							$('table input[type="hidden"][name$="\.id"]').each(
									function(index) {
										$(this).attr(
												"name",
												"changeAppointment[" + index
														+ "].id");
									});
							$('table input[type="hidden"][name$="\.departmentListStr"]').each(
									function(index) {
										$(this).attr(
												"name",
												"changeAppointment[" + index
														+ "].departmentListStr");
									});
							$('table input[type="hidden"][name$="\.dpGmrFlag"]').each(
									function(index) {
										$(this).attr(
												"name",
												"changeAppointment[" + index
														+ "].dpGmrFlag");
									});
							$('table input[type="hidden"][name$="\.appointmentDescription"]').each(
									function(index) {
										$(this).attr(
												"name",
												"changeAppointment[" + index
														+ "].appointmentDescription");
									});
							$('table input[type="hidden"][name$="\.trainPersonId"]').each(
									function(index) {
										$(this).attr(
												"name",
												"changeAppointment[" + index
														+ "].trainPersonId");
									});
							$('table input[type="hidden"][name$="\.personId"]').each(
									function(index) {
										$(this).attr(
												"name",
												"changeAppointment[" + index
														+ "].personId");
									});
							$('table input[type="hidden"][name$="\.trainMgrDesc"]').each(
									function(index) {
										$(this).attr(
												"name",
												"changeAppointment[" + index
														+ "].trainMgrDesc");
									});
							$('table input[type="hidden"][name$="\.currentTrainMgrId"]').each(
									function(index) {
										$(this).attr(
												"name",
												"changeAppointment[" + index
														+ "].currentTrainMgrId");
									});
							
						});

				$('table select').each(function(index) {
					$(this).width(360);
				});

			}

			function initializeDealerStaffSearchResultTable() {
				YAHOO.log("Constructing staff data table column definition",
						"info");

				var trainApprovalMgrLinkFormatter = function(eCell, eRecord,
						oColumn, oData) {
                    
					var html = eRecord.getData("trainApprovalMgr");		
											
					var selected = $(html).find('.currentSelection').val();	

                    var selectedText;

                    if (selected != "")						
                          selectedText = $(html).find('option[value="'+  selected  + '"]').text();
                    
                    var abc = "<option value=\"" + selected + "\" selected=\"selected\"";
                   
                    var source = "<OPTION value=" + selected;
                    
                    if (selected != "")         
                       html = html.replace(source, abc);           

                    eCell.innerHTML = html;
					
				};

				var appointmentLinkFormatter = function(eCell, eRecord,
						oColumn, oData) {
					eCell.innerHTML = eRecord.getData("appointment");
				};

				var departmentsLinkFormatter = function(eCell, eRecord,
						oColumn, oData) {
					eCell.innerHTML = eRecord.getData("departments");
				};

				var sortDepartment = function(a, b, desc) {
					// Deal with empty values 
					if (!YAHOO.lang.isValue(a)) {
						return (!YAHOO.lang.isValue(b)) ? 0 : 1;
					} else if (!YAHOO.lang.isValue(b)) {
						return -1;
					}

					// First compare by departments
					var comp = YAHOO.util.Sort.compare;
					var compDept = comp(a.getData("departments"), b
							.getData("departments"), desc);
					
					return (compDept !== 0) ? compDept : comp(a
							.getData("appointment"), b.getData("appointment"),
							desc);
				};

				var sortTrainMgr = function(a, b, desc) {
					// Deal with empty values 
					if (!YAHOO.lang.isValue(a)) {
						return (!YAHOO.lang.isValue(b)) ? 0 : 1;
					} else if (!YAHOO.lang.isValue(b)) {
						return -1;
					}

					// First compare by training approval manager 
					var comp = YAHOO.util.Sort.compare;
				
					html1 = a.getData("trainApprovalMgr");
					html2 = b.getData("trainApprovalMgr");
					

											
					var a_selected = $(html1).find('.currentSelection').val();	

                    var a_selectedText = "None Required";

                    if (a_selected != "")						
                          a_selectedText = $(html1).find('option[value="'+  a_selected  + '"]').text();


                    var b_selected = $(html2).find('.currentSelection').val();	

                    var b_selectedText = "None Required";

                    if (b_selected != "")						
                          b_selectedText = $(html2).find('option[value="'+  b_selected  + '"]').text();


					
					var compTrainMgr = comp(a_selectedText,b_selectedText, desc);
         
					// If trainning approval manager are equal, then compare by appointment 
					return (compTrainMgr !== 0) ? compTrainMgr : comp(a
							.getData("appointment"), b.getData("appointment"),
							desc);
				};

				var dealerStaffDataTableColumnDef = [ {
					key : "appointment",
					label : "Appointment",
					sortable : true,
					formatter : appointmentLinkFormatter,
					resizable : true,
					width : "260px"
				}, {
					key : "trainApprovalMgr",
					label : "Training Approval Manager",
					sortable : true,
					sortOptions : {
						sortFunction : sortTrainMgr
					},
					resizable : true,
					formatter : trainApprovalMgrLinkFormatter,
					width : "370px"
				}, {
					key : "departments",
					label : "Department(s)",
					sortable : true,
					sortOptions : {
						sortFunction : sortDepartment
					},
					formatter : departmentsLinkFormatter,
					resizable : true,
					width : "260px"
				} ];
		<%-- End formatters here--%>
			YAHOO
						.log(
								"Constructing o/e data table data source: YAHOO.util.DataSource",
								"info");
				this.awardDataSource = new YAHOO.util.DataSource(YAHOO.util.Dom
						.get("resultsTable"));
				this.awardDataSource.responseType = YAHOO.util.DataSource.TYPE_HTMLTABLE;

				this.awardDataSource.responseSchema = {
					fields : [ {
						key : "appointment"
					}, {
						key : "trainApprovalMgr"
					}, {
						key : "departments"
					} ]
				};

				YAHOO
						.log(
								"Constructing o/e data table configuration: YAHOO.widget.Paginato",
								"info");

				YAHOO.log(
						"Constructing o/e data table: YAHOO.widget.DataTable",
						"info");

				<c:if
				test="${not empty(appointment.trainingManager.appointmentId) and appointment.dpGmrFlag}">
				<option value="">None Required</option>
			    </c:if>
				var staffTable = new YAHOO.widget.ScrollingDataTable(
						"resultTableDiv", dealerStaffDataTableColumnDef,
						this.awardDataSource, {
							width: "960px",				
							<c:choose>
							  <c:when test="${fn:length(actionBean.appointments)>25}">
							        height : "58em"
							  </c:when>
							  <c:otherwise>
							        maxheight: "58em"
							  </c:otherwise>
							</c:choose>
						});


				this.resultsTable = staffTable;
				
				
				this.resultsTable.subscribe("cellClickEvent", function(ev) {

					target = ev.target;
					column = this.getColumn(target);
					if (column.key === "trainApprovalMgr") {
						changeColor();
					} 
				});
				
				
				
				var ids = ["yui-dt0-fixedth-trainApprovalMgr","yui-dt0-fixedth-appointment", "yui-dt0-th-departments-liner"];
				
				YAHOO.util.Event.addListener(ids,'click',function (e) {
					
					if (!checkChange())
					{
						YAHOO.util.Event.stopEvent(e);
					}	
					});

				
				

				init_jquery_event();
				changeColor();

			}

			// On document ready, start perform search....
			function yuiLoadComplete() {
				YAHOO.util.Event.onDOMReady(function() {
					initializeDealerStaffSearchResultTable();
				});

			}
		</script>

	</stripes:layout-component>

	<stripes:layout-component name="yui-init-dependencies">
        loader.require("datatable", "connection", "paginator", "menu");
   </stripes:layout-component>

	<stripes:layout-component name="html-head">
		<link rel="stylesheet" media="screen" type="text/css"
			href="${pageContext.request.contextPath}/css/wib/approvalManager/nc-approvalMgr.css" />
	</stripes:layout-component>

	<stripes:layout-component name="page-contents">
	<nc:pageName pageName="approvalManager"/>
      <nc:ifAccessAllowed name="approvalManager.page">
		<stripes:form
			beanclass="au.com.toyota.nc.webapp.stripes.approvingmanager.ApprovingManagerActionBean">
			<div class="pageContent_main_header">
				<h1>Training Approval Managers</h1>
			</div>

			<div id="searchDealerPage" class="pageContent_wrapper">
				<div class="mainContent_wrapper">
					<c:import url="/WEB-INF/jsp/messages.jsp" />
					<div class="float_left margin_right15">
						<img src="${pageContext.request.contextPath}/images/arrow.png" width="8"
							class="margin_right5" /><strong>Select:</strong>
					</div>

					<div class="float_left">
						<stripes:hidden id="changeList" name="changeList" />

						<stripes:label for="departmentStr">Department</stripes:label>
						<stripes:select id="departmentStr" name="departmentStr">
							<stripes:options-collection
								collection="${actionBean.departmentList}" />
						</stripes:select>

						<br />
						<stripes:label for="trainningMgrId">Training Approval Manager</stripes:label>
						<stripes:select id="trainningMgrId" name="trainningMgrId">
							<option value="All" selected="selected">All</option>
							<stripes:options-collection
								collection="${actionBean.trainningMgrList}" label="description"
								value="appointment_id" />
						</stripes:select>
					</div>
					<div class="searchDealerPage_btn">
						<stripes:submit name="searchAppoint" id="upload-button"
							class="btn" value="Search" />
						<stripes:submit name="saveAppoint" id="upload-button" class="btn"
							value="Save" />
						<stripes:submit name="printAppoint" id="upload-button" class="btn"
							value="Print" />
					</div>
					<br />
				</div>
			</div>
			<br />
			<hr style="background-color: black;width: 2px;" />
			<div id="resultTableDiv" style='background: url("../images/wib/light-blue-gradient-bg.jpg") repeat-x scroll 0 bottom transparent;'>
				<table class="resultsTable" id="resultsTable">
					<thead>
						<tr>
							<th>Appointment</th>
							<th>Training Approval Manager</th>
							<th>Department(s)</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach items="${actionBean.appointments}" var="appointment"
							varStatus="loopStatus">
							<tr class="${loopStatus.index %2==0 ? 'darkRow':'lightRow'}">
								<td>
									<div class="data-line">
										<c:out value="${appointment.appointmentDescription}" />
										<input type="hidden" name="changeAppointment[${loopStatus.index}].appointmentDescription" value="${appointment.appointmentDescription}" >				
									</div>
								</td>
								<td>
									<div class="data-line">
										<select
											name="changeAppointment[${loopStatus.index}].trainMgr"
											id="${appointment.appointmentId}">
											<c:choose>
												<c:when
													test="${empty appointment.trainingManager.appointmentId and appointment.dpGmrFlag}">
													<option value="" selected="selected" personId="">None Required</option>
												</c:when>
												<c:when
													test="${empty actionBean.trainingMgrIdMap[appointment.trainingManager.appointmentId]}">
													<option
														value="${appointment.trainingManager.appointmentId}"
														selected="selected" personId="${appointment.trainingManager.person.personId}">${appointment.trainingManager.appointmentDescription}</option>
												</c:when>
												<c:otherwise>
													<c:if
														test="${not empty(appointment.trainingManager.appointmentId) and appointment.dpGmrFlag}">
														<option value="" personId="">None Required</option>
													</c:if>
												</c:otherwise>
											</c:choose>
											
											
											<c:forEach items="${actionBean.trainningMgrList}"
												var="trainningMgr">
												<c:if test="${not appointment.dpGmrFlag}">
													<c:choose>
														<c:when
															test="${appointment.trainingManager.appointmentId==trainningMgr.appointment_id}">
															<option value="${trainningMgr.appointment_id}"
																selected="selected" personId="${trainningMgr.personId}">${trainningMgr.description}</option>
														</c:when>
														<c:otherwise>
															<option value="${trainningMgr.appointment_id}" personId="${trainningMgr.personId}">${trainningMgr.description}</option>
														</c:otherwise>
													</c:choose>
												</c:if>
												<c:if test="${appointment.dpGmrFlag}">
													<c:choose>
														<c:when
															test="${appointment.trainingManager.appointmentId==trainningMgr.appointment_id}">
															<option value="${trainningMgr.appointment_id}"
																selected="selected" personId="${trainningMgr.personId}">${trainningMgr.description}</option>
														</c:when>
													</c:choose>
												</c:if>
											 </c:forEach>
											
										</select>
										
										<c:choose>
										     <c:when test="${empty appointment.trainingManager.appointmentId}">
												  <input type="hidden" class="currentSelection" value="" >	
										     </c:when>
										
										     <c:otherwise>
													<input type="hidden" class="currentSelection" value="${appointment.trainingManager.appointmentId}" >	
										     </c:otherwise>
										</c:choose>
										
										<input type="hidden" name="changeAppointment[${loopStatus.index}].id" value="${appointment.appointmentId}" >
										<input type="hidden" name="changeAppointment[${loopStatus.index}].trainPersonId" value="">	
										<input type="hidden" name="changeAppointment[${loopStatus.index}].personId" value="${appointment.person.personId}" >				
										<input type="hidden" name="changeAppointment[${loopStatus.index}].trainMgrDesc" value="${appointment.trainingManager.appointmentDescription}" >	
										<input type="hidden" name="changeAppointment[${loopStatus.index}].currentTrainMgrId" value="${appointment.currentTrainMgrId}" >			
									</div>
								</td>
								<td>
									<div class="data-line">
									    <c:out value="${appointment.departmentListStr}" />
									    <input type="hidden"
											name="changeAppointment[${loopStatus.index}].departmentListStr"
											value="${appointment.departmentListStr}" >
										 <input type="hidden"
											name="changeAppointment[${loopStatus.index}].dpGmrFlag"
											value="${appointment.dpGmrFlag}" >
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</stripes:form>
		</nc:ifAccessAllowed>
	</stripes:layout-component>
</stripes:layout-render>





