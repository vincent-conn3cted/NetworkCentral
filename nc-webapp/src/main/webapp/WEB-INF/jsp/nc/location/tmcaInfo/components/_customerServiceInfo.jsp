<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    


        <nc:ifAccessAllowed name="dealer.customerServiceInfo">
            <li>
        <!--- =====   Start Customer Service  stuffs   ======================================== -->
        <fieldset id="tmcaInfo-customerServiceSection">
            <legend><fmt:message  key="dealer.tmcatab.section.custinfo.header"/></legend>
            <nc:label name="dealer.customerServiceInfo.dealerWarrantyCode" for="location.dealer.customerServiceInfo.dealerWarrantyCode"/>
            <nc:text name="location.dealer.customerServiceInfo.dealerWarrantyCode"/><br/>

            <nc:label name="dealer.customerServiceInfo.repairingDealerFlag" for="location.dealer.customerServiceInfo.repairingDealerFlag"/>
            <nc:checkbox name="location.dealer.customerServiceInfo.repairingDealerFlag"/><br/>

            <nc:label name="dealer.customerServiceInfo.extracareWarrantyFlag" for="location.dealer.customerServiceInfo.extracareWarrantyFlag"/>
            <nc:checkbox name="location.dealer.customerServiceInfo.extracareWarrantyFlag"/><br/>

            <nc:label name="dealer.customerServiceInfo.serviceOpStandardComplianceFlag" for="location.dealer.customerServiceInfo.serviceOpStandardComplianceFlag"/>
            <nc:checkbox name="location.dealer.customerServiceInfo.serviceOpStandardComplianceFlag"/><br/>
        </fieldset>
        <!--- =====   End Customer Service stuffs   ======================================== -->
            </li>
    </nc:ifAccessAllowed>

</stripes:layout-definition>
