<%@ page import="au.com.toyota.nc.webapp.stripes.admin.ManagePMAActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<fmt:setBundle basename="nc-admin-resources" var="admin_resources" scope="page"/>
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/admin/nc-admin.css" />
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: maintain pma page -->
        <div class="pageContent_main_header">
            <h1><fmt:message bundle="${admin_resources}" key="manage.pma.header"/></h1>
        </div>

        <div id="pmaSelectionSection" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                    <c:import url="/WEB-INF/jsp/messages.jsp"/>

                    <table id="pmaTable" class="adminTable twoCols">
                        <tr>
                         <td class="two_col_left listColumn">
                                <stripes:form id="pmaForm" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManagePMAActionBean">
                                    <ul class="table-item-control-nav">
                                        <li>
                                            <stripes:link id="addLink" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManagePMAActionBean"
                                                    event="addPMA">[ <fmt:message key="label.add"/> ]</stripes:link>
                                        </li>
                                        <c:if test="${fn:length(actionBean.allPMA) > 0}">
                                            <li >
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
                                    <c:if test="${fn:length(actionBean.allPMA) > 0}">
                                        <stripes:select name="pma.pmaId" id="pmaTypeSelectBox" class="containerFillingList" size="20">
                                            <stripes:options-collection collection="${actionBean.allPMA}" label="name" value="pmaId"/>
                                        </stripes:select>
                                    </c:if>
                                </stripes:form>
                            </td>

                            <td id="pmaAddEditSection" class="two_col_right formColumn">
                                <c:if test="${actionBean.displayForm eq true}">
                                     <div class="form">
                                        <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.admin.ManagePMAActionBean">
                                            <fieldset>
                                                <stripes:hidden name="pma.pmaId" id="pmaId"/>
                                                <stripes:label for="pma.code"/><stripes:text name="pma.code" id="pma.code"/><br/>
                                                <stripes:label for="pma.name"/><stripes:text name="pma.name" id="pma.name"/><br/>
                                                <stripes:label name="label.startDate" for="pma.dateRange.startDate"/>
                                                <nc:datetext name="pma.dateRange.startDate"
                                                             id="pma.dateRange.startDate"
                                                             buttonId="startDateTrigger"
                                                             skipPermissions="true"/>
                                                <br/>
                                                <stripes:label name="label.endDate" for="pma.dateRange.endDate"/>
                                                <nc:datetext name="pma.dateRange.endDate"
                                                             id="pma.dateRange.endDate"
                                                             buttonId="endDateTrigger"
                                                             skipPermissions="true"/>
                                                <div class="clear"></div>
                                            </fieldset>
                                            <div class="formActionButtons">
                                                <stripes:submit name="savePMA" value="Save" id="savePMAButton" class="btn btn_save">
                                                    <fmt:message key="label.save"/>
                                                </stripes:submit>
                                                <input type="button" class="btn btn_cancel" value="Cancel" onclick="document.getElementById('pmaAddEditSection').innerHTML = '';return false;"/>
                                                <div class="clear"></div>
                                            </div>
                                        </stripes:form>
                                    </div>
                                </c:if>
                                <div class="clear"></div>
                                <div class="clear"></div>
                                <div class="clear"></div>
                                <c:if test="${!actionBean.footerDisplayable}"> 
	                                <c:if test="${(actionBean.pma != null) && (actionBean.lastMaintainedUserNameFromLDAP != null) && (actionBean.pma.maintenanceDateAsString != null)}">
					                    <div id="dropDownFooter">
						        			<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.pma.maintenanceDateAsString}"  />
						        		</div>
						        	</c:if>
								</c:if>
                            </td>
                        </tr>
                    </table>
                </div>
        </div>
    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp"/>
        <c:if test="${actionBean.displayForm eq true}">
            <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarItem.jsp" inputField="pma.dateRange.startDate" button="startDateTrigger"/>
            <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarItem.jsp" inputField="pma.dateRange.endDate" button="endDateTrigger"/>
        </c:if>
        <script type="text/javascript">

            function yuiLoadComplete(){
                YAHOO.util.Event.onDOMReady(function(){

                    YAHOO.util.Event.addListener("editLink","click",
                        function(event){
                            <c:url value="/admin/ManagePMA.action" var="url">
                                <c:param name="<%=ManagePMAActionBean.EVENT_GET%>"/>
                            </c:url>
                            var pmaId=$('#pmaTypeSelectBox').val();
                            if (pmaId!=null){
                                window.location="${url}&pma.pmaId="+pmaId;
                            }else{
                                window.location="${url}";
                            }
                            // Stop event from propagating - otherwise redirect to this page again.
                            YAHOO.util.Event.preventDefault(event); 
                        },null,true
                   );

                    YAHOO.util.Event.addListener("discontinueLink","click",
                        function(event){
                            <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManagePMAActionBean" event="discontinue"/>
                            var pmaId=$('#pmaTypeSelectBox').val();
                            window.location="${url}&pma.pmaId="+pmaId;
                            // Stop event from propagating - otherwise redirect to this page again.
                            YAHOO.util.Event.preventDefault(event);
                        },null,true
                   );

                    YAHOO.util.Event.addListener("deleteLink","click",
                        function(event){
                            <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManagePMAActionBean" event="delete"/>
                            var pmaId=$('#pmaTypeSelectBox').val();
                            window.location="${url}&pma.pmaId="+pmaId;
                            // Stop event from propagating - otherwise redirect to this page again.
                            YAHOO.util.Event.preventDefault(event);
                        },null,true
                   );
                });
            }
        </script>
    </stripes:layout-component>



</stripes:layout-render>