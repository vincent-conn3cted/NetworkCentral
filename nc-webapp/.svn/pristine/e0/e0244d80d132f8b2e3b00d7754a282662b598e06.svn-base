<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    

    <!--- =====     Start General Info =========================== -->
    <fieldset id="tmcaInfo-generalSection">
        <legend class="legend">General Information</legend>
        <label for="location.dealer.generalInfo.pma.name"><fmt:message key="pma.name"/></label>
        <span id="location.dealer.generalInfo.pma.name" class="formValue">${actionBean.location.dealer.generalInfo.pma.name}</span><br/>

        <nc:label name="subpma.name" for="location.subPMA.commonValueId"/>
        <nc:select-active-values selectedObject="${actionBean.location.subPMA}"
                                 valueAttribute="commonValueId"
                                 labelAttribute="value"
                                 id="location.subPMA.commonValueId"
                                 collections="${actionBean.allSubPMA}"
                                 name="location.subPMA.commonValueId">
            <option value=""><fmt:message key="label.selectone"/></option>
        </nc:select-active-values><br/>

        <label for="location.dealer.generalInfo.metroFlag"><fmt:message key="dealer.generalInfo.metroFlag"/></label>
        <span id="location.dealer.generalInfo.metroFlag" class="formValue">
            <c:if test="${actionBean.location.dealer.generalInfo.metroFlag}">
                           <fmt:message key="label.metro"/>
            </c:if>
            <c:if test="${!actionBean.location.dealer.generalInfo.metroFlag}">
                            <fmt:message key="label.rural"/>
            </c:if>
        </span><br/>

        <label for="location.dealer.generalInfo.region"><fmt:message key="dealer.generalInfo.region"/></label>
        <span id="location.dealer.generalInfo.region" class="formValue">${actionBean.location.dealer.generalInfo.region}</span><br/>

        <label for="location.dealer.generalInfo.regionClassification"><fmt:message key="dealer.generalInfo.regionClassification"/></label>
        <span id="location.dealer.generalInfo.regionClassification" class="formValue">${actionBean.location.dealer.generalInfo.regionClassification}</span><br/>

        <label for="location.dealer.generalInfo.salesDistrict"><fmt:message key="dealer.generalInfo.salesDistrict"/></label>
        <span id="location.dealer.generalInfo.salesDistrict" class="formValue">${actionBean.location.dealer.generalInfo.salesDistrict}</span><br/>

        <label for="location.dealer.generalInfo.operationDistrict"><fmt:message key="dealer.generalInfo.operationDistrict"/></label>
        <span id="location.dealer.generalInfo.operationDistrict" class="formValue">${actionBean.location.dealer.generalInfo.operationDistrict}</span><br/>

        <label for="location.dealer.generalInfo.serviceDistrict"><fmt:message key="dealer.generalInfo.serviceDistrict"/></label>
        <span id="location.dealer.generalInfo.serviceDistrict" class="formValue">${actionBean.location.dealer.generalInfo.serviceDistrict}</span><br/>

        <nc:label name="dealer.generalInfo.financialReportingFlag" for="location.dealer.generalInfo.financialReportingFlag"/>
        <nc:checkbox name="location.dealer.generalInfo.financialReportingFlag"/><br/>

        <nc:label name="location.newCorporateIdentityFlag" for="location.newCorporateIdentityFlag"/>
        <nc:checkbox name="location.newCorporateIdentityFlag"/><br/>

        <nc:label name="location.dealerPrefix" for="location.dealerPrefix.commonValueId"/>
        <nc:select-active-values selectedObject="${actionBean.location.dealerPrefix}"
                                 valueAttribute="commonValueId"
                                 labelAttribute="value"
                                 id="location.dealerPrefix.commonValueId"
                                 collections="${actionBean.allDealerPrefix}"
                                 name="location.dealerPrefix.commonValueId">
            <option value=""><fmt:message key="label.selectone"/></option>
        </nc:select-active-values><br/>
        
        <!-- // Add by Rick for Dealer Prefix and Financial Reporting enhancement; -->
        <nc:label name="location.financialsReportingFlag" for="location.financialsReportingFlag"/>
        <nc:checkbox name="location.financialsReportingFlag"/><br/>

    </fieldset>
    <!--- =====     End General Info =========================== -->
</stripes:layout-definition>
