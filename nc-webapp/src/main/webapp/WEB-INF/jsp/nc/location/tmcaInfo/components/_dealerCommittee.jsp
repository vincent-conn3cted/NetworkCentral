<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    

    <nc:ifAccessAllowed name="dealer.committees">
    <!--- =====================  Start Dealer Committee fieldset ======================== -->
   <fieldset id="tmcaInfo-dealerSelectCommitteeSection">
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
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${fn:length(actionBean.location.dealer.committees) == 0}">
                            <tr class="noItemRow">
                                <td colspan="7"><fmt:message key="label.noitems"/></td>
                            </tr>
                     </c:if>
                    <c:if test="${fn:length(actionBean.location.dealer.committees) > 0}">
                            <c:forEach items="${actionBean.location.dealer.committees}" var="dealerCommittee" varStatus="committeeStatus">
                                <tr class="itemRow">
                                    <td>
                                        <span class="formValue">${dealerCommittee.committee.value}</span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${dealerCommittee.currentFlag}">
                                                <span class="checkedImage checkboxImage"></span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="unCheckedImage checkboxImage"></span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${dealerCommittee.previousFlag}">
                                                <span class="checkedImage checkboxImage"></span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="unCheckedImage checkboxImage"></span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="formValue">${dealerCommittee.memberName}</span>
                                    </td>
                                    <td>
                                        <span class="formValue">${dealerCommittee.role}</span>
                                    </td>
                                    <td>
                                        <span class="formValue">${dealerCommittee.validDate.startDate}</span>
                                    </td>
                                    <td>
                                        <span class="formValue">${dealerCommittee.validDate.endDate}</span>
                                    </td>
                                </tr>
                            </c:forEach>
                    </c:if>
                </tbody>
            </table>
    </fieldset>
        <!--- =====================  End Dealer Committee fieldset ======================== -->
        </nc:ifAccessAllowed>

</stripes:layout-definition>
