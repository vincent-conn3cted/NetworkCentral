<%@ page import="au.com.toyota.nc.common.model.hibernate.LocationSharedFacility" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

        <nc:ifAccessAllowed name="location.sharedFacilities">
            <!--- =====================  Start Other Franchise fieldset ======================== -->
            <fieldset id="tmcaInfo-sharedFactilitySection" class="tableEncapsulatingFieldSet">
                <nc:ifPageViewMode mode="Edit">
                    <nc:ifAccessAllowed name="location.sharedFacilities.add">
                        <%-- Only allows adding shared facility if the dealer has other franchise associated --%>
                        <c:if test="${actionBean.location.allowAddSharedFacility}">
                            <a href="" id="addSharedFacilityLink" class="addItemToTableLink">
                                <fmt:message key="label.addItemToTable"/>
                            </a>
                        </c:if>
                    </nc:ifAccessAllowed>
                </nc:ifPageViewMode>


                <legend><fmt:message  key="otherFranchise.sharedFacility"/></legend>
                <table id="sharedFacilityTable">
                    <thead>
                        <tr>
                            <th><fmt:message key="otherFranchise.franchiseName"/></th>
                            <nc:ifAccessAllowed name="location.sharedFacilities[0].sharedShowroom">
                                <th><fmt:message key="otherFranchise.sharedShowroom"/></th>
                            </nc:ifAccessAllowed>
                            <nc:ifAccessAllowed name="location.sharedFacilities[0].sharedWorkshop">
                                <th><fmt:message key="otherFranchise.sharedWorkshop"/></th>
                            </nc:ifAccessAllowed>
                            <nc:ifAccessAllowed name="location.sharedFacilities[0].sharedOther">
                                <th><fmt:message key="otherFranchise.sharedOther"/></th>
                             </nc:ifAccessAllowed>
                               <nc:ifPageViewMode mode="Edit">
                                <th class="controlColumn"></th>
                            </nc:ifPageViewMode>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${actionBean.location.sharedFacilities}" var="sharedFacility" varStatus="sharedFacilityStatus">
                        <tr class="itemRow">
                            <td>
                                <nc:hidden name="location.sharedFacilities[${sharedFacilityStatus.index}].sharedFacilityId" class="locationSharedFacilityIdField"/>
                                <nc:hidden name="location.sharedFacilities[${sharedFacilityStatus.index}].dealerOtherFranchise.otherFranchiseId" class="dealerOtherFranchiseIdField"/>
                                <nc:text name="location.sharedFacilities[${sharedFacilityStatus.index}].dealerOtherFranchise.type.value" readonly="true" class="dealerOtherFranchiseTypeField readonly" readOnlyClass="dealerOtherFranchiseTypeField"/>
                            </td>
                            <nc:ifAccessAllowed name="location.sharedFacilities[${sharedFacilityStatus.index}].sharedShowroom">
                                <td>
                                    <c:choose>
                                        <c:when test="${sharedFacility.sharedShowroom eq true}">
                                            <span class="sharedShowroomField checkedImage checkboxImage"></span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="sharedShowroomField unCheckedImage checkboxImage"></span>
                                        </c:otherwise>
                                    </c:choose>
                                    <nc:hidden name="location.sharedFacilities[${sharedFacilityStatus.index}].sharedShowroom" class="sharedShowroomField"/>
                                </td>
                            </nc:ifAccessAllowed>
                            <nc:ifAccessAllowed name="location.sharedFacilities[${sharedFacilityStatus.index}].sharedWorkshop">
                                <td>
                                     <c:choose>
                                         <c:when test="${sharedFacility.sharedWorkshop eq true}">
                                             <span class="sharedWorkshopField checkedImage checkboxImage"></span>
                                         </c:when>
                                         <c:otherwise>
                                             <span class="sharedWorkshopField unCheckedImage checkboxImage"></span>
                                         </c:otherwise>
                                     </c:choose>
                                    <nc:hidden name="location.sharedFacilities[${sharedFacilityStatus.index}].sharedWorkshop" class="sharedWorkshopField"/>
                                </td>
                            </nc:ifAccessAllowed>
                            <nc:ifAccessAllowed name="location.sharedFacilities[${sharedFacilityStatus.index}].sharedOther">
                            <td>
                                <nc:text name="location.sharedFacilities[${sharedFacilityStatus.index}].sharedOther" class="sharedOtherField readonly" readOnlyClass="sharedOtherField" readonly="true"/>
                            </td>
                            </nc:ifAccessAllowed>
                            <nc:ifPageViewMode mode="Edit">
                                <td class="controlColumn">
                                    <nc:ifAccessAllowed name="location.sharedFacilities.edit">
                                        <a href="" class="editLink" id="editSharedFacility-<c:out value="${sharedFacility.sharedFacilityId}"/>"><fmt:message key="label.editItemInTable"/></a>
                                    </nc:ifAccessAllowed>
                                    <nc:ifAccessAllowed name="location.sharedFacilities.delete">
                                        <nc:hidden name="location.sharedFacilities[${sharedFacilityStatus.index}].removedFromLocation"  class='removeFlagField'/>
                                        <a href="" class="deleteLink"><fmt:message key="label.removeItemInTable"/></a>
                                    </nc:ifAccessAllowed>
                                </td>
                            </nc:ifPageViewMode>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </fieldset>
            <!--- =====================  End Other Franchise fieldset ======================== -->
    </nc:ifAccessAllowed>


    <nc:ifWriteAccessAllowed name="location.sharedFacilities">
        <!-- =========================== Start shared facility dialog ======================================-->
        <div id="addSharedFacilityDialog" class="dialog">
            <div class="hd"><fmt:message key="label.add"/><fmt:message  key="otherFranchise.sharedFacility"/></div>
            <div class="bd">
                <input type="hidden" id="sharedFacilityBeingEdited"/>

                <label for="editSharedFacilityDealerOtherFranchise"><fmt:message key="otherFranchise.franchiseName"/></label>
                <nc:ifWriteAccessAllowed name="location.sharedFacilities[0].dealerOtherFranchise.otherFranchiseId">
                    <select id="editSharedFacilityDealerOtherFranchise">
                        <c:forEach items="${actionBean.location.dealer.otherFranchise}" var="dealerOtherFranchise">
                            <option value="${dealerOtherFranchise.otherFranchiseId}">${dealerOtherFranchise.type.value}</option>
                        </c:forEach>
                    </select>
                </nc:ifWriteAccessAllowed>
                <nc:ifReadOnlyAccess name="location.sharedFacilities[0].dealerOtherFranchise.otherFranchiseId">
                    <span id="editSharedFacilityDealerOtherFranchise" class="readOnlyFormValue"></span>
                </nc:ifReadOnlyAccess>

                <fieldset>
                    <legend><fmt:message key="otherFranchise.sharedFacility"/></legend>

                    <nc:ifAccessAllowed name="location.sharedFacilities[0].sharedShowroom">
                        <label for="editSharedShowroomFlag"><fmt:message key="otherFranchise.sharedShowroom"/></label>
                    </nc:ifAccessAllowed>
                    <nc:ifWriteAccessAllowed name="location.sharedFacilities[0].sharedShowroom">
                        <input id="editSharedShowroomFlag" type="checkbox"/><br/>
                    </nc:ifWriteAccessAllowed>
                    <nc:ifReadOnlyAccess name="location.sharedFacilities[0].sharedShowroom">
                        <span id="editSharedShowroomFlag" class="readOnlyFormValue"></span><br/>
                    </nc:ifReadOnlyAccess>

                    <nc:ifAccessAllowed name="location.sharedFacilities[0].sharedWorkshop">
                        <label for="editSharedWorkshopFlag"><fmt:message key="otherFranchise.sharedWorkshop"/></label>
                    </nc:ifAccessAllowed>
                    <nc:ifWriteAccessAllowed name="location.sharedFacilities[0].sharedWorkshop">
                        <input id="editSharedWorkshopFlag" type="checkbox"/><br/>
                    </nc:ifWriteAccessAllowed>
                    <nc:ifReadOnlyAccess name="location.sharedFacilities[0].sharedWorkshop">
                        <span id="editSharedWorkshopFlag" class="readOnlyFormValue"></span><br/>
                    </nc:ifReadOnlyAccess>

                    <nc:ifAccessAllowed name="location.sharedFacilities[0].sharedOther">
                        <label for="editSharedOther"><fmt:message key="otherFranchise.sharedOther"/></label>
                    </nc:ifAccessAllowed>
                    <nc:ifWriteAccessAllowed name="location.sharedFacilities[0].sharedOther">
                        <input id="editSharedOther" type="text" maxlength="<%=LocationSharedFacility.MAX_SHARED_OTHER%>"/><br/>
                    </nc:ifWriteAccessAllowed>
                    <nc:ifReadOnlyAccess name="location.sharedFacilities[0].sharedOther">
                        <span id="editSharedOther" class="readOnlyFormValue"></span><br/>
                    </nc:ifReadOnlyAccess>
                </fieldset>
             </div>
        </div>
        <!--- =====================  End shared facilitydialog ======================== -->


    <script type="text/javascript">
        var  LocationSharedFacilityHandler = {
              initAll: function(){
                  this.prepareComponents();
                  this.initEventHandling();
              },
            prepareComponents:function(){
                    YAHOO.log("Creating 'shared facility' dialog","info");
                    <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                                    dialogName="AddSharedFacilityDialog" dialogId="addSharedFacilityDialog" okHandler="LocationSharedFacilityHandler.addUpdateSharedFacility"/>
                    YAHOO.log("Finished creating 'shared facility' dialog","info");
            },
            initEventHandling:function(){
                    YAHOO.log("Initializing event handling for shared facility functionality","info");

                     YAHOO.log("\tAttaching popup listener for adding 'other franchise'","info");
                      <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                              htmlId="addSharedFacilityLink" dialogName="AddSharedFacilityDialog" extraMethod="LocationSharedFacilityHandler.resetSharedFacilityDialog"/>


                    YAHOO.log("\tAttaching popup listener for editing 'other franchise'","info");
                    attachTableColumnEditBehaviour($("table#sharedFacilityTable a.editLink"), this.initSharedFacilityDialogForEdit);

                    YAHOO.log("\tAttaching delete button behaviour to 'other franchise'","info");
                    attachDeleteBehaviourWithFlagField($("table#sharedFacilityTable a.deleteLink"));

                    YAHOO.log("Finished initializing event handling for shared facility functionality","info");
            },
            resetSharedFacilityDialog: function(){
                    $("#sharedFacilityBeingEdited").val("");
                    $("#editSharedFacilityDealerOtherFranchise").val("");
                    $("#editSharedShowroomFlag").attr("checked","");
                    $("#editSharedWorkshopFlag").attr("checked","");
                    $("#editSharedOther").val("");
            },
            initSharedFacilityDialogForEdit: function(editedSharedFacilityRow, event){
                    $("#sharedFacilityBeingEdited").val(editedSharedFacilityRow.attr('rowIndex')-1); // html table rows start from 1
                    YAHOO.log("Editing shared facility " + $("#sharedFacilityBeingEdited").val(),"info");

                    <nc:ifWriteAccessAllowed name="location.sharedFacilities[0].dealerOtherFranchise.otherFranchiseId">
                        $("#editSharedFacilityDealerOtherFranchise").val(editedSharedFacilityRow.find(".dealerOtherFranchiseIdField").val());
                    </nc:ifWriteAccessAllowed>
                    <nc:ifReadOnlyAccess name="location.sharedFacilities[0].dealerOtherFranchise.otherFranchiseId">
                        $("#editSharedFacilityDealerOtherFranchise").html(editedSharedFacilityRow.find(".dealerOtherFranchiseTypeField").html());
                    </nc:ifReadOnlyAccess>

                  <nc:ifWriteAccessAllowed name="location.sharedFacilities[0].sharedShowroom">
                        $("#editSharedShowroomFlag").attr("checked",editedSharedFacilityRow.find("input.sharedShowroomField").val()=="true"?"checked":"");
                    </nc:ifWriteAccessAllowed>
                     <nc:ifReadOnlyAccess name="location.sharedFacilities[0].sharedShowroom">
                        $("#editSharedShowroomFlag").html(editedSharedFacilityRow.find("span.sharedShowroomField").clone()[0]);
                    </nc:ifReadOnlyAccess>

                    <nc:ifWriteAccessAllowed name="location.sharedFacilities[0].sharedWorkshop">
                        $("#editSharedWorkshopFlag").attr("checked",editedSharedFacilityRow.find("input.sharedWorkshopField").val()=="true"?"checked":"");
                    </nc:ifWriteAccessAllowed>
                     <nc:ifReadOnlyAccess name="location.sharedFacilities[0].sharedWorkshop">
                        $("#editSharedWorkshopFlag").html(editedSharedFacilityRow.find("span.sharedWorkshopField").clone()[0]);
                    </nc:ifReadOnlyAccess>

                    <nc:ifWriteAccessAllowed name="location.sharedFacilities[0].sharedOther">
                        $("#editSharedOther").val(editedSharedFacilityRow.find(".sharedOtherField").val());
                    </nc:ifWriteAccessAllowed>
                     <nc:ifReadOnlyAccess name="location.sharedFacilities[0].sharedOther">
                        $("#editSharedOther").text(editedSharedFacilityRow.find(".sharedOtherField").text());
                    </nc:ifReadOnlyAccess>

                    YAHOO.au.com.toyota.widget.AddSharedFacilityDialog.show();
                    YAHOO.util.Event.preventDefault(event);
            },
            addUpdateSharedFacility: function(){
                        var editedRowIndex = $("#sharedFacilityBeingEdited").val();
                        var isEditing = (editedRowIndex != "");
                        if (isEditing){
                            this._doUpdateSharedFacility();
                        }else{
                            this._doAddNewSharedFacility();
                        }
            },
            _doAddNewSharedFacility: function(){
                    YAHOO.log("Adding new shared facility","info");
                    var newIndex = $("table#sharedFacilityTable tbody tr").length;

                    var selectedDealerOtherFranchiseId=$("select#editSharedFacilityDealerOtherFranchise").val();
                    var selectedDealerOtherFranchiseType=$("select#editSharedFacilityDealerOtherFranchise option:selected").text();

                    var sharedShowroomVal=$("#editSharedShowroomFlag").attr('checked');
                    var sharedWorkshopVal=$("#editSharedWorkshopFlag").attr('checked');
                    var sharedOtherVal=$("#editSharedOther").val();

                    $("<tr class='itemRow'>"+
                           "<td>"+
                                "<input type='hidden' name='location.sharedFacilities["+newIndex+"].sharedFacilityId' class='locationSharedFacilityIdField'/>"+
                                <nc:ifWriteAccessAllowed name="location.sharedFacilities[0].dealerOtherFranchise.otherFranchiseId">
                                    "<input type='hidden' name='location.sharedFacilities["+newIndex+"].dealerOtherFranchise.otherFranchiseId' class='dealerOtherFranchiseIdField' value='"+selectedDealerOtherFranchiseId+"'/>"+
                                    "<input type='text' name='location.sharedFacilities["+newIndex+"].dealerOtherFranchise.type.value' class='dealerOtherFranchiseTypeField readonly' readonly='readonly' value='"+selectedDealerOtherFranchiseType+"'/>"+
                                </nc:ifWriteAccessAllowed>
                            "</td>"+
                            <nc:ifWriteAccessAllowed name="location.sharedFacilities[0].sharedShowroom">
                                "<td>"+
                                        "<span class='sharedShowroomField checkboxImage " + (sharedShowroomVal? "checkedImage" : "unCheckedImage") + "'/>"+
                                        "<input type='hidden' name='location.sharedFacilities["+newIndex+"].sharedShowroom' class='sharedShowroomField' value='"+sharedShowroomVal+"'/>"+
                                "</td>"+
                            </nc:ifWriteAccessAllowed>
                            <nc:ifWriteAccessAllowed name="location.sharedFacilities[0].sharedWorkshop">
                                "<td>"+
                                        "<span class='sharedWorkshopField checkboxImage " + (sharedWorkshopVal? "checkedImage" : "unCheckedImage") + "'/>"+
                                        "<input type='hidden' name='location.sharedFacilities["+newIndex+"].sharedWorkshop' class='sharedWorkshopField' value='"+sharedWorkshopVal+"'/>"+
                                "</td>"+
                            </nc:ifWriteAccessAllowed>
                            <nc:ifWriteAccessAllowed name="location.sharedFacilities[0].sharedOther">
                                "<td>"+
                                        "<input type='text' name='location.sharedFacilities["+newIndex+"].sharedOther' class='sharedOtherField readonly' readonly='readonly' value='"+sharedOtherVal+"'/>"+
                                "</td>"+
                            </nc:ifWriteAccessAllowed>
                           "<td class='controlColumn'>"+
                                    <nc:ifAccessAllowed name="location.sharedFacilities.edit">
                                            "<a href='' class='editLink'><fmt:message key="label.editItemInTable"/></a>"+
                                    </nc:ifAccessAllowed>
                                    <nc:ifAccessAllowed name="location.sharedFacilities.delete">
                                            "<input type='hidden' name='location.sharedFacilities["+newIndex+"].removedFromLocation' class='removeFlagField'/>"+
                                            "<a href='' class='deleteLink'><fmt:message key="label.removeItemInTable"/></a>"+
                                    </nc:ifAccessAllowed>
                            "</td>"+
                    "</tr>").appendTo("table#sharedFacilityTable tbody");

                    YAHOO.log("\tAttaching delete button behaviour to newly added 'shared facility'","info");
                    attachDeleteBehaviourWithFlagField($("table#sharedFacilityTable tr:last-child a.deleteLink"));

                    YAHOO.log("\tAttaching edit button behaviour to newly added 'shared facility'","info");
                    attachTableColumnEditBehaviour($("table#sharedFacilityTable tr:last-child a.editLink"), this.initSharedFacilityDialogForEdit);

                    YAHOO.log("\tDisabling read only checkboxes for 'shared facility'","info");
                    disableReadOnlyCheckboxes();

                    YAHOO.log("Finished adding new 'shared facility'","info");
            },
            _doUpdateSharedFacility:function(){
                    YAHOO.log("Updating existing shared facility","info");
                    var editedRowIndex = $("#sharedFacilityBeingEdited").val();
                    var editedRow= $($("table#sharedFacilityTable tbody tr")[editedRowIndex]);

                    var selectedDealerOtherFranchiseId=$("select#editSharedFacilityDealerOtherFranchise").val();
                    var selectedDealerOtherFranchiseType=$("select#editSharedFacilityDealerOtherFranchise option:selected").text();

                    var sharedShowroomVal=$("#editSharedShowroomFlag").attr('checked');
                    var sharedWorkshopVal=$("#editSharedWorkshopFlag").attr('checked');
                    var sharedOtherVal=$("#editSharedOther").val();

                    <nc:ifWriteAccessAllowed name="location.sharedFacilities[0].dealerOtherFranchise.otherFranchiseId">
                        editedRow.find(".dealerOtherFranchiseIdField").val(selectedDealerOtherFranchiseId);
                        editedRow.find(".dealerOtherFranchiseTypeField").val(selectedDealerOtherFranchiseType);
                    </nc:ifWriteAccessAllowed>

                    <nc:ifWriteAccessAllowed name="location.sharedFacilities[0].sharedShowroom">
                        var sharedShowroomFieldCheckBoxImage=editedRow.find("span.sharedShowroomField.checkboxImage");
                        sharedShowroomFieldCheckBoxImage.removeClass("checkedImage unCheckedImage");
                        sharedShowroomFieldCheckBoxImage.addClass(sharedShowroomVal? "checkedImage":"unCheckedImage")
                        editedRow.find("input.sharedShowroomField").val(sharedShowroomVal);
                    </nc:ifWriteAccessAllowed>

                    <nc:ifWriteAccessAllowed name="location.sharedFacilities[0].sharedWorkshop">
                        var sharedWorkshopFieldCheckBoxImage=editedRow.find("span.sharedWorkshopField.checkboxImage");
                        sharedWorkshopFieldCheckBoxImage.removeClass("checkedImage unCheckedImage");
                        sharedWorkshopFieldCheckBoxImage.addClass(sharedWorkshopVal? "checkedImage":"unCheckedImage")
                        editedRow.find("input.sharedWorkshopField").val(sharedWorkshopVal);
                    </nc:ifWriteAccessAllowed>

                    <nc:ifWriteAccessAllowed name="location.sharedFacilities[0].sharedOther">
                        editedRow.find("input.sharedOtherField").val(sharedOtherVal);
                    </nc:ifWriteAccessAllowed>
                    YAHOO.log("Finished editing existing shared facility","info");
            }
        };
    </script>
    </nc:ifWriteAccessAllowed>


</stripes:layout-definition>
