<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<fmt:setBundle basename="nc-admin-resources" var="admin_resources" scope="page"/>
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    

    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/admin/nc-admin.css" />
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: maintain drop down lists page -->
        <div class="pageContent_main_header">
            <h1><fmt:message bundle="${admin_resources}" key="manage.dropdown.header"/></h1>
        </div>


        <div id="manageDropDownListValues" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                <stripes:form id="commonValueForm" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageCommonValuesActionBean">
                    <c:import url="/WEB-INF/jsp/messages.jsp"/>

                    <table class="adminTable threeCols">
                        <tbody>
                            <td id="commonValueSelectionSection" class="three_col_left">
                                <stripes:select name="selectedType" id="cvTypeSelectBox" class="containerFillingList" size="20">
                                    <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.CommonValueTypes" label="displayName"/>
                                </stripes:select>
                            </td>

                            <td id="commonValueDetailSection" class="three_col_center">
                                    <c:if test="${actionBean.selectedType ne null}">
                                            <c:set var="valuesForType" value="${actionBean.valuesForType}"/>
                                            <h3 id="commonValueTypeLabel">${actionBean.selectedType.displayName}</h3>
                                            <ul id="commonValueNavigation" class="table-item-control-nav">
                                                <li>
                                                        <a href="" id="addLink">[ <fmt:message key="label.add"/> ]</a>
                                                </li>
                                                <c:if test="${fn:length(valuesForType) > 0}">
                                                    <li>
                                                            <a href=""  id="editLink">[ <fmt:message key="label.edit"/> ]</a>
                                                    </li>
                                                    <li>
                                                        <a href="" id="deleteLink">[ <fmt:message key="label.delete"/> ]</a>
                                                    </li>
                                                    <li>
                                                        <a href="" id="discontinueLink">[ <fmt:message key="label.discontinue"/> ]</a>
                                                    </li>
                                                </c:if>
                                            </ul>
                                                <c:if test="${fn:length(valuesForType) > 0}">
                                                    <stripes:select name="" id="cvValuesSelectBox" class="containerFillingList" size="15">
                                                        <stripes:options-collection collection="${valuesForType}" value="commonValueId" label="value"/>
                                                    </stripes:select>
                                                </c:if>
                                        </c:if>
                                </td>
                                <td id="commonValueAddEditSection" class="three_col_right formColumn">
                                    <c:if test="${actionBean.displayForm eq true}">
                                        <div class="form">
                                                <fieldset>
                                                    <stripes:hidden name="saveEditRequest.selectedType" id="saveEditRequest.commonValueType"/>
                                                    <stripes:hidden name="saveEditRequest.commonValueId" id="saveEditRequest.commonValueId"/>
                                                    <stripes:label for="saveEditRequest.code"/><stripes:text name="saveEditRequest.code" id="saveEditRequest.code"/><br/>
                                                    <stripes:label for="saveEditRequest.description"/><stripes:text name="saveEditRequest.description" id="saveEditRequest.description"/><br/>
                                                    <stripes:label name="label.startDate" for="saveEditRequest.startDate"/>
                                                    <nc:datetext name="saveEditRequest.startDate"
                                                                 id="saveEditRequest.startDate"
                                                                 buttonId="startDateTrigger"
                                                                 showTime="true"
                                                                 skipPermissions="true"/><br/>
                                                    <stripes:label name="label.endDate" for="saveEditRequest.endDate"/>
                                                    <nc:datetext name="saveEditRequest.endDate"
                                                                 id="saveEditRequest.endDate"
                                                                 buttonId="endDateTrigger"
                                                                 showTime="true"
                                                                 skipPermissions="true"/>
                                                </fieldset>
                                                <stripes:submit id="commonValueAddEditSectionSaveButton" name="saveValuesForType" value="Save" class="btn btn_save">
                                                    <fmt:message key="label.save"/>
                                                </stripes:submit>
                                                <input type="button" class="btn btn_cancel" value="Cancel" onclick="document.getElementById('commonValueAddEditSection').innerHTML = '';return false;"/>
                                        </div>
                                        <div class="clear"></div>
                                        <div class="clear"></div>
                                        <div class="clear"></div>
                                        <c:if test="${!actionBean.footerDisplayable}"> 
	                                        <c:if test="${actionBean.saveEditRequest.commonValueId != null }">
		                                        <div id="dropDownFooter">
			        								<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.saveEditRequest.modifiedDate}"  />
			        							</div>
		        							</c:if>
										</c:if>
                                    </c:if>
                                </td>

                            </tbody>
                        </table>


                        <div class="clear"></div>
                </stripes:form>
            </div>
        </div>
    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">
                <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp"/>
              <c:if test="${actionBean.displayForm eq true}">
                  <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarItem.jsp" inputField="saveEditRequest.startDate" button="startDateTrigger"/>
                  <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarItem.jsp" inputField="saveEditRequest.endDate" button="endDateTrigger"/>
              </c:if>

              <script type="text/javascript">
                  function changeSelectedCommonValueType(){
                      <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageCommonValuesActionBean" event="getValuesForType"/>
                      window.location="${url}&selectedType="+$("#cvTypeSelectBox").val();
                  }

                  function yuiLoadComplete(){
                        YAHOO.log("Attaching change behaviour on common value select box","info");
                        $("#cvTypeSelectBox").change(changeSelectedCommonValueType);


                       YAHOO.log("Attaching add behaviour on add link","info");
                        $("#addLink").click(function(event){
                            <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageCommonValuesActionBean" event="addCommonValue"/>
                            var selectedType=$("#cvTypeSelectBox").val();
                            window.location="${url}&selectedType="+selectedType;
                            YAHOO.util.Event.preventDefault(event);
                        });


                       YAHOO.log("Attaching edit behaviour on edit  link","info");
                        $("#editLink").click(function(event){
                            <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageCommonValuesActionBean" event="getValue"/>
                            var commonValueId= $("#cvValuesSelectBox").val();
                            var selectedType = $("#cvTypeSelectBox").val();

                            <%-- need to pass  in sourcePage, for error in validation --%>
                            window.location="${url}&selectedType="+selectedType + "&selectedCommonValueId="+(commonValueId!=null?commonValueId:"")+"&_sourcePage="+$("input[name='_sourcePage']").val();
                            YAHOO.util.Event.preventDefault(event);
                        });

                       YAHOO.log("Attaching discontinue behaviour on discontinue link","info");
                        $("#discontinueLink").click(function(event){
                            <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageCommonValuesActionBean" event="discontinue"/>
                            var commonValueId= $("#cvValuesSelectBox").val();
                            var selectedType = $("#cvTypeSelectBox").val();

                            <%-- need to pass  in sourcePage, for error in validation --%>
                            window.location="${url}&selectedType="+selectedType + "&selectedCommonValueId=" + commonValueId;
                            YAHOO.util.Event.preventDefault(event);
                        });

                      YAHOO.log("Attaching delete behaviour on delete link","info");
                       $("#deleteLink").click(function(event){
                           <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageCommonValuesActionBean" event="delete"/>
                           var commonValueId= $("#cvValuesSelectBox").val();
                           var selectedType = $("#cvTypeSelectBox").val();

                           <%-- need to pass  in sourcePage, for error in validation --%>
                           window.location="${url}&selectedType="+selectedType + "&selectedCommonValueId=" + commonValueId;
                           YAHOO.util.Event.preventDefault(event);
                       });
                  }
              </script>
    </stripes:layout-component>



</stripes:layout-render>