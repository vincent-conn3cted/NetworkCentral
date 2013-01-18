<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-definition>
    <%-- ==========================================
     Secure page stuffs
     =============================================--%>
    <nc:pageName pageName="${pageName}"/>
     <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
       
        <nc:ifAccessAllowed name="dealer.otherFranchise">
            <!--- =====================  Start Other Franchise fieldset ======================== -->
            <ul class="column-style-fieldset oneCol">
                <li>
                        <fieldset id="tmcaInfo-otherFranchiseSection" class="tableEncapsulatingFieldSet">
                            <nc:ifPageViewMode mode="Edit">
                                <nc:ifAccessAllowed name="dealer.otherFranchise.add">
                                    <c:if test="${fn:length(actionBean.allOtherFranchise) > 0}">
                                        <a href="" id="addOtherFranchiseLink" class="addItemToTableLink">
                                            <fmt:message key="label.addItemToTable"/>
                                        </a>
                                    </c:if>
                                </nc:ifAccessAllowed>
                            </nc:ifPageViewMode>


                            <legend><fmt:message  key="dealer.otherFranchise"/></legend>
                            <table id="otherFranchiseTable">
                                <tbody>
                                <c:forEach items="${actionBean.dealer.otherFranchise}" var="otherFranchise" varStatus="otherFranchiseStatus">
                                    <tr class="itemRow">
                                        <td>
                                            <nc:hidden name="dealer.otherFranchise[${otherFranchiseStatus.index}].otherFranchiseId" class="dealerOtherFranchiseIdField"/>
                                            <nc:hidden name="dealer.otherFranchise[${otherFranchiseStatus.index}].type.commonValueId" class="otherFranchiseIdField"/>
                                            <nc:text name="dealer.otherFranchise[${otherFranchiseStatus.index}].type.value" readonly="true" class="otherFranchiseValueField readonly" readOnlyClass="readonly otherFranchiseValueField"/>
                                        </td>
                                        <nc:ifPageViewMode mode="Edit">
                                            <td class="controlColumn">
                                                <nc:ifAccessAllowed name="dealer.otherFranchise.edit">
                                                    <a href="" class="editLink"><fmt:message key="label.editItemInTable"/></a>
                                                </nc:ifAccessAllowed>
                                                <nc:ifAccessAllowed name="dealer.otherFranchise.delete">
                                                    <c:if test="${fn:length(otherFranchise.locationSharedFacilities) == 0}">
                                                        <nc:hidden name="dealer.otherFranchise[${otherFranchiseStatus.index}].removedFromDealer"  class='removeFlagField'/>
                                                        <a href="" class="deleteLink" id="deleteOtherFranchise-${otherFranchise.otherFranchiseId}-Link"><fmt:message key="label.removeItemInTable"/></a>
                                                    </c:if>
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
            <!--- =====================  End Other Franchise fieldset ======================== -->
    </nc:ifAccessAllowed>


    <nc:ifWriteAccessAllowed name="dealer.otherFranchise">
    <!--- =====================  Start Other Franchise Dialog ======================== -->
                <div id="addOtherFranchiseDialog" class="dialog">
                    <div class="hd"><fmt:message key="label.add"/><fmt:message  key="dealer.otherFranchise"/></div>
                    <div class="bd">
                        <%-- used for editing existing franchise --%>
                        <input type="hidden" id="franchiseBeingEdited" name="franchiseBeingEdited"/>

                         <nc:ifAccessAllowed name="dealer.otherFranchise[0].type.commonValueId">
                             <label for="editOtherFranchiseType"><fmt:message key="otherFranchise.franchiseName"/></label>
                         </nc:ifAccessAllowed>
                         <nc:ifWriteAccessAllowed name="dealer.otherFranchise[0].type.commonValueId">
                                <select id="editOtherFranchiseType">
                                    <c:forEach items="${actionBean.allOtherFranchise}" var="franchise">
                                        <option value="${franchise.commonValueId}">${franchise.value}</option>
                                    </c:forEach>
                                </select><br/>
                        </nc:ifWriteAccessAllowed>
                         <nc:ifReadOnlyAccess name="dealer.otherFranchise[0].type.commonValueId">
                             <span id="editOtherFranchiseType" class="readOnlyFormValue"></span> <br/>
                         </nc:ifReadOnlyAccess>
                    </div>
                </div>
        <!--- =====================  End Other Franchise Dialog ======================== -->
    



            <script type="text/javascript">
                    function editOtherFranchise(editedOtherFranchise, event){
                                $("#franchiseBeingEdited").val(editedOtherFranchise.attr('rowIndex')); // html table rows start from 1
                                YAHOO.log("Editing other franchise " + $("#franchiseBeingEdited").val(), "info");

                                <nc:ifWriteAccessAllowed name="dealer.otherFranchise[0].type.commonValueId">
                                    var otherFranchiseIdField = editedOtherFranchise.find(".otherFranchiseIdField").val();
                                    $("#editOtherFranchiseType").val(otherFranchiseIdField);
                                </nc:ifWriteAccessAllowed>
                                 <nc:ifReadOnlyAccess name="dealer.otherFranchise[0].type.commonValueId">
                                    $("#editOtherFranchiseType").text(editedOtherFranchise.find(".otherFranchiseValueField").text());
                                </nc:ifReadOnlyAccess>
                                YAHOO.au.com.toyota.widget.AddOtherFranchiseDialog.show();
                                YAHOO.util.Event.preventDefault(event);
                        }

                 function ${initializeOtherFranchiseFunctionName}(){
                            YAHOO.log("Initializing other franchise","info");

                            var addSelectedOtherFranchise = function(){
                                var editedRowIndex=$("#franchiseBeingEdited").val();
                                var isEditing = (editedRowIndex!="");

                                var newIndex=$("table#otherFranchiseTable tbody tr").length;
                                var selectedValueId=$("select#editOtherFranchiseType").val();
                                var selectedOption=$("select#editOtherFranchiseType option:selected").text();

                                if (isEditing){
                                       YAHOO.log("Editing existing other franchise", "info");
                                        var rowBeingEdited = $($("table#otherFranchiseTable tbody tr")[editedRowIndex]);
                                    
                                        <nc:ifWriteAccessAllowed name="dealer.otherFranchise[0].type.commonValueId">
                                            rowBeingEdited.find(".otherFranchiseIdField").val(selectedValueId);
                                            rowBeingEdited.find(".otherFranchiseValueField").val(selectedOption);
                                        </nc:ifWriteAccessAllowed>

                                        YAHOO.log("Finished editing existing other franchise","info");
                                }else{
                                        YAHOO.log("Adding new other franchise", "info");
                                        $("<tr class='itemRow'>"+
                                                "<td>"+
                                                    "<input type='hidden' name='dealer.otherFranchise["+newIndex+"].otherFranchiseId' class='dealerOtherFranchiseIdField'/>"+
                                                    "<input type='hidden' name='dealer.otherFranchise["+newIndex+"].type.commonValueId' class='otherFranchiseIdField' value='"+ selectedValueId +"'/>"+
                                                    "<input type='text' name='dealer.otherFranchise["+newIndex+"].type.value' readonly='readonly' class='readonly otherFranchiseValueField' value='"+selectedOption+ "' />"+
                                                "</td>"+
                                                "<td class='controlColumn'>"+
                                                    "<input type='hidden' name='dealer.otherFranchise["+newIndex+"].removedFromDealer' class='removeFlagField'/>"+
                                                    "<a href='' class='editLink'><fmt:message key="label.editItemInTable"/></a>"+
                                                    "<a href='' class='deleteLink'><fmt:message key="label.removeItemInTable"/></a>"+
                                                "</td>"+
                                          "</tr>").appendTo("table#otherFranchiseTable tbody");
                                    
                                        YAHOO.log("\tAttaching delete button behaviour to newly added 'other franchise'","info");
                                        attachDeleteBehaviourWithFlagField($("table#otherFranchiseTable tr:last-child a.deleteLink"));

                                        YAHOO.log("\tAttaching edit button behaviour to newly added 'other franchise'","info");
                                        attachTableColumnEditBehaviour($("table#otherFranchiseTable tr:last-child a.editLink"), editOtherFranchise);

                                        YAHOO.log("\tDisabling read only checkboxes","info");
                                        disableReadOnlyCheckboxes();

                                        YAHOO.log("Finished adding new 'other franchise'");
                                }
                            };

                            YAHOO.log("Creating 'other franchise' dialog","info");
                             <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                                    dialogName="AddOtherFranchiseDialog" dialogId="addOtherFranchiseDialog" okHandler="addSelectedOtherFranchise"/>

                            var clearOtherFranchiseDialogForAdding = function(){
                                YAHOO.log("Clearing other franchise dialog", "info");
                                $("#franchiseBeingEdited").val("");
                                $("#editOtherFranchiseType").val("");
                            };

                            YAHOO.log("Attaching popup listener for adding 'other franchise'","info");
                            <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                                    htmlId="addOtherFranchiseLink" dialogName="AddOtherFranchiseDialog" extraMethod="clearOtherFranchiseDialogForAdding"/>

                            YAHOO.log("Attaching popup listener for editing 'other franchise'","info");
                            attachTableColumnEditBehaviour($("table#otherFranchiseTable a.editLink"), editOtherFranchise);

                            YAHOO.log("Attaching delete button behaviour to 'other franchise'","info");
                            attachDeleteBehaviourWithFlagField($("table#otherFranchiseTable a.deleteLink"));

                            YAHOO.log("Finished initializing 'other franchise'","info");
                        }
            </script>
    </nc:ifWriteAccessAllowed>
</stripes:layout-definition>
