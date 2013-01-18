<%@ page import="au.com.toyota.nc.common.model.hibernate.SpecialCondition" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-definition>
            <%-- ==========================================
             Secure page stuffs
             =============================================--%>
            <nc:pageName pageName="${pageName}"/>
             <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

                <nc:ifAccessAllowed name="dealer.specialConditions">
                       <ul class="column-style-fieldset oneCol">
                        <li>
                       <!--- ========================================================================
                        Start Special Condition stuffs
                        ========================================================================== -->
                        <fieldset id="legalInfo-specialConditionSection" class="tableEncapsulatingFieldSet">
                            <nc:ifPageViewMode mode="Edit">
                                <nc:ifAccessAllowed name="dealer.specialConditions.add">
                                    <c:if test="${fn:length(actionBean.allSpecialConditions) > 0}">
                                        <a href="" id="addSpecialConditionLink" class="addItemToTableLink">
                                            <fmt:message key="label.addItemToTable"/>
                                        </a>
                                    </c:if>
                                </nc:ifAccessAllowed>
                            </nc:ifPageViewMode>


                            <legend><fmt:message  key="dealer.specialConditions"/></legend>
                            <table id="specialConditionTable">
                                <thead>
                                    <tr>
                                        <th class="sc_number"><fmt:message  key="specialcondition.number"/></th>
                                        <th class="sc_type"><fmt:message  key="specialcondition.type"/></th>
                                        <th class="sc_details"><fmt:message  key="specialcondition.details"/></th>
                                        <th class="sc_date"><fmt:message  key="specialcondition.date.compliance"/></th>
                                        <th class="sc_manager"><fmt:message  key="specialcondition.regionalmanager"/></th>
                                        <th class="sc_flag"><fmt:message  key="specialcondition.completeflag"/></th>
                                        <th class="sc_status"><fmt:message key="specialcondition.status"/></th>
                                        <th class="sc_date"><fmt:message  key="specialcondition.date.completion"/></th>
                                        <th class="sc_comments"><fmt:message  key="specialcondition.comments"/></th>
                                        <nc:ifPageViewMode mode="Edit">
                                            <th class="controlColumn">&nbsp;</th>
                                        </nc:ifPageViewMode>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${actionBean.dealer.specialConditions}" var="sc" varStatus="scStatus">
                                        <tr class="itemRow">
                                            <td class="sc_number">
                                                <nc:hidden name="dealer.specialConditions[${scStatus.index}].specialConditionId" class="scIDField"/>
                                                <nc:text name="dealer.specialConditions[${scStatus.index}].number" readonly="true" class="scNumberField readonly" readOnlyClass="readonly scNumberField"/>
                                            </td>
                                            <td class="sc_type">
                                                <span class="scTypeDescriptionField">${sc.type.description}</span>
                                                <nc:hidden name="dealer.specialConditions[${scStatus.index}].type" class="scTypeField"/>
                                            </td>
                                            <td class="sc_details">
                                                <span class="scDetailsTruncatedField"><c:out value="${actionBean.dealer.specialConditions[scStatus.index].details}"/></span>
                                                <nc:hidden name="dealer.specialConditions[${scStatus.index}].details" class="scDetailsField" />
                                            </td>
                                            <td class="sc_date">
                                                <nc:text name="dealer.specialConditions[${scStatus.index}].complianceDate" readonly="true" class="scComplianceDateField readonly" readOnlyClass="readonly scComplianceDateField"/>
                                            </td>
                                            <td class="sc_manager">
                                                <nc:text  name="dealer.specialConditions[${scStatus.index}].regionalManagerResponsible" readonly="true" class="scRegMgrRespField readonly" readOnlyClass="readonly scRegMgrRespField"/>
                                            </td>
                                            <td class="sc_flag">
                                                <nc:checkbox  name="dealer.specialConditions[${scStatus.index}].completeFlag" class="scCompleteFlagField readonly"/>
                                            </td>
                                            <td class="sc_status">
                                                <nc:hidden name="dealer.specialConditions[${scStatus.index}].status" class="scStatusField"/>
                                                <span class="scStatusDescriptionField">${sc.status.description}</span>
                                            </td>
                                            <td class="sc_date">
                                                <nc:text name="dealer.specialConditions[${scStatus.index}].completionDate" readonly="true" class="readonly scCompletionDateField" readOnlyClass="readonly scCompletionDateField"/>
                                            </td>
                                            <td class="sc_comments">
                                                <nc:text name="dealer.specialConditions[${scStatus.index}].comments" readonly="true" class="readonly scCommentsField" readOnlyClass="readonly scCommentsField"/>
                                            </td>
                                            <nc:ifPageViewMode mode="Edit">
                                                <td class="controlColumn">
                                                    <nc:ifAccessAllowed name="dealer.specialConditions.edit">
                                                            <a href="" class="editLink"><fmt:message key="label.editItemInTable"/></a>
                                                    </nc:ifAccessAllowed>
                                                    <nc:ifAccessAllowed name="dealer.specialConditions.delete">
                                                            <nc:hidden name="dealer.specialConditions[${scStatus.index}].removedFromDealer" class='removeFlagField'/>
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
                    <div class="clear"></div>

                        <div id="specialConditionDetailsDialog" class="dialog">
                            <div class="hd"><fmt:message key="specialcondition.title"/></div>
                            <div class="bd">
                                <div id="specialConditionNumber">&nbsp;</div>
                                <div id="specialConditionType">&nbsp;</div>
                                <div id="nonTruncatedSpecialConditionDetails">&nbsp;</div>
                            </div>
                        </div>
                </nc:ifAccessAllowed>




    <nc:ifWriteAccessAllowed name="dealer.specialConditions">
            <div id="addSpecialConditionDialog" class="dialog">
                    <div class="hd"><fmt:message key="label.add"/>&nbsp;<fmt:message  key="dealer.specialConditions"/></div>
                    <div class="bd">
                        <%-- used for editing existing special number --%>
                        <input type="hidden" id="scRowBeingEdited" name="scRowBeingEdited"/>

                        <fieldset>
                            <label for="newSCNumber"><fmt:message  key="specialcondition.number"/></label>
                            <input type="text" id="newSCNumber" name="scNumber" maxlength="<%=SpecialCondition.MAX_NUMBER%>" /><br/>

                            <label for="newSCType"><fmt:message  key="specialcondition.type"/></label>
                            <select id="newSCType" name="scType">
                                <option value=""><fmt:message key="label.selectone"/></option>
                                <c:forEach items="${actionBean.allSpecialConditions}" var="sc">
                                    <option value="${sc}">${sc.description}</option>
                                </c:forEach>
                            </select><br/>

                            <label for="newSCDetails"><fmt:message  key="specialcondition.details"/></label>
                            <textarea rows="5" cols="20" name="scDetails" id="newSCDetails" >&nbsp;</textarea><br/>

                            <label for="newSCComplianceDate"><fmt:message  key="specialcondition.date.compliance"/></label>
                            <nc:datetext name="scComplianceDate"
                                         id="newSCComplianceDate"
                                         buttonId="scComplicanceDateTrigger"
                                         class="dateField"
                                         skipPermissions="true"/> <br/>
                            <label for="newSCRegionalFDResponsible"><fmt:message  key="specialcondition.regionalmanager"/></label>
                            <input type="text" id="newSCRegionalFDResponsible" name="scRegionalFDResponsible" maxlength="<%=SpecialCondition.MAX_REGIONAL_MANAGER_RESPONSIBLE%>"/><br/>

                            <label for="newSCCompleteFlag"><fmt:message  key="specialcondition.completeflag"/></label>
                            <input type="checkbox" id="newSCCompleteFlag" name="scCompleteFlag" value="true" checked="checked"/><br/>

                            <label for="newSCCompletionDate"><fmt:message  key="specialcondition.date.completion"/></label>
                            <nc:datetext name="scCompletionDate"
                                         id="newSCCompletionDate"
                                         buttonId="scCompletionDateTrigger"
                                         class="dateField"
                                         skipPermissions="true"/> <br/>
                             <label for="newSCStatus"><fmt:message key="specialcondition.status"/></label>
                               <select id="newSCStatus" name="scStatus">
                                   <c:forEach items="${actionBean.allSpecialConditionStatus}" var="scStatus">
                                       <option value="${scStatus}">${scStatus.description}</option>
                                   </c:forEach>
                               </select><br/>

                            <label for="newSCComments"><fmt:message  key="specialcondition.comments"/></label>
                            <textarea rows="5" cols="20" id="newSCComments" name="scComments">&nbsp;</textarea><br/>
                        </fieldset>
                    </div>
                </div>

    <script type="text/javascript">
            function editSpecialCondition(editedSC,event){
                    $("#scRowBeingEdited").val(editedSC.attr('rowIndex')-1); // html table rows start from 1

                    YAHOO.log("Editing special condition " +  $("#scRowBeingEdited").val(), "info");
                    $("#newSCNumber").val(editedSC.find(".scNumberField").val());
                     $("#newSCType").val(editedSC.find(".scTypeField").val());
                     $("#newSCDetails").val(editedSC.find(".scDetailsField").val());
                     $("#newSCComplianceDate").val(editedSC.find(".scComplianceDateField").val());
                     $("#newSCRegionalFDResponsible").val(editedSC.find(".scRegMgrRespField").val());
                     $("#newSCCompleteFlag").attr('checked', editedSC.find(".scCompleteFlagField").attr('checked'));
                     $("#newSCCompletionDate").val(editedSC.find(".scCompletionDateField").val());
                     $("#newSCStatus").val(editedSC.find(".scStatusField").val());
                     $("#newSCComments").val(editedSC.find(".scCommentsField").val());

                    checkAndSetCompletionDateValue();

                    YAHOO.au.com.toyota.widget.AddSpecialConditionDialog.show();
                }

             function initializeSpecialConditionDialog(){
                    var clearSpecialConditionOnDelete = function(deletedRow){
                            deletedRow.find("input.scNumberField,input.scDetailsField,input.comments,input.scRegMgrRespField").val("");
                    };

                    var addUpdateSpecialCondition = function(){
                        var editedRowIndex = $("#scRowBeingEdited").val();
                        var isEditing= (editedRowIndex!="");

                        var newIndex=$("table#specialConditionTable tbody tr").length;
                        var completeFlagVal=$("#newSCCompleteFlag").attr('checked');

                        if (isEditing){
                                YAHOO.log("Editing existing special condition","info");
                                var  rowBeingEdited=$($("table#specialConditionTable tbody tr")[editedRowIndex]);
                                rowBeingEdited.find(".scNumberField").val($("#newSCNumber").val());

                                rowBeingEdited.find(".scTypeField").val($("#newSCType").val());
                                rowBeingEdited.find(".scTypeDescriptionField").text($("#newSCType option:selected").text());

                                rowBeingEdited.find(".scDetailsField").val($("#newSCDetails").val());
                                rowBeingEdited.find(".scDetailsTruncatedField").text(truncate($("#newSCDetails").val(),200));
                                rowBeingEdited.find(".scComplianceDateField").val($("#newSCComplianceDate").val());
                                rowBeingEdited.find(".scRegMgrRespField").val($("#newSCRegionalFDResponsible").val());
                                rowBeingEdited.find(".scCompleteFlagField").attr('checked', $("#newSCCompleteFlag").attr('checked'));
                                rowBeingEdited.find(".scCompletionDateField").val($("#newSCCompletionDate").val());

                                rowBeingEdited.find(".scStatusDescriptionField").text($("#newSCStatus option:selected").text());
                                rowBeingEdited.find(".scStatusField").val($("#newSCStatus").val());

                                rowBeingEdited.find(".scCommentsField").val($("#newSCComments").val());
                        }else{
                            YAHOO.log("Adding new special condition","info");
                                    $("<tr class='itemRow'>"+
                                          "<td class='sc_number'>"+
                                                "<input type='hidden' name='dealer.specialConditions["+newIndex+"].specialConditionId' class='scIDField'/>"+
                                                "<input type='text' name='dealer.specialConditions["+newIndex+"].number' class='readonly scNumberField' readonly='readonly' value='"+ $("input#newSCNumber").val()+"' />"+
                                          "</td>"+
                                          "<td class='sc_type'>"+
                                                "<span class='scTypeDescriptionField'>"+$("select#newSCType option:selected").text() + "</span>"+
                                                "<input type='hidden' name='dealer.specialConditions["+newIndex+"].type' class='scTypeField' value='"+ $("select#newSCType").val() +"'/>"+
                                          "</td>"+
                                          "<td class='sc_details'>"+
                                                "<span class='scDetailsTruncatedField'>"+  truncate($("textarea#newSCDetails").val(),200) +"</span>"+
                                                "<input type='hidden' name='dealer.specialConditions["+newIndex+"].details' class='scDetailsField' value='"+ $("textarea#newSCDetails").val()+"'/>"+
                                          "</td>"+
                                          "<td class='sc_date'>"+
                                                "<input type='text' name='dealer.specialConditions["+newIndex+"].complianceDate' class='readonly scComplianceDateField' readonly='readonly' value='"+ $("input#newSCComplianceDate").val()+"'/>"+
                                          "</td>"+
                                          "<td class='sc_manager'>"+
                                                "<input type='text' name='dealer.specialConditions["+newIndex+"].regionalManagerResponsible' class='readonly scRegMgrRespField' readonly='readonly' value='"+ $("input#newSCRegionalFDResponsible").val()+"'/>"+
                                          "</td>"+
                                          "<td class='sc_flag'>"+
                                                (completeFlagVal ?
                                                    "<input type='checkbox' name='dealer.specialConditions["+newIndex+"].completeFlag'  class='scCompleteFlagField readonly' checked='checked''/>"
                                                :
                                                    "<input type='checkbox' name='dealer.specialConditions["+newIndex+"].completeFlag' class='scCompleteFlagField readonly'/>"
                                                )+
                                          "</td>"+
                                          "<td class='sc_status'>"+
                                                   "<span class='scStatusDescriptionField'>"+ $("select#newSCStatus option:selected").text() +"</span>"+
                                                   "<input type='hidden' name='dealer.specialConditions["+newIndex+"].status' class='scStatusField' value='"+ $("select#newSCStatus").val() +"' />"+
                                           "</td>"+
                                          "<td class='sc_date'>"+
                                                "<input type='text' name='dealer.specialConditions["+newIndex+"].completionDate' class='readonly scCompletionDateField' readonly='readonly' value='"+ $("input#newSCCompletionDate").val()+"'/>"+
                                          "</td>"+
                                          "<td class='sc_comments'>"+
                                                "<input type='text' name='dealer.specialConditions["+newIndex+"].comments' class='readonly scCommentsField' readonly='readonly' value='"+ $("textarea#newSCComments").val()+"'/>"+
                                          "</td>"+
                                          "<td class='controlColumn'>"+
                                               "<input type='hidden' name='dealer.specialConditions["+newIndex+"].removedFromDealer' />"+
                                               "<a href='' class='editLink'><fmt:message key="label.editItemInTable"/></a>"+
                                               "<a href='' class='deleteLink'><fmt:message key="label.removeItemInTable"/></a>"+
                                          "</td>"+
                                      "</tr>"
                                 ).appendTo("table#specialConditionTable tbody");

                                YAHOO.log("Attaching delete behaviour","info");
                                 attachDeleteBehaviourWithFlagField($("table#specialConditionTable tbody tr:last-child a.deleteLink"),clearSpecialConditionOnDelete);

                                YAHOO.log("Attaching edit behaviour","info");
                                attachTableColumnEditBehaviour($("table#specialConditionTable tr:last-child a.editLink"), editSpecialCondition);

                                YAHOO.log("Disable readonly checkboxes","info");
                                disableReadOnlyCheckboxes();

                                YAHOO.log("Attach popup dialog behaviour to new row","info");
                                attachSpecialConditionDetailsPopup($("table#specialConditionTable tbody tr:last-child td span.scDetailsTruncatedField"));
                        }
                    };
                     <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                        dialogName="AddSpecialConditionDialog"
                        dialogId="addSpecialConditionDialog"
                        okHandler="addUpdateSpecialCondition"/>

                   // Attach add special condition behaviour
                    var clearSpecialConditionDialogForAdding=function(){
                        YAHOO.log("Clearing special condition dialog","info");
                        $("#scRowBeingEdited").val("");
                         $("#newSCNumber").val("");
                         $("#newSCType").val("");
                         $("#newSCDetails").val("");
                         $("#newSCComplianceDate").val("");
                         $("#newSCRegionalFDResponsible").val("");
                         $("#newSCCompleteFlag").attr('checked', "");
                         $("#newSCCompletionDate").val("");
                         $("#newSCComments").val("");
                        $("#newSCStatus").val("");

                        // Disable completion date button, until user check the 'complete' flag
                        $("#scCompletionDateTrigger").attr('disabled',true);
                    };
                  <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                        htmlId="addSpecialConditionLink" dialogName="AddSpecialConditionDialog" extraMethod="clearSpecialConditionDialogForAdding"/>

                YAHOO.log("Attaching delete behaviour","info");
                 attachDeleteBehaviourWithFlagField($("table#specialConditionTable a.deleteLink"),clearSpecialConditionOnDelete);

                 YAHOO.log("Attaching edit behaviour","info");
                 attachTableColumnEditBehaviour($("table#specialConditionTable a.editLink"), editSpecialCondition);

                 disableReadOnlyCheckboxes();

                 $("#newSCCompleteFlag").change(function(){
                     checkAndSetCompletionDateValue();
                 });
            }

            /**
             * Completion date can only be set if the 'complete' flag is checked
             */
            function checkAndSetCompletionDateValue(){
               YAHOO.log("Checking completion date for special condition..","info");
               var checked= $("#newSCCompleteFlag").attr('checked');
                if (checked){
                    $("#scCompletionDateTrigger").attr('disabled',false);
                }else{
                    $("#scCompletionDateTrigger").attr('disabled',true);
                    $("#newSCCompletionDate").val("");
                }
            }


    </script>
</nc:ifWriteAccessAllowed>

    <script type="text/javascript">

        /**
        *  Initialize special condition details dialog. All special condition details are truncated, and
        *  enable user to view the details in a popup box.
        * */
        function initializeSpecialConditionDetailsDialog(){
               <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                            dialogName="SpecialConditionDetailsDialog" dialogId="specialConditionDetailsDialog"/>

            YAHOO.log("Truncate all special condition details","info");
            $(".scDetailsField").each(function(){
                $(this).closest("td").find(".scDetailsTruncatedField").text(truncate($(this).val(),200));
            });

            YAHOO.log("Attaching special condition detail dialogs","info");
            $(".scDetailsTruncatedField").each(function(){
                attachSpecialConditionDetailsPopup($(this));
            });
        }

        /**
         * Attach the special condition dialog, on clicking the given element
         * @param elem
         */
        function attachSpecialConditionDetailsPopup(elem){
           elem.click(function(event){
               YAHOO.log("Displaying special condition details dialog","info");
               $("#specialConditionNumber").text(
                        <nc:ifWriteAccessAllowed name="dealer.specialConditions[0].number">
                            $(this).closest("td").find(".scNumberField").val()
                       </nc:ifWriteAccessAllowed>
                        <nc:ifReadOnlyAccess name="dealer.specialConditions[0].number">
                            $(this).closest("td").find(".scNumberField").text()
                       </nc:ifReadOnlyAccess>
               );

                $("#specialConditionType").text(
                        <nc:ifWriteAccessAllowed name="dealer.specialConditions[0].type">
                                $(this).closest("td").find(".scTypeField").val()
                        </nc:ifWriteAccessAllowed>
                        <nc:ifReadOnlyAccess name="dealer.specialConditions[0].type">
                                $(this).closest("td").find(".scTypeField").text()
                        </nc:ifReadOnlyAccess>
                );

                $("#nonTruncatedSpecialConditionDetails").text(
                        <nc:ifWriteAccessAllowed name="dealer.specialConditions[0].details">
                                $(this).closest("td").find(".scDetailsField").val()
                        </nc:ifWriteAccessAllowed>
                        <nc:ifReadOnlyAccess name="dealer.specialConditions[0].details">
                                $(this).closest("td").find(".scDetailsField").text()
                        </nc:ifReadOnlyAccess>
               );
                YAHOO.au.com.toyota.widget.SpecialConditionDetailsDialog.show();
                YAHOO.util.Event.preventDefault(event);
            });
        }
    </script>


    <stripes:layout-component name="init-event-handling">
        <nc:ifWriteAccessAllowed name="dealer.specialConditions">
            <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarItem.jsp" inputField="newSCComplianceDate" button="scComplicanceDateTrigger"/>
            <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarItem.jsp" inputField="newSCCompletionDate" button="scCompletionDateTrigger"/>
        </nc:ifWriteAccessAllowed>
    </stripes:layout-component>

</stripes:layout-definition>