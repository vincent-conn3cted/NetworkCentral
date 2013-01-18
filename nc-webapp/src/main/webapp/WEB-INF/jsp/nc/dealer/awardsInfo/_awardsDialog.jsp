<%@ page import="au.com.toyota.nc.common.model.hibernate.DealerAward" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <%-- ==========================================
        Secure page stuffs
        =============================================--%>
       <nc:pageName pageName="EditDealership-Award"/>
        <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>


        <!--- ========================================================================
                   Start  Awards stuffs
            ========================================================================== -->
    <nc:ifAccessAllowed name="dealer.awards">
        <fieldset id="awardsInfo-awardsSection" class="tableEncapsulatingFieldSet">
            <nc:ifPageViewMode mode="Edit">
                <nc:ifAccessAllowed name="dealer.awards.add">
                    <c:if test="${fn:length(actionBean.allAwardLevel) > 0 && fn:length(actionBean.allAwardName) > 0 }">
                        <a href="" id="addAwardLink" class="addItemToTableLink">
                            <fmt:message key="label.addItemToTable"/>
                        </a>
                    </c:if>
                </nc:ifAccessAllowed>
            </nc:ifPageViewMode>
            <br/>
            <div id="awardsTableSection">
                <table id="awardsTable">
                    <thead>
                        <tr>
                            <th><fmt:message  key="award.year"/></th>
                            <th><fmt:message  key="award.type"/></th>
                            <th><fmt:message  key="award.level"/></th>
                            <nc:ifPageViewMode mode="Edit">
                                <th class="controlColumn">&nbsp;</th>
                            </nc:ifPageViewMode>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${actionBean.dealer.awards}" var="award" varStatus="awardStatus">
                            <tr class="itemRow">
                                <td>
                                    <nc:ifPageViewMode mode="Edit">
                                        <nc:hidden name="dealer.awards[${awardStatus.index}].dealerAwardId" />
                                        <nc:text name="dealer.awards[${awardStatus.index}].yearWon" readonly="true" class="awardYearField" readOnlyClass="awardYearField"/>
                                    </nc:ifPageViewMode>
                                    <nc:ifPageViewMode mode="View">
                                        <span><c:out value="${award.yearWon}"/></span>
                                    </nc:ifPageViewMode>
                                </td>
                                <td>
                                    <nc:ifPageViewMode mode="Edit">
                                        <nc:hidden name="dealer.awards[${awardStatus.index}].name.commonValueId" class="awardTypeIdField"/>
                                        <nc:text name="dealer.awards[${awardStatus.index}].name.description" readonly="true" class="awardTypeLabelField" readOnlyClass="awardTypeLabelField"/>
                                    </nc:ifPageViewMode>
                                    <nc:ifPageViewMode mode="View">
                                        <span><c:out value="${award.name.description}"/></span>
                                    </nc:ifPageViewMode>
                                </td>
                                <td>
                                    <nc:ifPageViewMode mode="Edit">
                                        <nc:hidden name="dealer.awards[${awardStatus.index}].awardLevel.commonValueId" class="awardLevelIdField"/>
                                        <nc:text name="dealer.awards[${awardStatus.index}].awardLevel.value" readonly="true" class="awardLevelLabelField" readOnlyClass="awardLevelLabelField"/>
                                    </nc:ifPageViewMode>
                                    <nc:ifPageViewMode mode="View">
                                        <span><c:out value="${award.awardLevel.value}"/></span>
                                    </nc:ifPageViewMode>
                                </td>
                                <nc:ifPageViewMode mode="Edit">
                                    <td class="controlColumn">
                                        <nc:ifAccessAllowed name="dealer.awards.edit">
                                                <a href="" class="editLink"><fmt:message key="label.editItemInTable"/></a>
                                        </nc:ifAccessAllowed>
                                        <nc:ifAccessAllowed name="dealer.awards.delete">
                                                <nc:hidden name="dealer.awards[${awardStatus.index}].removedFromDealer" class="removeFlagField"/>
                                                <a href="" class="deleteLink"><fmt:message key="label.removeItemInTable"/></a>
                                        </nc:ifAccessAllowed>
                                    </td>
                                </nc:ifPageViewMode>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            </fieldset>
    </nc:ifAccessAllowed>

    <nc:ifWriteAccessAllowed name="dealer.awards">
        <div id="addAwardDialog" class="dialog">
                <div class="hd"><fmt:message key="label.add"/> <fmt:message  key="dealer.awards"/></div>
                <div class="bd">
                    <%-- used for editing existing award. If this field is populated, it means we are editing an existing award --%>
                    <input type="hidden" id="awardRowBeingEdited" name="awardRowBeingEdited"/>

                    <fieldset>
                            <label for="awardType"><fmt:message  key="award.type"/></label>
                            <select id="awardType" name="awardType">
                                <c:forEach items="${actionBean.allAwardName}" var="awardName">
                                    <option value="${awardName.commonValueId}">${awardName.description}</option>
                                </c:forEach>
                            </select><br/>

                            <label for="awardYear"><fmt:message  key="award.year"/></label>
                            <input type="text" name="awardYear" id="awardYear" maxlength="<%=DealerAward.MAX_AWARD_YEAR%>"/><br/>

                            <label for="awardLevel"><fmt:message  key="award.level"/></label>
                            <select id="awardLevel" name="awardLevel">
                                <c:forEach items="${actionBean.allAwardLevel}" var="awardLevel">
                                    <option value="${awardLevel.commonValueId}">${awardLevel.value}</option>
                                </c:forEach>
                            </select>
                    </fieldset>
                </div>
            </div>

    <script type="text/javascript">
        function editAward(editedAwardRow, event){
            $("#awardRowBeingEdited").val(editedAwardRow.attr('rowIndex')-1); // html table rows start from 1

            YAHOO.log("Editing award " + $("#awardRowBeingEdited").val(), "info");
             $("#awardYear").val(editedAwardRow.find(".awardYearField").val());
              $("#awardType").val(editedAwardRow.find(".awardTypeIdField").val());
             $("#awardLevel").val(editedAwardRow.find(".awardLevelIdField").val());

            YAHOO.au.com.toyota.widget.AddAwardDialog.show();
        }


        function initializeAwardDialog(){
              var clearAwardOnDelete = function(deletedRow){
                  deletedRow.find("input.awardYearField").val("");
              };

            var addSelectedAward = function(){
                var editedRowIndex = $("#awardRowBeingEdited").val();
                var isEditing = (editedRowIndex!="");

                var newIndex=$("table#awardsTable tbody tr").length;
                var awardYearValue=$("#awardYear").val();

                var awardTypeValueId=$("#awardType").val();
                var awardTypeLabel=$("#awardType option:selected").text();

                var awardLevelValueId=$("#awardLevel").val();
                var awardLevelLabel=$("#awardLevel option:selected").text();

                if (isEditing){
                        YAHOO.log("Editing existing award","info");
                        var rowBeingEdited = $($("table#awardsTable tbody tr")[editedRowIndex]);
                        rowBeingEdited.find(".awardYearField").val(awardYearValue);
                        rowBeingEdited.find(".awardTypeIdField").val(awardTypeValueId);
                        rowBeingEdited.find(".awardTypeLabelField").val(awardTypeLabel);
                        rowBeingEdited.find(".awardLevelIdField").val(awardLevelValueId);
                        rowBeingEdited.find(".awardLevelLabelField").val(awardLevelLabel);
                }else{
                        YAHOO.log("Adding new award","info");
                        $("<tr class='itemRow'>"+
                          "<td>"+
                                  "<input type='hidden' name='dealer.awards["+newIndex+"].dealerAwardId'/>"+
                                  "<input type='text' name='dealer.awards["+newIndex+"].yearWon' readonly='readonly' class='awardYearField' value='"+awardYearValue+"'/>"+
                          "</td>"+
                          "<td>"+
                                  "<input type='hidden' name='dealer.awards["+newIndex+"].name.commonValueId' class='awardTypeIdField' value='"+ awardTypeValueId+"'/>"+
                                  "<input type='text' name='dealer.awards["+newIndex+"].name.description' readonly='readonly' class='awardTypeLabelField' value='"+ awardTypeLabel+"'/>"+
                          "</td>"+
                          "<td>"+
                                  "<input type='hidden' name='dealer.awards["+newIndex+"].awardLevel.commonValueId' class='awardLevelIdField' value='"+awardLevelValueId+"'/>"+
                                  "<input type='text' name='dealer.awards["+newIndex+"].awardLevel.value' readonly='readonly' class='awardLevelLabelField' value='"+awardLevelLabel+"'/>"+
                          "</td>"+
                          "<td class='controlColumn'>"+
                                "<input type='hidden' name='dealer.awards["+newIndex+"].removedFromDealer' class='removeFlagField'/>"+
                                "<a href='' class='editLink'><fmt:message key='label.editItemInTable'/></a>"+
                                "<a href='' class='deleteLink'><fmt:message key='label.removeItemInTable'/></a>"+
                          "</td>"+
                          "</tr>"
                                ).appendTo($("table#awardsTable tbody"));
                        YAHOO.log("Attaching delete behaviour for 'awards' ","info");
                        attachDeleteBehaviourWithFlagField($("table#awardsTable tr:last-child a.deleteLink"),clearAwardOnDelete);

                        YAHOO.log("Attaching edit behaviour for 'awards' ","info");
                        attachTableColumnEditBehaviour($("table#awardsTable tr:last-child a.editLink"), editAward);
                }
            };
          
            <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                dialogName="AddAwardDialog" dialogId="addAwardDialog" okHandler="addSelectedAward" width="380px"/>

            var clearAwardsDialogForAdding = function(){
                YAHOO.log("Clearning awards dialog","info");
                $("#awardRowBeingEdited").val("");
                $("#awardYear").val("");
                $("#awardType").val("");
                $("#awardLevel").val("");
            };

           <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                htmlId="addAwardLink" dialogName="AddAwardDialog" extraMethod="clearAwardsDialogForAdding"/>

            attachDeleteBehaviourWithFlagField($("table#awardsTable a.deleteLink"),clearAwardOnDelete);
            attachTableColumnEditBehaviour($("table#awardsTable a.editLink"), editAward);
        }


    </script>
    </nc:ifWriteAccessAllowed>
      





</stripes:layout-definition>
