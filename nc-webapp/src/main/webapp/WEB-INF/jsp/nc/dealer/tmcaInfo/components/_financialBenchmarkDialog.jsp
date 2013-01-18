<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-definition>
        <%-- ==========================================
     Secure page stuffs
     =============================================--%>
        <nc:pageName pageName="${pageName}"/>
     <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    

    <nc:ifAccessAllowed name="dealer.financialBenchmark">
        <!--- =====================  Start Financial Benchmark fieldset ======================== -->
        <ul class="column-style-fieldset oneCol">
            <li>
            <fieldset id="tmcaInfo-financialBenchmarkSection" class="tableEncapsulatingFieldSet">
                <nc:ifPageViewMode mode="Edit">
                    <nc:ifAccessAllowed name="dealer.financialBenchmark.add">
                        <c:if test="${fn:length(actionBean.allFinancialBenchmark)> 0 }">
                            <a href="" id="addFinancialBenchmarkLink" class="addItemToTableLink">
                                <fmt:message key="label.addItemToTable"/>
                            </a>
                        </c:if>
                    </nc:ifAccessAllowed>
                </nc:ifPageViewMode>

                <legend><fmt:message  key="dealer.financialBenchmark"/></legend>
                <table id="financialBenchmarkTable">
                    <tbody>
                    <c:forEach items="${actionBean.dealer.financialBenchmark}" var="fb" varStatus="fbStatus">
                        <tr class="itemRow">
                            <td>
                                <nc:hidden name="dealer.financialBenchmark[${fbStatus.index}].financialBenchmarkId"/>
                            </td>
                            <td>
                                <nc:hidden name="dealer.financialBenchmark[${fbStatus.index}].type.commonValueId"/>
                                <nc:text name="dealer.financialBenchmark[${fbStatus.index}].type.value" readonly="true" class="readonly"/>
                            </td>
                          <nc:ifPageViewMode mode="Edit">
                                <nc:ifAccessAllowed name="dealer.financialBenchmark.delete">
                                    <td class="controlColumn">
                                        <nc:hidden name="dealer.financialBenchmark[${fbStatus.index}].removedFromDealer" class='removeFlagField'/>
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
        <!--- =====================  End Financial Benchmark fieldset ======================== -->
    </nc:ifAccessAllowed>

    <nc:ifWriteAccessAllowed name="dealer.financialBenchmark">
        <!--- =====================  Start Financial Benchmark dialog   ======================== -->
    <div id="addFinancialBenchmarkDialog" class="dialog">
        <div class="hd"><fmt:message key="label.add"/> <fmt:message  key="dealer.financialBenchmark"/></div>
        <div class="bd">
            <select id="addFinancialBenchmarkSelectList">
                <c:forEach items="${actionBean.allFinancialBenchmark}" var="fb">
                    <option value="${fb.commonValueId}">${fb.value}</option>
                </c:forEach>
            </select>
        </div>
    </div>
        <!--- =====================  End Financial Benchmark dialog   ======================== -->

    <script type="text/javascript">
        function ${initializeFinancialBenchmarkFunctionName}(){
                    YAHOO.log("Initializing financial benchmark","info");

                    var addSelectedFinancialBenchmark = function(){
                        YAHOO.log("Adding new 'financial benchmark", "info");

                        var newIndex=$("table#financialBenchmarkTable tbody tr").length;
                        var selectedValueId=$("select#addFinancialBenchmarkSelectList").val();
                        var selectedOption=$("select#addFinancialBenchmarkSelectList option:selected").text();

                        $("<tr class='itemRow'>"+
                                "<td>"+
                                    "<input type='hidden' name='dealer.financialBenchmark["+newIndex+"].financialBenchmarkId'/>"+
                                "</td>"+
                                "<td>"+
                                    "<input type='hidden' name='dealer.financialBenchmark["+newIndex+"].type.commonValueId' value='"+selectedValueId+"'/>"+
                                    "<input type='text' name='dealer.financialBenchmark["+newIndex+"].type.value' readonly='readonly' class='readonly' value='"+selectedOption+"'/>"+
                                "</td>" +
                                "<td class='controlColumn'>"+
                                        "<input type='hidden' name='dealer.financialBenchmark["+newIndex+"].removedFromDealer' class='removeFlagField'/>"+
                                        "<a href='' class='deleteLink'><fmt:message key="label.removeItemInTable"/></a>"+
                                "</td>"+
                          "</tr>").appendTo("table#financialBenchmarkTable tbody");

                        YAHOO.log("Attaching delete behaviour to newly added 'financial benchmark'");
                        attachDeleteBehaviourWithFlagField($("table#financialBenchmarkTable tr:last-child a.deleteLink"));

                        YAHOO.log("Finished adding new 'financial benchmark'");
                    };


                    YAHOO.log("Creating financial benchmark dialog","info");
                     <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                            dialogName="AddFinancialBenchmarkDialog" dialogId="addFinancialBenchmarkDialog" okHandler="addSelectedFinancialBenchmark"/>

                    YAHOO.log("Attaching popup listener for adding financial benchmark","info");
                     <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                            htmlId="addFinancialBenchmarkLink" dialogName="AddFinancialBenchmarkDialog"/>

                    YAHOO.log("Attaching delete behaviour to 'financial benchmark'");
                    attachDeleteBehaviourWithFlagField($("table#financialBenchmarkTable a.deleteLink"));

                    YAHOO.log("Finished initializing financial benchmark","info");
                }
    </script>
    </nc:ifWriteAccessAllowed>
 </stripes:layout-definition>