<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-definition>
       <nc:pageName pageName="${pageName}"/>

    <nc:ifAccessAllowed name="dealer.awards">
         <!--- ==== Start  Awards stuffs ============================================== -->
        <fieldset id="awardsInfo-awardsSection">
                <table id="awardsTable">
                    <thead>
                        <tr>
                            <th><fmt:message  key="award.year"/></th>
                            <th><fmt:message  key="award.type"/></th>
                            <th><fmt:message  key="award.level"/></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${fn:length(actionBean.location.dealer.awards) == 0}">
                            <tr class="noItemRow">
                                <td colspan="3"><fmt:message key="label.noitems"/></td>
                            </tr>
                        </c:if>
                        <c:if test="${fn:length(actionBean.location.dealer.awards) > 0}">
                            <c:forEach items="${actionBean.location.dealer.awards}" var="award" varStatus="awardStatus">
                                <tr class="itemRow">
                                    <td>
                                         <span class="formValue">${award.yearWon}</span>
                                    </td>
                                    <td>
                                        <span class="formValue">${award.name.description}</span>
                                    </td>
                                    <td>
                                        <span class="formValue">${award.awardLevel.value}</span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:if>
                    </tbody>
                </table>
            </fieldset>
        <!--- ===== End Awards stuffs ========================================== -->
    </nc:ifAccessAllowed>

</stripes:layout-definition>
