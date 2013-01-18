<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-definition>
    <%-- ==========================================
     Secure page stuffs
     =============================================--%>
    <nc:pageName pageName="${pageName}"/>
     <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

    <nc:ifAccessAllowed name="dealer.committees">
        <!--- =====================  Start Dealer Committee fieldset ======================== -->
        <ul class="column-style-fieldset oneCol">
        <li>
           <fieldset id="tmcaInfo-dealerSelectCommitteeSection" class="tableEncapsulatingFieldSet">
                   <nc:ifPageViewMode mode="Edit">
                       <nc:ifAccessAllowed name="dealer.committees.add">
                           <c:if test="${fn:length(actionBean.allCommittees) > 0 }">
                                <a href="" id="addDealerCommitteeLink" class="addItemToTableLink">
                                    <fmt:message key="label.addItemToTable"/>
                                </a>
                           </c:if>
                       </nc:ifAccessAllowed>
                   </nc:ifPageViewMode>


                    <legend><fmt:message  key="dealer.committees"/></legend>
                    <table id="dealerCommitteeTable">
                         <thead>
                            <tr>
                                <th><fmt:message key="committee.committeeName"/></th>
                                <th><fmt:message key="committee.currentFlag"/></th>
                                <th><fmt:message key="committee.previousFlag"/></th>
                                <th><fmt:message key="committee.membersName"/></th>
                                <th><fmt:message key="committee.role"/></th>
                                <th><fmt:message key="committee.validFrom"/></th>
                                <th><fmt:message key="committee.validTo"/></th>
                                <nc:ifPageViewMode mode="Edit">
                                    <th class="controlColumn">&nbsp;</th>
                                </nc:ifPageViewMode>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${actionBean.dealer.committees}" var="dealerCommittee" varStatus="committeeStatus">
                            <tr class="itemRow">
                                <td>
                                    <nc:hidden name="dealer.committees[${committeeStatus.index}].dealerCommitteeId" class="dealerCommitteeIdField"/>
                                    <nc:hidden name="dealer.committees[${committeeStatus.index}].committee.commonValueId" class="committeeIdField"/>
                                    <nc:text name="dealer.committees[${committeeStatus.index}].committee.value" readonly="true" class="readonly committeeValueField" readOnlyClass="committeeValueField"/>
                                </td>
                                <td>
                                         <c:choose>
                                             <c:when test="${dealerCommittee.currentFlag eq true}">
                                                      <span class="currentFlagField checkedImage checkboxImage"></span>
                                             </c:when>
                                             <c:otherwise>
                                                 <span class="currentFlagField unCheckedImage checkboxImage"></span>
                                             </c:otherwise>
                                        </c:choose>
                                        <nc:hidden name="dealer.committees[${committeeStatus.index}].currentFlag" class="currentFlagField"/>
                                </td>
                                <td>
                                         <c:choose>
                                             <c:when test="${dealerCommittee.previousFlag eq true}">
                                                      <span class="previousFlagField checkedImage checkboxImage"></span>
                                             </c:when>
                                             <c:otherwise>
                                                    <span class="previousFlagField unCheckedImage checkboxImage"></span>
                                             </c:otherwise>
                                        </c:choose>
                                        <nc:hidden name="dealer.committees[${committeeStatus.index}].previousFlag" class="previousFlagField"/>
                                </td>
                                <td>
                                        <nc:text name="dealer.committees[${committeeStatus.index}].memberName" readonly="true" class="readonly memberNameField" readOnlyClass="memberNameField"/>
                                </td>
                                <td>
                                        <nc:text name="dealer.committees[${committeeStatus.index}].role" readonly="true" class="readonly  roleField" readOnlyClass="roleField"/>
                                </td>
                                <td>
                                        <nc:text name="dealer.committees[${committeeStatus.index}].validDate.startDate" readonly="true" class="readonly startDateField" readOnlyClass="startDateField"/>
                                </td>
                                <td>
                                        <nc:text name="dealer.committees[${committeeStatus.index}].validDate.endDate" readonly="true" class="readonly endDateField" readOnlyClass="endDateField"/>
                                </td>
                                <nc:ifPageViewMode mode="Edit">
                                    <nc:ifWriteAccessAllowed name="dealer.committees">
                                        <td class="controlColumn">
                                            <nc:ifAccessAllowed name="dealer.committees.edit">
                                                    <a href="" class="editLink"><fmt:message key="label.editItemInTable"/></a>
                                            </nc:ifAccessAllowed>
                                            <nc:ifAccessAllowed name="dealer.committees.delete">
                                                    <nc:hidden name="dealer.committees[${committeeStatus.index}].removedFromDealer" class='removeFlagField'/>
                                                    <a href="" class="deleteLink"><fmt:message key="label.removeItemInTable"/></a>
                                            </nc:ifAccessAllowed>
                                        </td>
                                    </nc:ifWriteAccessAllowed>
                                </nc:ifPageViewMode>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
            </fieldset>
            </li>
        </ul>
        <!--- =====================  End Dealer Committee fieldset ======================== -->
    </nc:ifAccessAllowed>

    <nc:ifWriteAccessAllowed name="dealer.committees">
    <!--- =====================  Start Dealer Committee dialog   ======================== -->
     <div id="addDealerCommitteeDialog" class="dialog">
            <div class="hd"><fmt:message key="label.add"/>&nbsp;<fmt:message  key="dealer.committees"/></div>
            <div class="bd">
                <%-- used for editing existing dealer committee. If this field is populated, that means we are editing an existing one--%>
                <input type="hidden" id="committeeRowBeingEdited" name="committeeRowBeingEdited"/>

                <fieldset>
                    <label for="editDealerCommitteeSelectList"><fmt:message key="committee.committeeName"/></label>
                    <select id="editDealerCommitteeSelectList">
                        <c:forEach items="${actionBean.allCommittees}" var="committee">
                            <option value="${committee.commonValueId}">${committee.value}</option>
                        </c:forEach>
                    </select><br/>

                    <label for="editCurrentFlag"><fmt:message key="committee.currentFlag"/></label>
                    <input id="editCurrentFlag" type="checkbox"/><br/>

                    <label for="editPreviousFlag"><fmt:message key="committee.previousFlag"/></label>
                    <input id="editPreviousFlag" type="checkbox"/><br/>

                    <label for="editMembersName"><fmt:message key="committee.membersName"/></label>
                    <input id="editMembersName" type="text"/><br/>

                    <label for="editRole"><fmt:message key="committee.role"/></label>
                    <input id="editRole" type="text"/><br/>

                    <label for="editValidFrom"><fmt:message key="committee.validFrom"/></label>
                    <nc:datetext name="editValidFrom"
                                 id="editValidFrom"
                                 buttonId="validFromTrigger"
                                 skipPermissions="true"/>
                    <label for="editValidTo"><fmt:message key="committee.validTo"/></label>
                    <nc:datetext name="editValidTo"
                                 id="editValidTo"
                                 buttonId="validToTrigger"
                                 skipPermissions="true"/>
                </fieldset>
            </div>
        </div>
    <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarItem.jsp" inputField="editValidFrom" button="validFromTrigger" />
    <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarItem.jsp" inputField="editValidTo" button="validToTrigger" />
    <!--- =====================  End Dealer Committee dialog   ======================== -->


    <script type="text/javascript">
            function editDealerCommittee(editedDealerCommittee,event){
                    $("#committeeRowBeingEdited").val(editedDealerCommittee.attr('rowIndex')-1); // html table rows start from 1

                    YAHOO.log("Editing dealer committee "+ $("#committeeRowBeingEdited").val(),"info");
                    var committeeIdField = editedDealerCommittee.find(".committeeIdField").val();
                    $("#editDealerCommitteeSelectList").val(committeeIdField);
                    $("#editCurrentFlag").attr('checked', editedDealerCommittee.find("input.currentFlagField").val()=="true"?"checked":"");
                    $("#editPreviousFlag").attr('checked',editedDealerCommittee.find("input.previousFlagField").val()=="true"?"checked":"");
                    $("#editMembersName").val(editedDealerCommittee.find(".memberNameField").val());
                    $("#editRole").val(editedDealerCommittee.find(".roleField").val());
                    $("#editValidFrom").val(editedDealerCommittee.find(".startDateField").val());
                    $("#editValidTo").val(editedDealerCommittee.find(".endDateField").val());

                    YAHOO.au.com.toyota.widget.AddDealerCommitteeDialog.show();
                    YAHOO.util.Event.preventDefault(event);
              }


        function ${initializeDealerCommitteeFunctionName}(){
                       YAHOO.log("Initializing 'dealer committee'","info");

                       var addSelectedDealerCommittee = function(){
                           var editedRowIndex= $("#committeeRowBeingEdited").val();
                           var isEditing = (editedRowIndex!="");

                          var newIndex=$("table#dealerCommitteeTable tbody tr").length;
                          var selectedValueId=$("select#editDealerCommitteeSelectList").val();
                          var selectedOption=$("select#editDealerCommitteeSelectList option:selected").text();
                           var currentFlagVal=$("#editCurrentFlag").attr('checked');
                           var previousFlagVal=$("#editPreviousFlag").attr('checked');
                           var memberName=$("#editMembersName").val();
                           var role=$("#editRole").val();
                           var startDateVal=$("#editValidFrom").val();
                           var endDateVal=$("#editValidTo").val();


                           if (isEditing){
                               YAHOO.log("Editing existing dealer committee","info");
                               var rowBeingEdited = $($("table#dealerCommitteeTable tbody tr")[editedRowIndex]);
                               rowBeingEdited.find(".committeeIdField").val(selectedValueId);
                               rowBeingEdited.find(".committeeValueField").val(selectedOption);

                               var currentFlagFieldCheckBoxImage=rowBeingEdited.find("span.currentFlagField");
                               currentFlagFieldCheckBoxImage.removeClass("checkedImage unCheckedImage");
                               currentFlagFieldCheckBoxImage.addClass(currentFlagVal?"checkedImage":"unCheckedImage");
                               rowBeingEdited.find(".currentFlagField").val(currentFlagVal);

                               var previousFlagFieldCheckBoxImage=rowBeingEdited.find("span.previousFlagField");
                               previousFlagFieldCheckBoxImage.removeClass("checkedImage unCheckedImage");
                               previousFlagFieldCheckBoxImage.addClass(previousFlagVal?"checkedImage":"unCheckedImage");
                               rowBeingEdited.find(".previousFlagField").val(previousFlagVal);

                               rowBeingEdited.find(".memberNameField").val(memberName);
                               rowBeingEdited.find(".roleField").val(role);
                               rowBeingEdited.find(".startDateField").val(startDateVal);
                               rowBeingEdited.find(".endDateField").val(endDateVal);
                           }else{
                               YAHOO.log("Adding new dealer committee","info");
                                          $("<tr><td>"+
                                                "<input type='hidden' name='dealer.committees["+newIndex+"].dealerCommitteeId' class='dealerCommitteeIdField'/>"+
                                                "<input type='hidden' name='dealer.committees["+newIndex+"].committee.commonValueId' class='committeeIdField' value='"+selectedValueId+"'/>"+
                                                "<input type='text' name='dealer.committees["+newIndex+"].committee.value' readonly='readonly' class='readonly committeeValueField' value='"+selectedOption+"'/>"+
                                            "</td>"+
                                            "<td>"+
                                                    "<span class='currentFlagField checkboxImage " + (currentFlagVal?"checkedImage":"unCheckedImage") + "'/>"+
                                                    "<input type='hidden'  name='dealer.committees["+newIndex+"].currentFlag' class='currentFlagField' value='"+currentFlagVal+"'/>"
                                            +"</td>"+
                                            "<td>"+
                                                    "<span class='previousFlagField checkboxImage " + (previousFlagVal?"checkedImage":"unCheckedImage")+ "'/>"+
                                                    "<input type='hidden'  name='dealer.committees["+newIndex+"].previousFlag' class='previousFlagField' value='"+previousFlagVal+"'/>"
                                            +"</td>"+
                                            "<td>"+
                                                    "<input type='text' name='dealer.committees["+newIndex+"].memberName' readonly='readonly' class='readonly memberNameField' value='"+ memberName +"'/>"+
                                            "</td>"+
                                            "<td>"+
                                                    "<input type='text' name='dealer.committees["+newIndex+"].role' readonly='readonly' class='readonly roleField' value='"+ role +"'/>"+
                                            "</td>"+
                                            "<td>"+
                                                    "<input type='text'  name='dealer.committees["+newIndex+"].validDate.startDate'  readonly='readonly' class='readonly startDateField' value='"+ startDateVal +"'/>"+
                                            "</td>"+
                                            "<td>"+
                                                    "<input type='text'  name='dealer.committees["+newIndex+"].validDate.endDate' readonly='readonly' class='readonly endDateField' value='"+endDateVal +"'/>"+
                                            "</td>"+
                                            "<td class='controlColumn'>"+
                                                    "<input type='hidden' name='dealer.committees["+newIndex+"].removedFromDealer' class='removeFlagField'/>"+
                                                  "<a href='' class='editLink'><fmt:message key="label.editItemInTable"/></a>"+
                                                  "<a href='' class='deleteLink'><fmt:message key="label.removeItemInTable"/></a>"+
                                            "</td>"+
                                            "</tr>").appendTo("table#dealerCommitteeTable tbody");

                               YAHOO.log("Attaching delete button behaviour to newly added 'dealer committee'","info");
                               attachDeleteBehaviourWithFlagField($("table#dealerCommitteeTable tr:last-child a.deleteLink"));

                               YAHOO.log("Attaching edit button behaviour to newly added 'dealer committee'","info");
                               attachTableColumnEditBehaviour($("table#dealerCommitteeTable tr:last-child a.editLink"), editDealerCommittee);

                               YAHOO.log("Disabling read only checkboxes","info");
                               disableReadOnlyCheckboxes();

                               YAHOO.log("Finished adding new 'dealer committee'","info");
                           }
                      };

                      YAHOO.log("Creating 'dealer committee' dialog","info");
                      <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                              dialogName="AddDealerCommitteeDialog"  dialogId="addDealerCommitteeDialog" okHandler="addSelectedDealerCommittee"/>

                      var clearDealerCommitteDialogForAdding = function(){
                            YAHOO.log("Clearning dealer committee dialog","info");
                            $("#committeeRowBeingEdited").val("");
                            $("#editDealerCommitteeSelectList").val("");
                            $("#editCurrentFlag").attr('checked',false);
                            $("#editPreviousFlag").attr('checked',false);
                            $("#editMembersName").val("");
                            $("#editRole").val("");
                            $("#editValidFrom").val("");
                            $("#editValidTo").val("");
                      };

                      YAHOO.log("Attaching popup listener for adding 'dealer committee'","info");
                      <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                              htmlId="addDealerCommitteeLink" dialogName="AddDealerCommitteeDialog" extraMethod="clearDealerCommitteDialogForAdding"/>

                        YAHOO.log("Attaching delete button behaviour to 'dealer committee'","info");
                        attachDeleteBehaviourWithFlagField($("table#dealerCommitteeTable a.deleteLink"));

                        YAHOO.log("Attaching popup listener for editing 'dealer committee'","info");
                        attachTableColumnEditBehaviour($("table#dealerCommitteeTable a.editLink"), editDealerCommittee);

                        YAHOO.log("Finished initializing 'dealer committee'","info");
                  }
    </script>
    </nc:ifWriteAccessAllowed>
</stripes:layout-definition>
