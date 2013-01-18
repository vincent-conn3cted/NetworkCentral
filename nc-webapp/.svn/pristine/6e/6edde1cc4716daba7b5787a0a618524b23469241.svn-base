 <%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    

    <nc:ifAccessAllowed name="dealer.businessImprovements">
        <!--- =====     Start Business Improvements stuffs  =========================== -->
        <fieldset id="tmcaInfo-businessImprovementSection">
            <legend><fmt:message  key="dealer.businessImprovements"/></legend>
            <table id="businessImprovementTable">
                <tbody class="noItemRow">
                    <c:if test="${fn:length(actionBean.location.dealer.businessImprovements) == 0}">
                        <tr>
                            <td><fmt:message key="label.noitems"/></td>
                        </tr>
                    </c:if>
                    <c:if test="${fn:length(actionBean.location.dealer.businessImprovements) > 0}">
                        <c:forEach items="${actionBean.location.dealer.businessImprovements}" var="bi" varStatus="biStatus">
                            <tr class="itemRow">
                                <td>
                                    <span class="formValue">${bi.type.value}</span>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                </tbody>
            </table>
        </fieldset>
        <!--- ======  End Business Improvements stuffs  ========================== -->
    </nc:ifAccessAllowed>

</stripes:layout-definition>
