<%@ page import="au.com.toyota.nc.common.model.hibernate.AbstractContact" %>
<%@ page import="au.com.toyota.nc.common.model.hibernate.DMSContactPerson" %>
<%@ page import="au.com.toyota.nc.common.model.hibernate.DMSProduct" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.admin.ManageDMSVendorActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<fmt:setBundle basename="nc-admin-resources" var="admin_resources" scope="page"/>
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/admin/nc-admin.css" />
    </stripes:layout-component>

    
    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: maintain dms vendor page -->
        <div class="pageContent_main_header">
             <h1><fmt:message bundle="${admin_resources}" key="manage.dmsvendor.header"/></h1>
         </div>

        <div id="maintainDMSVendorPage" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                <c:import url="/WEB-INF/jsp/messages.jsp"/>

                <table id="pmaTable" class="adminTable twoCols">
                    <tr>
                    <td class="two_col_left listColumn">
                        <stripes:form id="dmsVendorForm" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageDMSVendorActionBean">
                            <ul class="table-item-control-nav">
                                <li >
                                    <stripes:link id="addLink" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageDMSVendorActionBean"
                                            event="addVendor">
                                        <fmt:message key="label.add"/>
                                    </stripes:link>
                                </li>
                                <c:if test="${fn:length(actionBean.allVendors)>0}">
                                    <li>
                                        <a href="" id="editLink"> <fmt:message key="label.edit"/> </a>
                                    </li>
                                     <li>
                                        <a href="" id="deleteLink"> <fmt:message key="label.delete"/> </a>
                                     </li>
                                    <li>
                                        <a href="" id="discontinueLink"> <fmt:message key="label.discontinue"/> </a>
                                    </li>
                                </c:if>
                            </ul>
                            <c:if test="${fn:length(actionBean.allVendors)>0}">
                                <stripes:select name="vendor.dmsVendorId" id="dmsVendorSelectBox" class="containerFillingList" size="20">
                                    <stripes:options-collection collection="${actionBean.allVendors}" label="name" value="dmsVendorId"/>
                                </stripes:select>
                            </c:if>
                        </stripes:form>
                    </td>

                    <td id="dmsAddEditSection" class="two_col_right formColumn">
                        <c:if test="${actionBean.displayForm eq true}">
                            <div id="dmsVendorAddEditSection" class="form">
                                <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageDMSVendorActionBean">
                                    <fieldset id="dmsVendor-dmsVendorDetailsSection">
                                        <stripes:hidden name="vendor.dmsVendorId" id="vendorId"/>
                                        <stripes:label for="vendor.name"/><stripes:text id="vendor.name" name="vendor.name"/><br/>
                                        <stripes:label name="label.endDate" for="vendor.dateRange.endDate"/>
                                        <nc:datetext name="vendor.dateRange.endDate"
                                                     id="vendor.dateRange.endDate"
                                                     buttonId="endDateTrigger"
                                                     showTime="true"
                                                     class="dateField"
                                                     skipPermissions="true"/>
                                    </fieldset>

                                    <fieldset id="dmsVendor-dmsProductSection" class="tableEncapsulatingFieldSet">
                                        <a href="" id="addProductLink" class="addItemToTableLink"><fmt:message key="label.add"/></a>
                                        <legend><fmt:message key="vendor.product"/></legend>
                                        <table id="dmsProductTable">
                                            <tbody>
                                                <c:forEach items="${actionBean.vendor.products}" varStatus="dmsProductStatus" var="dmsProduct">
                                                <tr>
                                                        <td>
                                                          <stripes:hidden name="vendor.products[${dmsProductStatus.index}].dmsProductId"/>
                                                           <stripes:hidden name="vendor.products[${dmsProductStatus.index}].removedFromDealer"  class='removeFlagField'/>
                                                          <stripes:text name="vendor.products[${dmsProductStatus.index}].name"/>
                                                        </td>
                                                        <td>
                                                            <a id="deleteProduct-${dmsProductStatus.index}" href="" class="deleteLink"><fmt:message key="label.remove"/></a>
                                                        </td>
                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </fieldset>

                                    <fieldset id="dmsVendor-dmsContactSection" class="tableEncapsulatingFieldSet">
                                        <a href="" id="addContactLink" class="addItemToTableLink"><fmt:message key="label.add"/></a>
                                        <legend><fmt:message key="vendor.contact"/></legend>
                                        <table id="dmsContactTable">
                                            <thead>
                                                <tr>
                                                    <th><fmt:message key="vendor.contactPerson"/></th>
                                                    <th><fmt:message key="label.address1"/></th>
                                                    <th><fmt:message key="label.address2"/></th>
                                                    <th><fmt:message key="label.phone"/></th>
                                                    <th>&nbsp;</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${actionBean.vendor.contacts}" var="contact" varStatus="contactStatus">
                                                <tr>
                                                    <td>
                                                        <stripes:hidden name="vendor.contacts[${contactStatus.index}].dmsContactPersonId"/>
                                                        <stripes:hidden name="vendor.contacts[${contactStatus.index}].removedFromOwner" class="removeFlagField"/>
                                                        <stripes:text name="vendor.contacts[${contactStatus.index}].name"/>
                                                    </td>
                                                    <td>
                                                        <stripes:hidden name="vendor.contacts[${contactStatus.index}].contact.contactId"/>
                                                        <stripes:text name="vendor.contacts[${contactStatus.index}].contact.streetAddress.address1"/>
                                                    </td>
                                                    <td>
                                                        <stripes:hidden name="vendor.contacts[${contactStatus.index}].contact.contactId"/>
                                                        <stripes:text name="vendor.contacts[${contactStatus.index}].contact.streetAddress.address2"/>
                                                    </td>
                                                    <td>
                                                        <stripes:text name="vendor.contacts[${contactStatus.index}].contact.phone"/>
                                                    </td>
                                                    <td>
                                                        <a id="deleteContact-${contactStatus.index}" href="" class="deleteLink"><fmt:message key="label.remove"/></a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </fieldset>

                                    <div id="addDMSContactDialog" class="dialog">
                                        <div class="hd"><fmt:message key="label.add"/> <fmt:message key="vendor.contactPerson"/></div>
                                        <div class="bd">
                                                <fieldset>
                                                <label for="newContactPerson"><fmt:message key="vendor.contactPerson"/></label>
                                                <input type="text" id="newContactPerson" maxlength="<%=DMSContactPerson.MAX_NAME%>"/><br/>

                                                <label for="newContactAddressOne"><fmt:message key="label.address1"/></label>
                                                <input type="text" id="newContactAddressOne" maxlength="<%=AbstractContact.Address.MAX_ADDRESS1%>"/><br/>

                                                <label for="newContactAddressTwo"><fmt:message key="label.address2"/></label>
                                                <input type="text" id="newContactAddressTwo" maxlength="<%=AbstractContact.Address.MAX_ADDRESS2%>"/><br/>

                                                <label for="newContactPhone"><fmt:message key="label.phone"/></label>
                                                <input type="text" id="newContactPhone" maxlength="<%=AbstractContact.MAX_PHONE%>"/><br/>
                                                </fieldset>                                                    
                                        </div>
                                    </div>
                                    <div class="formActionButtons">
                                        <stripes:submit name="saveVendor" value="Save" id="saveVendorButton" class="btn btn_save"><fmt:message key="label.save"/></stripes:submit>
                                        <input type="button" class="btn btn_cancel" value="Cancel" onclick="document.getElementById('dmsAddEditSection').innerHTML = '';return false;"/>
                                        <div class="clear"></div>
                                    </div>
                                </stripes:form>
                            </div>
                        </c:if>
                        <div class="clear"></div>
                        <div class="clear"></div>
                        <div class="clear"></div>
                        <c:if test="${!actionBean.footerDisplayable}"> 
	                        <c:if test="${(actionBean.vendor != null) && (actionBean.vendor.maintenanceDate != null)}">
				                <div align="center">
					        		<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.vendor.maintenanceDateAsString}"  />
					        	</div>
				        	</c:if>
						</c:if>
                    </td>
                    </tr>
                </table>
            </div>
        </div>

    </stripes:layout-component>


    <stripes:layout-component name="yui-init-dependencies">
    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">
        <script type="text/javascript"src="${pageContext.request.contextPath}/js/nc-util.js"></script>
        <c:if test="${actionBean.displayForm eq true}">
            <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp"/>
            <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarItem.jsp" inputField="vendor.dateRange.endDate" button="endDateTrigger"/>
        </c:if>

        <script type="text/javascript">
            function yuiLoadComplete(){
                YAHOO.util.Event.onDOMReady(function(){

                    // Attach listener for editing existing DMS vendor
                    YAHOO.util.Event.addListener("editLink","click",
                        function(event){
                            <c:url value="/admin/ManageDMSVendor.action" var="url">
                                <c:param name="<%=ManageDMSVendorActionBean.EVENT_GET%>"/>
                            </c:url>
                            var dmsVendorId=$('#dmsVendorSelectBox').val();
                            if (dmsVendorId!=null){
                                window.location="${url}&vendor.dmsVendorId="+dmsVendorId;
                            }else{
                                window.location="${url}";
                            }
                            // Stop event from propagating - otherwise redirect to this page again.
                            YAHOO.util.Event.preventDefault(event);
                        },null,true
                   );

                    YAHOO.util.Event.addListener("discontinueLink","click",
                        function(event){
                            <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageDMSVendorActionBean" event="discontinue"/>
                            var dmsVendorId=$('#dmsVendorSelectBox').val();
                            window.location="${url}&vendor.dmsVendorId="+dmsVendorId;
                            // Stop event from propagating - otherwise redirect to this page again.
                            YAHOO.util.Event.preventDefault(event);
                        },null,true
                   );

                    YAHOO.util.Event.addListener("deleteLink","click",
                        function(event){
                            <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageDMSVendorActionBean" event="delete"/>
                            var dmsVendorId=$('#dmsVendorSelectBox').val();
                            window.location="${url}&vendor.dmsVendorId="+dmsVendorId;
                            // Stop event from propagating - otherwise redirect to this page again.
                            YAHOO.util.Event.preventDefault(event);
                        },null,true
                   );

                    // Attach listener for adding new DMS product
                    <c:if test="${actionBean.displayForm eq true}">
                        YAHOO.util.Event.addListener("addProductLink","click",
                             function(event){
                                 YAHOO.log("Adding new DMS product with index " + newIndex,"info");
                                 var newIndex=$("table#dmsProductTable tbody tr").length;
                                 $("<tr>"+
                                            "<td>"+
                                                  "<input type='hidden' name='vendor.products["+newIndex+"].dmsProductId'  />"+
                                                  "<input type='hidden' name='vendor.products["+newIndex+"].removedFromDealer' class='removeFlagField' />"+
                                                  "<input type='text' name='vendor.products["+newIndex+"].name' maxlength='<%=DMSProduct.MAX_NAME%>'/>"+
                                            "</td>"+
                                            "<td>"+
                                                    "<a id='deleteProduct-"+newIndex+"' href='' class='deleteLink'><fmt:message key="label.remove"/></a>"+
                                            "</td>"+
                                   "</tr>"
                                 ).appendTo("table#dmsProductTable tbody");
                                 attachDeleteBehaviourWithFlagField($("table#dmsProductTable tr:last-child a.deleteLink"));

                                // Stop event from propagating - otherwise redirect to this page again.
                                YAHOO.util.Event.preventDefault(event); 
                             },null,true
                        );


                        var addDMSContact = function(){
                            var newIndex=$("table#dmsContactTable tbody tr").length;
                            YAHOO.log("Adding new DMS contact with index " + newIndex,"info");
                            $("<tr>" +
                                    "<td>"+
                                            "<input type='hidden' name='vendor.contacts["+newIndex+"].dmsContactPersonId' />"+
                                            "<input type='hidden' name='vendor.contacts["+newIndex+"].removedFromOwner' class='removeFlagField'/>"+
                                            "<input type='text' name='vendor.contacts["+newIndex+"].name' maxlength='<%=DMSContactPerson.MAX_NAME%>' value='"+ $("#newContactPerson").val()+"'/>"+
                                    "</td>"+
                                    "<td>"+
                                            "<input type='hidden' name='vendor.contacts["+newIndex+"].contact.contactId' />"+
                                            "<input type='text' name='vendor.contacts["+newIndex+"].contact.streetAddress.address1' maxlength='<%=AbstractContact.Address.MAX_ADDRESS1%>'value='"+ $("#newContactAddressOne").val()+"'/>"+
                                    "</td>"+
                                    "<td>"+
                                            "<input type='hidden' name='vendor.contacts["+newIndex+"].contact.contactId' />"+
                                            "<input type='text' name='vendor.contacts["+newIndex+"].contact.streetAddress.address2' maxlength='<%=AbstractContact.Address.MAX_ADDRESS2%>'value='"+ $("#newContactAddressTwo").val()+"'/>"+
                                    "</td>"+
                                    "<td>"+
                                          "<input type='text' name='vendor.contacts["+newIndex+"].contact.phone' maxlength='<%=AbstractContact.MAX_PHONE%>' value='"+ $("#newContactPhone").val() +"'/>"+
                                    "</td>"+
                                    "<td>"+
                                            "<a id='deleteContact-"+newIndex+"' href='' class='deleteLink'><fmt:message key="label.remove"/></a>"+
                                    "</td>"+
                                "</tr>"
                            ).appendTo("table#dmsContactTable tbody");
                            attachDeleteBehaviourWithFlagField($("table#dmsContactTable tr:last-child a.deleteLink"));
                        };

                         <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                                dialogName="AddDMSContactDialog" dialogId="addDMSContactDialog" okHandler="addDMSContact"/>
                         <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                                htmlId="addContactLink" dialogName="AddDMSContactDialog"/>
                </c:if>

                    // Attach delete row behaviour for each delete row link
                    $("a.deleteLink").each(function(){
			            attachDeleteBehaviourWithFlagField($(this));
		            });
                });
            }
        </script>
    </stripes:layout-component>



</stripes:layout-render>