<%@ page import="au.com.toyota.nc.webapp.stripes.admin.ManagePositionTypesActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<fmt:setBundle basename="nc-admin-resources" var="admin_resources" scope="page"/>
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/admin/nc-admin.css" />
    	<link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/smoothness/jquery-ui-1.7.3.custom.css" />
    	<link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/ui.dropdownchecklist.themeroller.css" />
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: maintain position page -->
        <div class="pageContent_main_header">
            <h1><fmt:message bundle="${admin_resources}" key="manage.positiontypes.header"/></h1>
        </div>
        
        <div id="positionTypeSelectionSection" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                    <c:import url="/WEB-INF/jsp/messages.jsp"/>
                    <table id="positionTypesTable" class="adminTable twoCols">
                        <tr>
                        <td class="two_col_left listColumn">
                                <stripes:form id="positionTypesForm" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManagePositionTypesActionBean">
                                    <ul class="table-item-control-nav">
                                        <li>
                                            <stripes:link id="addLink" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManagePositionTypesActionBean"
                                               event="addPositionType">
                                                [ <fmt:message key="label.add"/> ]
                                           </stripes:link>
                                        </li>
                                        <c:if test="${fn:length(actionBean.allPosition) > 0}">
                                            <li>
                                                 <a href="" id="editLink">
                                                    [ <fmt:message key="label.edit"/> ]
                                                </a>
                                            </li>
                                            <li>
                                                <a href="" id="deleteLink">
                                                    [ <fmt:message key="label.delete"/> ]
                                                </a>
                                            </li>
                                            <li>
                                                <a href="" id="discontinueLink">
                                                    [ <fmt:message key="label.discontinue"/> ]
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                    <c:if test="${fn:length(actionBean.allPosition) > 0}">
                                        <stripes:select name="position.positionId" id="positionTypeSelectBox" class="containerFillingList" size="20">
                                            <stripes:options-collection collection="${actionBean.allPosition}" label="description" value="positionId"/>
                                        </stripes:select>
                                    </c:if>
                                </stripes:form>
                        </td>

                        <td id="positionTypeAddEditSection" class="two_col_right formColumn">
                                <c:if test="${actionBean.displayForm eq true}">
                                    <div class="form">
                                        <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.admin.ManagePositionTypesActionBean">
                                            <fieldset>
                                                <stripes:hidden name="position.positionId" id="positionId"/>
                                                <stripes:hidden name="position.userCn" id="userCn"/>
                                                <stripes:hidden name="position.maintenanceDate" id="maintenanceDate"/>

                                                <stripes:label for="position.description"/>
                                                <stripes:text name="position.description" id="position.description"/><br/>

                                                <stripes:label for="position.abbreviation"/>
                                                <stripes:text name="position.abbreviation" id="position.abbreviation"/><br/>

                                                <stripes:label for="position.sapSalesCategory"/>
                                                <stripes:select name="position.sapSalesCategory" id="position.sapSalesCategory">
                                                    <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                                    <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.SAPSalesCategory" label="description"/>
                                                </stripes:select><br/>

                                                <stripes:label for="position.sapSalesPosition"/>
                                                <stripes:select name="position.sapSalesPosition" id="position.sapSalesPosition">
                                                    <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                                    <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.SAPSalesPosition" label="description"/>
                                                </stripes:select><br/>

                                                <stripes:label for="position.startDate" name="label.startDate"/>
                                                <nc:datetext name="position.effectiveDate"
                                                             id="position.startDate"
                                                             buttonId="startDateTrigger"
                                                             class="dateField"
                                                             skipPermissions="true"/>
                                                <br/>
                                                <stripes:label for="position.endDate" name="label.endDate"/>
                                                <nc:datetext name="position.terminationDate"
                                                             id="position.endDate"
                                                             buttonId="endDateTrigger"
                                                             class="dateField"
                                                             skipPermissions="true"/>
                                                <br/>
                                               <div id="exportHardCopy" class="exportSection">
                                                    <stripes:label for="position.exportHardCopy"/>
                                                    <stripes:checkbox name="position.exportHardCopyFlag" id="position.exportHardCopy"/><br/>
                                                    <stripes:label for="position.sortOrderHardCopy"/>
                                                    <stripes:text name="position.sortOrderHardCopy" id="position.sortOrderHardCopy"/><br/>
                                                </div>

                                                <div id="exportMailMerge" class="exportSection">
                                                    <stripes:label for="position.exportMailMerge"/>
                                                    <stripes:checkbox name="position.exportMailMergeFlag" id="position.exportMailMerge"/><br/>
                                                    <stripes:label for="position.sortOrderMailMerge"/>
                                                    <stripes:text name="position.sortOrderMailMerge" id="position.sortOrderMailMerge"/><br/>
                                                </div>


                                                <div id="exportExcel" class="exportSection">
                                                    <stripes:label for="position.exportExcel"/>
                                                    <stripes:checkbox name="position.exportExcelFlag" id="position.exportExcelFlag"/><br/>
                                                    <stripes:label for="position.sortOrderExcel"/>
                                                    <stripes:text name="position.sortOrderExcel" id="position.sortOrderExcel"/><br/>
                                                </div>

                                                <div class="exportSection">
                                                	<stripes:label for="position.dpGmrFlag" name="position.dpGmr"/>
                                                	<stripes:checkbox name="position.dpGmrFlag" id="position.dpGmrFlag"/><br/>
                                                </div>
                                                
                                                <div class="exportSection">
	                                                <stripes:label for="position.positionDefinitions" name="position.positionDefinitionsLabel"/>
		                                            <stripes:select name="positionDefinitionsIdsSelect" id="positionDefinitionsIdsSelect" multiple="true">
	                                    				<stripes:options-collection collection="${actionBean.allActivePositionDefinitions}" label="description" value="commonValueId"/>
	 												</stripes:select>
	 												<br />
 												</div>
                                            </fieldset>
                                             <div class="formActionButtons">
                                                <stripes:submit name="savePositionType" value="Save"
                                                                onclick="disableButton('savePositionTypeButton');"
                                                                id="savePositionTypeButton" class="btn btn_save"><fmt:message key="label.save"/> </stripes:submit>
                                                 <input type="button" class="btn btn_cancel" value="Cancel" onclick="document.getElementById('positionTypeAddEditSection').innerHTML = '';return false;"/>
                                                 <div class="clear"></div>
                                            </div>
                                            <c:if test="${!actionBean.footerDisplayable}"> 
	                                            <c:if test="${(actionBean.position != null) && (actionBean.lastMaintainedUserNameFromLDAP != null) && (actionBean.position.maintenanceDateAsString != null)}">
		                                            <div align="center">
			        									<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.position.maintenanceDateAsString}"  />
			        								</div>
		        								</c:if>
											</c:if>
                                        </stripes:form>
                                    </div>
                                </c:if>
                        </td>
                        </tr>
                    </table>
            </div>
        </div>
    </stripes:layout-component>


    <stripes:layout-component name="init-event-handling">
         <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp" />
         <c:if test="${actionBean.displayForm eq true}">
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarItem.jsp" inputField="position.startDate" button="startDateTrigger" />
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarItem.jsp" inputField="position.endDate" button="endDateTrigger" />
        </c:if>

        <script type="text/javascript">

            function yuiLoadComplete(){
                YAHOO.util.Event.onDOMReady(function(){

                    YAHOO.util.Event.addListener("editLink","click",
                        function(event){
                            <c:url value="/admin/ManagePositionTypes.action" var="url">
                                <c:param name="<%=ManagePositionTypesActionBean.EVENT_GET%>"/>
                            </c:url>
                            var positionTypeId=$('#positionTypeSelectBox').val();
                            if (positionTypeId!=null){
                                window.location="${url}&position.positionId="+positionTypeId;
                            }else{
                                window.location="${url}";
                            }
                            // Stop event from propagating - otherwise redirect to this page again.
                            YAHOO.util.Event.preventDefault(event); 
                        },null,true
                    );

                    YAHOO.util.Event.addListener("discontinueLink","click",
                        function(event){
                            <stripes:url var="discontinueLinkUrl" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManagePositionTypesActionBean" event="discontinue"/>
                            var positionTypeId=$('#positionTypeSelectBox').val();
                            if (positionTypeId!=null)
                            {
                                window.location="${discontinueLinkUrl}&position.positionId=" + positionTypeId;
                            }
                            // Stop event from propagating - otherwise redirect to this page again.
                            YAHOO.util.Event.preventDefault(event);
                        },null,true
                    );

                    YAHOO.util.Event.addListener("deleteLink","click",
                        function(event){
                            <stripes:url var="deleteLinkUrl" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManagePositionTypesActionBean" event="delete"/>
                            var positionTypeId=$('#positionTypeSelectBox').val();
                            if (positionTypeId!=null)
                            {
                                window.location="${deleteLinkUrl}&position.positionId=" + positionTypeId;
                            }
                            // Stop event from propagating - otherwise redirect to this page again.
                            YAHOO.util.Event.preventDefault(event);
                        },null,true
                    );
                    
        	        $(document).ready(function() {
        	            $("#positionDefinitionsIdsSelect").dropdownchecklist({emptyText: '<fmt:message key="label.please.select"/>', width: 300, maxDropHeight: 150});
        	        });
                });
            }
        </script>
    </stripes:layout-component>



</stripes:layout-render>