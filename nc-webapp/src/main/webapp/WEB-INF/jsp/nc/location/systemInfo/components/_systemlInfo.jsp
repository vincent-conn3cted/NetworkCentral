<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    

    <nc:ifAccessAllowed name="dealer.systemInfo">
        <!-- ====================== Start System Info Section ===================== -->
        <fieldset id="systemInfo-systemSection">
            <legend><fmt:message  key="dealer.sysinfotab.section.general.header"/></legend>
            <nc:label name="dealer.systemInfo.coinContact" for="location.dealer.systemInfo.coinContact"/>
            <nc:text id="location.dealer.systemInfo.coinContact" name="location.dealer.systemInfo.coinContact"/><br/>

            <nc:label name="dealer.systemInfo.itConnectionType" for="location.dealer.systemInfo.itConnectionType.value"/>
            <nc:text  id="location.dealer.systemInfo.itConnectionType.value" name="location.dealer.systemInfo.itConnectionType.value"/><br/>

            <nc:label name="dealer.systemInfo.coinRouterDetails" for="location.dealer.systemInfo.coinRouterDetails"/>
            <nc:text id="location.dealer.systemInfo.coinRouterDetails" name="location.dealer.systemInfo.coinRouterDetails"/><br/>

            <nc:label name="dealer.systemInfo.contactType" for="location.dealer.systemInfo.contactType"/>
            <nc:text id="location.dealer.systemInfo.contactType" name="location.dealer.systemInfo.contactType"/><br/>

            <nc:label name="dealer.systemInfo.coinBandwidth" for="location.dealer.systemInfo.coinBandwidth"/>
            <nc:text id="location.dealer.systemInfo.coinBandwidth" name="location.dealer.systemInfo.coinBandwidth"/><br/>

            <nc:label name="dealer.systemInfo.connectionSpeed" for="location.dealer.systemInfo.connectionSpeed"/>
            <nc:text id="location.dealer.systemInfo.connectionSpeed" name="location.dealer.systemInfo.connectionSpeed"/><br/>

            <nc:label name="dealer.systemInfo.loginPrefix" for="location.dealer.systemInfo.loginPrefix"/>
            <nc:text id="location.dealer.systemInfo.loginPrefix" name="location.dealer.systemInfo.loginPrefix"/><br/>

            <nc:label name="dealer.systemInfo.itSystemDetails" for="location.dealer.systemInfo.itSystemDetails"/>
            <nc:textarea id="location.dealer.systemInfo.itSystemDetails" name="location.dealer.systemInfo.itSystemDetails"/><br/>
        </fieldset>
        <!-- ====================== End System Info Section ===================== -->
    </nc:ifAccessAllowed>

</stripes:layout-definition>