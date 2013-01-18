<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
        <%-- ==========================================
     Secure page stuffs
     =============================================--%>
        <nc:pageName pageName="${pageName}"/>
     <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>


    <nc:ifAccessAllowed name="dealer.businessImprovements">
          <!--- ========================================================================
                Start Business Improvements stuffs
         ========================================================================== -->
        <ul class="column-style-fieldset oneCol">
            <li>
                 <fieldset id="tmcaInfo-businessImprovementSection" class="tableEncapsulatingFieldSet">
                     <nc:ifPageViewMode mode="Edit">
                        <nc:ifAccessAllowed name="dealer.businessImprovements.add">
                            <c:if test="${fn:length(actionBean.allBusinessImprovements) > 0 }">
                                <a href="" id="addBusinessImprovementLink" class="addItemToTableLink">
                                        <fmt:message key="label.addItemToTable"/>
                                </a>
                            </c:if>
                        </nc:ifAccessAllowed>
                     </nc:ifPageViewMode>


                        <legend><fmt:message  key="dealer.businessImprovements"/></legend>
                        <table id="businessImprovementTable">
                            <tbody>
                            <c:forEach items="${actionBean.dealer.businessImprovements}" var="bi" varStatus="biStatus">
                                <tr class="itemRow">
                                    <td>
                                        <nc:hidden name="dealer.businessImprovements[${biStatus.index}].businessImprovementId"/>
                                    </td>
                                    <td>
                                        <nc:hidden name="dealer.businessImprovements[${biStatus.index}].type.commonValueId"/>
                                        <nc:text name="dealer.businessImprovements[${biStatus.index}].type.value" class="readonly" readonly="true"/>
                                    </td>
                                    <nc:ifPageViewMode mode="Edit">
                                        <nc:ifAccessAllowed  name="dealer.businessImprovements.delete">
                                            <td class="controlColumn">
                                                <nc:hidden name="dealer.businessImprovements[${biStatus.index}].removedFromDealer" class='removeFlagField'/>
                                                <a href="" class="deleteLink">
                                                    <fmt:message key="label.removeItemInTable"/>
                                                </a>
                                            </td>
                                        </nc:ifAccessAllowed>
                                    </nc:ifPageViewMode>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <div class="clear"></div>
                    </fieldset>
                </li>
            </ul>
    </nc:ifAccessAllowed>

    <nc:ifWriteAccessAllowed name="dealer.businessImprovements">
             <div id="addBusinessImprovementDialog" class="dialog">
                    <div class="hd"><fmt:message key="label.add"/> <fmt:message  key="dealer.businessImprovements"/></div>
                    <div class="bd">
                        <select id="addBusinessImprovementSelectList">
                            <c:forEach items="${actionBean.allBusinessImprovements}" var="bi">
                                <option value="${bi.commonValueId}">${bi.value}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

            <script type="text/javascript">
                function ${initializeBusinessImprovementFunctionName}() {
                    YAHOO.log("Initializing business improvement","info");

                    var addSelectedBusinessImprovement = function(){
                        YAHOO.log("Adding new business improvement","info");
                        var newIndex=$("table#businessImprovementTable tbody tr").length;
                        var selectedValueId=$("select#addBusinessImprovementSelectList").val();
                        var selectedOption=$("select#addBusinessImprovementSelectList option:selected").text();
                        $("<tr class='itemRow'>"+
                          "<td>"+
                          "<input type='hidden' name='dealer.businessImprovements["+newIndex+"].businessImprovementId'/>"+
                          "</td>"+
                          "<td>"+
                                "<input type='hidden' name='dealer.businessImprovements["+newIndex+"].type.commonValueId' value='"+selectedValueId+"'/>"+
                                "<input type='text' name='dealer.businessImprovements["+newIndex+"].type.value' readonly='readonly' class='readonly'  value='"+selectedOption+"'/>"+
                           "</td>"+
                          "<td class='controlColumn'>"+
                                    "<input type='hidden' name='dealer.businessImprovements["+newIndex+"].removedFromDealer' class='removeFlagField'/>"+
                                    "<a href='' class='deleteLink'><fmt:message key="label.removeItemInTable"/></a>"+
                          "</td>"+
                          "</tr>").appendTo("table#businessImprovementTable tbody");

                        YAHOO.log("Attaching delete button behaviour to newly added 'business improvement'","info");
                        attachDeleteBehaviourWithFlagField($("table#businessImprovementTable tr:last-child a.deleteLink"));

                        YAHOO.log("Finished adding new business improvement","info");
                    };

                    YAHOO.log("Creating 'business improvement' dialog","info");
                    <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                            dialogName="AddBusinessImprovementDialog" dialogId="addBusinessImprovementDialog" okHandler="addSelectedBusinessImprovement"/>
                    
                    YAHOO.log("Attaching popup listener for adding business improvement dialog","info");
                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                            htmlId="addBusinessImprovementLink" dialogName="AddBusinessImprovementDialog"/>

                    YAHOO.log("Attaching delete button behaviour to 'business improvement'","info");
                    attachDeleteBehaviourWithFlagField($("table#businessImprovementTable a.deleteLink"));

                    YAHOO.log("Finished initializing business improvement","info");
                }
            </script>
    </nc:ifWriteAccessAllowed>

</stripes:layout-definition>