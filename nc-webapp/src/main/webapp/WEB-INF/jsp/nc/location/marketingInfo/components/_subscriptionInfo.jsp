<%@ page import="au.com.toyota.nc.common.model.hibernate.DocumentType" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    

     <!-- ============== Start Subscription Information ======================= -->
    <fieldset id="marketingInfo-subscriptionSection">
        <table id="subscriptionTable">
            <thead>
                <tr>
                    <th><fmt:message  key="subscription.name"/></th>
                    <th><fmt:message  key="subscription.tmcadivision"/></th>
                    <th><fmt:message  key="subscription.since"/></th>
                    <th><fmt:message  key="subscription.until"/></th>
                </tr>
            </thead>
            <tbody>
                  <c:if test="${fn:length(actionBean.location.dealer.marketingSubscription) == 0}">
                        <tr class="noItemRow">
                            <td><fmt:message key="label.noitems"/></td>
                        </tr>
                    </c:if>
                <c:if test="${fn:length(actionBean.location.dealer.marketingSubscription) > 0}">
                        <c:forEach items="${actionBean.location.dealer.marketingSubscription}" var="subscription" varStatus="subStatus">
                            <tr class="itemRow">
                                <td>
                                    <span class="formValue subscriptionTypeLabelField">${subscription.type.value}</span>
                                </td>
                                <td>
                                    <span class="formValue tmcaDivisionField">${subscription.tmcaDivision}</span>
                                </td>
                                <td>
                                    <span class="formValue startDateField">${subscription.subscriptionDate.startDate}</span>
                                </td>
                                <td>
                                    <span class="formValue endDateField">${subscription.subscriptionDate.endDate}</span>
                                </td>
                            </tr>
                        </c:forEach>
                </c:if>
            </tbody>
        </table>
    </fieldset>
    <!-- ============== End Subscription Information ======================= -->




</stripes:layout-definition>    