<%@ page import="au.com.toyota.nc.webapp.stripes.admin.ManageGroupActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<fmt:setBundle basename="nc-admin-resources" var="admin_resources" scope="page"/>
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/admin/nc-admin.css" />
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: maintain group page -->
       <div class="pageContent_main_header">
            <h1><fmt:message bundle="${admin_resources}" key="manage.group.header"/></h1>
        </div>


        <div id="groupSelectionSection" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                <c:import url="/WEB-INF/jsp/messages.jsp"/>

                <table id="groupTable" class="adminTable twoCols">
                    <td class="two_col_left listColumn">
                        <stripes:form id="groupForm" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageGroupActionBean">
                            <ul class="table-item-control-nav">
                                <li >
                                    <stripes:link id="addLink" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageGroupActionBean"
                                            event="addGroup">
                                        [ <fmt:message key="label.add"/> ]
                                    </stripes:link>
                                </li>

                                <c:set var="allGroups" value="${actionBean.allGroups}"/>

                                <%-- only display these menu items necessarily --%>
                               <c:if test="${fn:length(allGroups)>0}">
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

                            <%-- Dont display the list if there isnt any group --%>
                            <c:if test="${fn:length(allGroups)>0}">
                                <stripes:select name="group.groupId" id="groupSelectBox" class="containerFillingList" size="20">
                                    <stripes:options-collection collection="${allGroups}" label="name" value="groupId"/>
                                </stripes:select>
                            </c:if>
                        </stripes:form>
                    </td>


                    <td id="groupAddEditSection" class="two_col_right formColumn">
                        <c:if test="${actionBean.displayForm eq true}">
                            <div id="groupAddEditSection" class="form">
                                <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageGroupActionBean">
                                    <fieldset id="groupInfo-generalSection">
                                        <stripes:hidden name="group.groupId" id="groupId"/>
                                        <stripes:label name="group.name" for="group.name"/><stripes:text name="group.name"/><br/>
                                        <stripes:label name="label.abn" for="group.abn"/><stripes:text name="group.abn"/><br/>
                                        <stripes:label name="label.acn" for="group.acn"/><stripes:text name="group.acn"/><br/>
                                    </fieldset>
                                    <div class="clear"></div>

                                    <ul class="column-style-fieldset twoCols">
                                        <li>
                                            <fieldset id="groupInfo-streetAddressSection">
                                                <legend><fmt:message key="label.address.street.header"/></legend>
                                                <stripes:hidden name="group.contact.contactId"/>
                                                <stripes:label name="label.address1" for="group.contact.streetAddress.address1"/><stripes:text name="group.contact.streetAddress.address1"/><br/>
                                                <stripes:label name="label.address2" for="group.contact.streetAddress.address2"/><stripes:text name="group.contact.streetAddress.address2"/><br/>
                                                <stripes:label name="label.suburb" for="group.contact.streetAddress.suburb"/><stripes:text name="group.contact.streetAddress.suburb"/><br/>
                                                <stripes:label name="label.state" for="group.contact.streetAddress.state"/>
                                                <stripes:select name="group.contact.streetAddress.state">
                                                    <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                                    <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.State"/>
                                                </stripes:select><br/>
                                                <stripes:label name="label.postCode" for="group.contact.streetAddress.postCode"/><stripes:text name="group.contact.streetAddress.postCode"/><br/>
                                            </fieldset>
                                        </li>
                                        <li>
                                              <fieldset id="groupInfo-postalAddressSection">
                                                    <legend><fmt:message key="label.address.postal.header"/></legend>
                                                    <stripes:label name="label.address1" for="group.contact.postalAddress.address1"/><stripes:text name="group.contact.postalAddress.address1"/><br/>
                                                    <stripes:label name="label.address2" for="group.contact.postalAddress.address2"/><stripes:text name="group.contact.postalAddress.address2"/><br/>
                                                    <stripes:label name="label.suburb" for="group.contact.postalAddress.suburb"/><stripes:text name="group.contact.postalAddress.suburb"/><br/>
                                                    <stripes:label name="label.state" for="group.contact.postalAddress.state"/>
                                                    <stripes:select name="group.contact.postalAddress.state">
                                                        <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                                        <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.State"/>
                                                    </stripes:select><br/>
                                                    <stripes:label name="label.postCode" for="group.contact.postalAddress.postCode"/><stripes:text name="group.contact.postalAddress.postCode"/><br/>
                                                </fieldset>
                                        </li>
                                        <div class="clear"></div>
                                    </ul>
                                    <div class="clear"></div>

                                    <fieldset id="groupInfo-communicationSection">
                                        <legend>Communication</legend>
                                        <stripes:label name="label.website" for="group.contact.website"/><stripes:text name="group.contact.website"/><br/>
                                        <stripes:label name="label.email" for="group.contact.email"/><stripes:text name="group.contact.email"/><br/>
                                        <stripes:label name="label.phone" for="group.contact.phone"/><stripes:text name="group.contact.phone"/><br/>
                                        <stripes:label name="label.fax" for="group.contact.fax"/><stripes:text name="group.contact.fax"/><br/>
                                    </fieldset>
                                    <fieldset id="groupInfo-agreementSection">
                                        <legend>General</legend>
                                        <stripes:label name="label.companyStructure" for="group.companyStructure"/>
                                        <stripes:select name="group.companyStructure">
                                            <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.CompanyStructure"/>
                                        </stripes:select><br/>
                                        <stripes:label name="group.frameworkAgreementPresentFlag" for="group.frameworkAgreementPresentFlag"/><stripes:checkbox name="group.frameworkAgreementPresentFlag"/><br/>
                                        <stripes:label name="group.frameworkAgreementStart" for="group.frameworkAgreementStart"/>
                                        <nc:datetext name="group.frameworkAgreementStart"
                                                     id="group.frameworkAgreementStart"
                                                     buttonId="frameworkDateTrigger"
                                                     skipPermissions="true"/>
                                        <br/>
                                        <stripes:label name="group.frameworkAgreementTerm" for="group.frameworkAgreementTerm"/><stripes:text name="group.frameworkAgreementTerm"/><br/>
                                    </fieldset>
                                    <fieldset id="groupInfo-dateRangeSection">
                                        <legend>Termination Date</legend>
                                        <stripes:label name="label.endDate" for="group.dateRange.endDate"/>
                                        <nc:datetext name="group.dateRange.endDate"
                                                     id="group.dateRange.endDate"
                                                     buttonId="endDateTrigger"
                                                     skipPermissions="true"/>
                                        <div class="clear"></div>
                                    </fieldset>
                                   <div class="formActionButtons">
                                        <stripes:submit name="saveGroup" class="btn btn_save" value="Save" id="saveGroupButton"/>
                                       <input type="button" class="btn btn_cancel" value="Cancel" onclick="document.getElementById('groupAddEditSection').innerHTML = '';return false;"/>
                                       <div class="clear"></div>
                                   </div>
                                </stripes:form>
                            </div>
                        </c:if>
		                <div class="clear"></div>
		                <div class="clear"></div>
		                <div class="clear"></div>
		                <c:if test="${!actionBean.footerDisplayable}"> 
			                <c:if test="${(actionBean.group.userCn != null) && (actionBean.group.contact.maintenanceDate != null)}">
				                <div align="center">
					        		<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.group.contact.maintenanceDateAsString}"  />
					        	</div>
					        </c:if>	
						</c:if>
                    </td>
                </table>
            </div>
        </div>

    </stripes:layout-component>


    <stripes:layout-component name="yui-init-dependencies">
    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp"/>
        <c:if test="${actionBean.displayForm eq true}">
            <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarItem.jsp" inputField="group.frameworkAgreementStart" button="frameworkDateTrigger"/>
            <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarItem.jsp" inputField="group.dateRange.endDate" button="endDateTrigger"/>
        </c:if>

        <script type="text/javascript">
            function yuiLoadComplete(){
                YAHOO.util.Event.onDOMReady(function(){

                    YAHOO.util.Event.addListener("editLink","click",
                        function(event){
                            <c:url value="/admin/ManageGroup.action" var="url">
                                <c:param name="<%=ManageGroupActionBean.EVENT_GET%>"/>
                            </c:url>
                            var groupId=$('#groupSelectBox').val();
                            if (groupId!=null){
                                window.location="${url}&group.groupId="+groupId;
                            }else{
                                window.location="${url}";
                            }
                            // Stop event from propagating - otherwise redirect to this page again.
                            YAHOO.util.Event.preventDefault(event); 
                        },null,true
                   );

                    YAHOO.util.Event.addListener("discontinueLink","click",
                        function(event){
                            <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageGroupActionBean" event="discontinue"/>
                            var groupId=$('#groupSelectBox').val();
                            window.location="${url}&group.groupId="+groupId;
                            // Stop event from propagating - otherwise redirect to this page again.
                            YAHOO.util.Event.preventDefault(event);
                        },null,true
                   );

                    YAHOO.util.Event.addListener("deleteLink","click",
                        function(event){
                            <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageGroupActionBean" event="delete"/>
                            var groupId=$('#groupSelectBox').val();
                            window.location="${url}&group.groupId="+groupId;
                            // Stop event from propagating - otherwise redirect to this page again.
                            YAHOO.util.Event.preventDefault(event);
                        },null,true
                   );
                });
            }
        </script>
    </stripes:layout-component>



</stripes:layout-render>