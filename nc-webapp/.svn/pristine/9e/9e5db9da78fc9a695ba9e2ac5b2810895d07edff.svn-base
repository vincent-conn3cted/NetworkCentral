<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <%-- ==========================================
    Secure page stuffs
    =============================================--%>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

    <nc:ifAccessAllowed name="dealer.financialInfo">
       <ul class="column-style-fieldset oneCol">
        <li>
        <fieldset id="legalInfo-financialInformationSection">
            <legend><fmt:message  key="dealer.legaltab.section.financial.header"/></legend>

            <nc:label name="dealer.financialInfo.financeCompany" for="dealer.financialInfo.financeCompany.commonValueId"/>
            <nc:select-active-values selectedObject="${actionBean.dealer.financialInfo.financeCompany}"
                                     collections="${actionBean.allFinanceCompanies}"
                                     valueAttribute="commonValueId"
                                     labelAttribute="value"
                                     id="dealer.financialInfo.financeCompany.commonValueId"
                                     name="dealer.financialInfo.financeCompany.commonValueId">
                <option value=""><fmt:message key="label.selectone"/></option>
            </nc:select-active-values><br/>

            <nc:label name="dealer.financialInfo.tfsAccountManager" for="dealer.financialInfo.tfsAccountManager"/>
            <nc:text id="dealer.financialInfo.tfsAccountManager" name="dealer.financialInfo.tfsAccountManager"/><br/>

            <nc:label name="dealer.financialInfo.changeDate" for="dealer.financialInfo.changeDate"/>
            <nc:datetext id="dealer.financialInfo.changeDate" name="dealer.financialInfo.changeDate" class="dateField" buttonId="changeDateTrigger" showTime="false"/><br/>

            <nc:label name="dealer.financialInfo.rctiAgreement" for="dealer.financialInfo.rctiAgreement"/>
            <nc:select id="dealer.financialInfo.rctiAgreement" name="dealer.financialInfo.rctiAgreement" readOnlyValue="${actionBean.dealer.financialInfo.rctiAgreement}">
                <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.RTCIAgreement"/>
            </nc:select><br/>


            <nc:label name="dealer.financialInfo.autoReleaseNumber" for="dealer.financialInfo.autoReleaseNumber"/>
            <nc:text id="dealer.financialInfo.autoReleaseNumber" name="dealer.financialInfo.autoReleaseNumber"/><br/>

            <nc:label name="dealer.financialInfo.manualReleaseFlag" for="dealer.financialInfo.manualReleaseFlag"/>
            <nc:checkbox id="dealer.financialInfo.manualReleaseFlag" name="dealer.financialInfo.manualReleaseFlag"/><br/>
        </fieldset>
          </li>
        </ul>
        <div class="clear"></div>
    </nc:ifAccessAllowed>

</stripes:layout-definition>