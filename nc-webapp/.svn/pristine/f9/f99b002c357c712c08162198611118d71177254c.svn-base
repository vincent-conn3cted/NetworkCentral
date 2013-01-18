<%@ page import="au.com.toyota.nc.webapp.stripes.admin.ManageTMCAFieldRepresentativesActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<fmt:setBundle basename="nc-admin-resources" var="admin_resources" scope="page"/>
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">


    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/admin/nc-admin.css" />
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: maintain tmca field rep page -->
        <div class="pageContent_main_header">
               <h1><fmt:message bundle="${admin_resources}" key="manage.tmcafieldreps.header"/></h1>
        </div>

        <div id="maintainTMCAFieldRepsPage" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                <fmt:message bundle="${admin_resources}" key="manage.tmcafieldreps.description"/>
                <c:import url="/WEB-INF/jsp/messages.jsp"/>

                <table id="tmcaFieldRepsTable" class="adminTable twoCols">
                        <tr>
                                <td class="two_col_left listColumn">
                                    <stripes:form id="commonValueForm" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageTMCAFieldRepresentativesActionBean">
                                        <ul class="table-item-control-nav">
                                            <li >
                                                <stripes:link id="addLink" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageTMCAFieldRepresentativesActionBean"
                                                    event="addTMCAFieldReps">
                                                    [ <fmt:message key="label.add"/> ]
                                                </stripes:link>
                                            </li>
                                            <c:if test="${fn:length(actionBean.allTMCAStaff) > 0 }">
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
                                        <c:if test="${fn:length(actionBean.allTMCAStaff) > 0 }">
                                            <stripes:select name="staff.personId" id="tmcaStaffSelectBox" class="containerFillingList" size="20">
                                                <stripes:options-collection collection="${actionBean.allTMCAStaff}" label="fullName" value="personId"/>
                                            </stripes:select>
                                        </c:if>
                                    </stripes:form>
                                </td>


                                <td id="tmcaFieldRepAddEditSection" class="two_col_right formColumn">
                                    <c:if test="${actionBean.displayForm eq true}">
                                    <div id="tmcaStaffAddEditSection" class="form">
                                        <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageTMCAFieldRepresentativesActionBean">
                                            <fieldset>
                                                <stripes:hidden name="staff.personId" id="personId"/>
                                                <stripes:hidden name="staff.contact.contactId" id="contactId"/>
                                                <stripes:label name="label.title" for="staff.title"/>
                                                <stripes:select name="staff.title" id="staff.title">
                                                    <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.Title" label="value"/>
                                                </stripes:select><br/>
                                                <stripes:label name="label.firstname" for="firstName"/><stripes:text name="staff.firstname" id="firstName"/><br/>
                                                <stripes:label name="label.surname" for="lastName"/><stripes:text name="staff.surname" id="lastName"/><br/>
                                                <stripes:label name="label.mobile" for="mobile"/><stripes:text name="staff.contact.mobile" id="mobile"/><br/>
                                                <stripes:label name="label.phone" for="phone"/><stripes:text name="staff.contact.phone" id="phone"/><br/>
                                                <stripes:label name="label.fax" for="fax"/><stripes:text name="staff.contact.fax" id="fax"/><br/>
                                                <stripes:label name="label.email" for="email"/><stripes:text name="staff.contact.email" id="email"/><br/>
                                                <stripes:label name="label.tmcapin" for="tmcaPIN"/><stripes:text name="staff.tmcaPIN" id="tmcaPIN"/><br/>
                                                <stripes:label name="label.endDate" for="staff.dateRange.endDate"/>
                                                <nc:datetext name="staff.dateRange.endDate"
                                                             id="staff.dateRange.endDate"
                                                             buttonId="endDateTrigger"
                                                             class="dateField"
                                                             skipPermissions="true"/>
                                                <div class="clear"></div>
                                            </fieldset>
                                              <div class="formActionButtons">
                                                    <stripes:submit name="saveTMCAFieldReps" value="Save" id="saveTmcaStaffButton" class="btn btn_save"/>
                                                  <input type="button" class="btn btn_cancel" value="Cancel" onclick="document.getElementById('tmcaFieldRepAddEditSection').innerHTML = '';return false;"/>
                                                  <div class="clear"></div>
                                              </div>
                                        </stripes:form>
                                    </div>
                                </c:if>
                                <div class="clear"></div>
                                <div class="clear"></div>
                                <div class="clear"></div>
                                <c:if test="${!actionBean.footerDisplayable}"> 
	                                <c:if test="${(actionBean.staff.userCn != null) && (actionBean.staff.contact.maintenanceDate != null) }">
						                <div align="center">
							        		<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.staff.contact.maintenanceDateAsString}"  />
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
                <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarItem.jsp" inputField="staff.dateRange.endDate" button="endDateTrigger"/>
            </c:if>
        


        <script type="text/javascript">
            function yuiLoadComplete(){
                YAHOO.util.Event.onDOMReady(function(){

                    YAHOO.util.Event.addListener("editLink","click",
                        function(event){
                            <c:url value="/admin/ManageTMCAFieldRepresentatives.action" var="url">
                                <c:param name="<%=ManageTMCAFieldRepresentativesActionBean.EVENT_GET%>"/>
                            </c:url>
                            var tmcaStaffId=$('#tmcaStaffSelectBox').val();
                            if (tmcaStaffId != null){
                                window.location = "${url}&staff.personId=" + tmcaStaffId;
                            }else{
                                window.location = "${url}";
                            }
                            // Stop event from propagating - otherwise redirect to this page again.
                            YAHOO.util.Event.preventDefault(event); 
                        },null,true
                   );

                    YAHOO.util.Event.addListener("deleteLink","click",
                        function(event){
                            <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageTMCAFieldRepresentativesActionBean" event="delete"/>
                            var tmcaStaffId=$('#tmcaStaffSelectBox').val();
                            window.location = "${url}&staff.personId=" + tmcaStaffId;
                            // Stop event from propagating - otherwise redirect to this page again.
                            YAHOO.util.Event.preventDefault(event);
                        },null,true
                   );
                    YAHOO.util.Event.addListener("discontinueLink","click",
                        function(event){
                            <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageTMCAFieldRepresentativesActionBean" event="discontinue"/>
                            var tmcaStaffId=$('#tmcaStaffSelectBox').val();
                            window.location = "${url}&staff.personId=" + tmcaStaffId;
                            // Stop event from propagating - otherwise redirect to this page again.
                            YAHOO.util.Event.preventDefault(event);
                        },null,true
                   );

                });
            }
        </script>
    </stripes:layout-component>

</stripes:layout-render>