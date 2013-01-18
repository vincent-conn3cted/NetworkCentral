<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <%-- ==========================================
    Secure page stuffs
    =============================================--%>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>


    <ul class="column-style-fieldset oneCol">
        <li>
            <fieldset id="generalInfo-generalSection">
                <legend class="legend">General Information</legend>

                <stripes:hidden name="dealer.dealerId"/>
                <nc:label name="dealer.generalInfo.dealerName" for="dealer.generalInfo.dealerName"/>
                <nc:text name="dealer.generalInfo.dealerName" id="dealer.generalInfo.dealerName"/><br/>

                <stripes:label name="code.dealer" for="dealer.generalInfo.dealerCode"/>
                <span id="dealer.generalInfo.dealerCode" class="formValue">${actionBean.dealer.generalInfo.dealerCode}</span><br/>

                <stripes:label name="code.dealer.sap" for="dealer.generalInfo.sapDealerCode"/>
                <span id="dealer.generalInfo.sapDealerCode" class="formValue"> ${actionBean.dealer.generalInfo.sapDealerCode} </span><br/>

                <stripes:label name="code.partsdealer" for="dealer.generalInfo.partsDealerCode"/>
                <span id="dealer.generalInfo.partsDealerCode" class="formValue">${actionBean.dealer.generalInfo.partsDealerCode}</span>
            </fieldset>
        </li>
    </ul>

</stripes:layout-definition>