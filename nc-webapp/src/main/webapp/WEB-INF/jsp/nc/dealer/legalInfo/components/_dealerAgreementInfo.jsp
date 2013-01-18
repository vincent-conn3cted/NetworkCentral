<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <%-- ==========================================
    Secure page stuffs
    =============================================--%>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

   <ul class="column-style-fieldset oneCol">
    <li>
    <fieldset id="legalInfo-dealerAgreementSection">
        <legend><fmt:message  key="dealer.legaltab.section.agreement.header"/></legend>

        <nc:label name="dealer.agreement.renewalDate" for="dealer.agreement.renewalDate"/>
        <nc:datetext id="dealer.agreement.renewalDate" name="dealer.agreement.renewalDate" class="dateField" buttonId="renewalDateTrigger" showTime="false"/><br/>

        <nc:label name="dealer.agreement.renewalTerm" for="dealer.agreement.renewalTerm"/>
        <nc:text id="dealer.agreement.renewalTerm" name="dealer.agreement.renewalTerm"/><br/>

        <nc:ifAccessAllowed name="dealer.agreement.timeremaining">
            <stripes:label name="dealer.agreement.timeremaining" for="dealer.agreement.timeremaining"/>
            <span id="dealer.agreement.timeremaining" class="formValue">
                <c:choose>
                    <c:when test="${actionBean.dealer.agreement.renewalDate ne null}">
                        <fmt:message key="dealer.agreement.timeremaining.value">
                            <fmt:param value="${actionBean.dealer.timeRemaining.years}"/>
                            <fmt:param value="${actionBean.dealer.timeRemaining.months}"/>
                            <fmt:param value="${actionBean.dealer.timeRemaining.days}"/>
                        </fmt:message>
                    </c:when>
                    <c:otherwise>
                        <fmt:message key="label.notavailable"/>
                    </c:otherwise>
                </c:choose>
             </span><br/>            
        </nc:ifAccessAllowed>

        <nc:label name="dealer.agreement.priusStartDate" for="dealer.agreement.priusStartDate"/>
        <nc:datetext id="dealer.agreement.priusStartDate" buttonId="priusStartDateTrigger" class="dateField" name="dealer.agreement.priusStartDate" showTime="false"/><br/>

        <nc:label name="dealer.agreement.yearsAsDealer" for="dealer.agreement.yearsAsDealer"/>
            <span id="dealer.agreement.yearsAsDealer" class="formValue">
                <c:choose>
                    <c:when test="${actionBean.dealer.generalInfo.appointmentDate ne null}">
                        ${actionBean.dealer.yearsAsDealer.years}
                    </c:when>
                    <c:otherwise>
                        <fmt:message key="label.notavailable"/>
                    </c:otherwise>
                </c:choose>
            </span><br/>

        <nc:label name="dealer.agreement.timeInDealership" for="dealer.agreement.timeInDealership"/>
        <nc:text id="dealer.agreement.timeInDealership" name="dealer.agreement.timeInDealership"/><br/>
    </fieldset>
   </li>
    </ul>
    <div class="clear"></div>
</stripes:layout-definition>