<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-definition>
        <%-- ==========================================
        Secure page stuffs
        =============================================--%>
        <nc:pageName pageName="${pageName}"/>
       <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

        <!-- ================================================================
            Start subscription stuffs
        =================================================================== -->
        <nc:ifAccessAllowed name="dealer.marketingSubscription">

        <ul class="column-style-fieldset oneCol">
            <li>
            <fieldset id="marketingInfo-subscriptionSection" class="tableEncapsulatingFieldSet">
                    <nc:ifPageViewMode mode="Edit">
                        <nc:ifAccessAllowed name="dealer.marketingSubscription.add">
                            <c:if test="${fn:length(actionBean.allMarketingSubscriptionType) > 0}">
                                <a href="" id="addSubscriptionLink" class="addItemToTableLink">
                                    <fmt:message key="label.addItemToTable"/>
                                </a>
                            </c:if>
                        </nc:ifAccessAllowed>
                    </nc:ifPageViewMode>

                    <br/>

                    <table id="subscriptionTable">
                        <thead>
                            <tr>
                                <th><fmt:message  key="subscription.name"/></th>
                                <th><fmt:message  key="subscription.tmcadivision"/></th>
                                <th><fmt:message  key="subscription.since"/></th>
                                <th><fmt:message  key="subscription.until"/></th>
                                <nc:ifPageViewMode mode="Edit">
                                    <th class="controlColumn">&nbsp;</th>
                                </nc:ifPageViewMode>
                            </tr>
                        </thead>
                        <tbody>
                                <c:forEach items="${actionBean.dealer.marketingSubscription}" var="subscription" varStatus="subStatus">
                                    <tr class="itemRow">
                                        <td>
                                            <nc:hidden name="dealer.marketingSubscription[${subStatus.index}].dealerMarketingSubId" />
                                            <nc:hidden name="dealer.marketingSubscription[${subStatus.index}].type.commonValueId" class="subscriptionTypeIdField"/>
                                            <nc:text name="dealer.marketingSubscription[${subStatus.index}].type.value" readonly="true" class="subscriptionTypeLabelField" readOnlyClass="subscriptionTypeLabelField"/>
                                        </td>
                                        <td>
                                            <nc:hidden name="dealer.marketingSubscription[${subStatus.index}].tmcaDivision" class="tmcaDivisionField"/>
                                            <span class="tmcaDivisionLabelField">${subscription.tmcaDivision}</span>
                                        </td>
                                        <td>
                                            <nc:text name="dealer.marketingSubscription[${subStatus.index}].subscriptionDate.startDate" readonly="true" class="startDateField" readOnlyClass="startDateField"/>
                                        </td>
                                         <td>
                                            <nc:text name="dealer.marketingSubscription[${subStatus.index}].subscriptionDate.endDate" readonly="true" class="endDateField" readOnlyClass="endDateField"/>
                                        </td>
                                        <nc:ifPageViewMode mode="Edit">
                                            <td class="controlColumn">
                                                <nc:ifAccessAllowed name="dealer.marketingSubscription.edit">
                                                        <a href="" class="editLink"><fmt:message key="label.editItemInTable"/></a>
                                                </nc:ifAccessAllowed>
                                                <nc:ifAccessAllowed name="dealer.marketingSubscription.delete">
                                                        <nc:hidden name="dealer.marketingSubscription[${subStatus.index}].removedFromDealer" class="removeFlagField"/>
                                                        <a href="" class="deleteLink"><fmt:message key="label.removeItemInTable"/></a>
                                                </nc:ifAccessAllowed>
                                            </td>
                                        </nc:ifPageViewMode>
                                    </tr>
                                </c:forEach>
                        </tbody>
                    </table>
                </fieldset>
                </li>
            </ul>
            <div class="clear">&nbsp;</div>
        </nc:ifAccessAllowed>


        <nc:ifWriteAccessAllowed name="dealer.marketingSubscription">
               <div id="addSubscriptionDialog" class="dialog">
                    <div class="hd"><fmt:message key="label.add"/><fmt:message  key="dealer.marketingSubscription"/></div>
                    <div class="bd">
                        <input type="hidden" id="subscriptionRowBeingEdited" name="subscriptionRowBeingEdited"/>

                        <fieldset>
                                <label for="subscriptionType"><fmt:message  key="subscription.name"/></label>
                                <select id="subscriptionType" name="subscriptionType">
                                    <c:forEach items="${actionBean.allMarketingSubscriptionType}" var="subscriptionType">
                                        <option value="${subscriptionType.commonValueId}">${subscriptionType.value}</option>
                                    </c:forEach>
                                </select><br/>

                                <label for="sinceDate"><fmt:message  key="subscription.since"/></label>
                                <nc:datetext name="sinceDate"
                                             id="sinceDate"
                                             buttonId="sinceDateTrigger"
                                             class="dateField"
                                             skipPermissions="true"/>
                                <br/>

                                <label for="untilDate"><fmt:message  key="subscription.until"/></label>
                                <nc:datetext name="untilDate"
                                             id="untilDate"
                                             buttonId="untilDateTrigger"
                                             class="dateField"
                                             skipPermissions="true"/>
                                <br/>
                                <label for="tmcaDivision"><fmt:message  key="subscription.tmcadivision"/></label>
                                <select id="tmcaDivision" name="tmcaDivision">
                                    <option id="selectTMCAOption" value=""><fmt:message key="label.selectone"/></option>
                                    <c:forEach items="${actionBean.allTMCADivision}" var="division">
                                        <option value="${division.value}">${division}</option>
                                    </c:forEach>
                                </select>
                        </fieldset>
                    </div>
                </div>
                <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarItem.jsp" inputField="sinceDate" button="sinceDateTrigger" />
                <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarItem.jsp" inputField="untilDate" button="untilDateTrigger" />
        </nc:ifWriteAccessAllowed>


    <script type="text/javascript">
        function editSubscription(editedSubscription, event){
            $("#subscriptionRowBeingEdited").val(editedSubscription.attr('rowIndex')-1); // html table rows start from 1

            YAHOO.log("Editing subscription " + $("#subscriptionRowBeingEdited").val(), "info");
            $("#subscriptionType").val(editedSubscription.find(".subscriptionTypeIdField").val());
            $("#sinceDate").val(editedSubscription.find(".startDateField").val());
            $("#untilDate").val(editedSubscription.find(".endDateField").val());
            $("#tmcaDivision").val(editedSubscription.find(".tmcaDivisionField").val());

            YAHOO.au.com.toyota.widget.AddSubscriptionDialog.show();
        }


        function initializeSubscriptionDialog(){
            var addSelectedSubscription = function(){
                var editedRowIndex = $("#subscriptionRowBeingEdited").val();
                var isEditing = (editedRowIndex!="");

                var newIndex=$("table#subscriptionTable tbody tr").length;
                var selectedValueId= $("select#subscriptionType").val();
                var selectedOption=$("select#subscriptionType option:selected").text();
                var tmcaDivisionValue = $("#tmcaDivision").val();
                var tmcaDivisionOption;

                  if (tmcaDivisionValue!= $("#selectTMCAOption").val()){
                      tmcaDivisionOption=$("#tmcaDivision option:selected").text();
                  }else{
                      tmcaDivisionOption="";
                  }
                var sinceDate = $("#sinceDate").val();
                var untilDate = $("#untilDate").val();

                if (isEditing){
                    YAHOO.log("Editing existing subscription","info");
                    var rowBeingEdited = $($("table#subscriptionTable tbody tr")[editedRowIndex]);
                    rowBeingEdited.find(".subscriptionTypeIdField").val(selectedValueId);
                    rowBeingEdited.find(".subscriptionTypeLabelField").val(selectedOption);
                    rowBeingEdited.find(".startDateField").val(sinceDate);
                    rowBeingEdited.find(".endDateField").val(untilDate);
                    rowBeingEdited.find(".tmcaDivisionField").val(tmcaDivisionValue);
                    rowBeingEdited.find(".tmcaDivisionLabelField").text(tmcaDivisionOption);
                }else{
                        YAHOO.log("Adding new subscription","info");
                        $(
                                "<tr class='itemRow'>"+
                                          "<td>"+
                                                  "<input type='hidden' name='dealer.marketingSubscription["+newIndex+"].dealerMarketingSubId'/>"+
                                                  "<input type='hidden' name='dealer.marketingSubscription["+newIndex+"].type.commonValueId' class='subscriptionTypeIdField' value='"+selectedValueId+"'/>"+
                                                  "<input type='text' name='dealer.marketingSubscription["+newIndex+"].type.value'  class='subscriptionTypeLabelField' readonly='readonly' value='"+selectedOption+"' />"+
                                          "</td>"+
                                          "<td>"+
                                                    "<input type='hidden' name='dealer.marketingSubscription["+newIndex+"].tmcaDivision' class='tmcaDivisionField' value='"+tmcaDivisionValue+"'/>"+
                                                    "<span class='tmcaDivisionLabelField'>"+tmcaDivisionOption+"</span>"+
                                          "</td>"+
                                          "<td>"+
                                                    "<input type='text' name='dealer.marketingSubscription["+newIndex+"].subscriptionDate.startDate' class='startDateField' readonly='readonly' value='"+sinceDate+"'/>"+
                                          "</td>"+
                                          "<td>"+
                                                    "<input type='text' name='dealer.marketingSubscription["+newIndex+"].subscriptionDate.endDate' class='endDateField' readonly='readonly' value='"+untilDate+"'/>"+
                                          "</td>"+
                                          "<td class='controlColumn'>"+
                                                    "<a href='' class='editLink'><fmt:message key="label.editItemInTable"/></a>"+
                                                    "<input type='hidden' name='dealer.marketingSubscription["+newIndex+"].removedFromDealer' class='removeFlagField'/>"+
                                                    "<a href='' class='deleteLink'><fmt:message key="label.removeItemInTable"/></a>"+
                                          "</td>"+
                                    "</tr>"
                        ).appendTo("table#subscriptionTable tbody");

                        YAHOO.log("Attaching delete behaviour","info");
                        attachDeleteBehaviourWithFlagField($("table#subscriptionTable tr:last-child a.deleteLink"));

                        YAHOO.log("Attaching edit behaviour","info");
                        attachTableColumnEditBehaviour($("table#subscriptionTable tr:last-child a.editLink"), editSubscription);
                }
            };

            <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                dialogName="AddSubscriptionDialog" dialogId="addSubscriptionDialog" okHandler="addSelectedSubscription"/>

            var clearSubscriptionDialogForAdding = function(){
                YAHOO.log("Clearing subscription dialog", "info");
                $("#subscriptionRowBeingEdited").val("");
                $("#subscriptionType").val("");
                $("#sinceDate").val("");
                $("#untilDate").val("");
                $("#tmcaDivision").val("");
            };

            <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                htmlId="addSubscriptionLink" dialogName="AddSubscriptionDialog" extraMethod="clearSubscriptionDialogForAdding"/>

            YAHOO.log("Attaching delete behaviour","info");
            attachDeleteBehaviourWithFlagField($("table#subscriptionTable a.deleteLink"));

            YAHOO.log("Attaching edit behaviour","info");
            attachTableColumnEditBehaviour($("table#subscriptionTable a.editLink"), editSubscription);
        }
    </script>


</stripes:layout-definition>