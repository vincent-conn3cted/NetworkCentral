<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    

     <nc:ifAccessAllowed name="dealer.systemInfo">
           <ul class="column-style-fieldset oneCol">
                <li>
                     <fieldset id="systemInfo-systemSection">
                            <legend><fmt:message  key="dealer.sysinfotab.section.general.header"/></legend>
                            <nc:label name="dealer.systemInfo.coinContact" for="dealer.systemInfo.coinContact"/>
                            <nc:text id="dealer.systemInfo.coinContact" name="dealer.systemInfo.coinContact"/><br/>

                            <nc:label name="dealer.systemInfo.itConnectionType" for="dealer.systemInfo.itConnectionType.commonValueId"/>
                            <nc:select-active-values selectedObject="${actionBean.dealer.systemInfo.itConnectionType}"
                                                     valueAttribute="commonValueId"
                                                     labelAttribute="value"
                                                     collections="${actionBean.allITConnectionType}"
                                                     id="dealer.systemInfo.itConnectionType.commonValueId"
                                                     name="dealer.systemInfo.itConnectionType.commonValueId">
                                <option value=""><fmt:message key="label.selectone"/></option>
                            </nc:select-active-values><br/>

                            <nc:label name="dealer.systemInfo.coinRouterDetails" for="dealer.systemInfo.coinRouterDetails"/>
                            <nc:text id="dealer.systemInfo.coinRouterDetails" name="dealer.systemInfo.coinRouterDetails"/><br/>

                            <nc:label name="dealer.systemInfo.contactType" for="dealer.systemInfo.contactType"/>
                            <nc:text id="dealer.systemInfo.contactType" name="dealer.systemInfo.contactType"/><br/>

                            <nc:label name="dealer.systemInfo.coinBandwidth" for="dealer.systemInfo.coinBandwidth"/>
                            <nc:text id="dealer.systemInfo.coinBandwidth" name="dealer.systemInfo.coinBandwidth"/><br/>

                            <nc:label name="dealer.systemInfo.connectionSpeed" for="dealer.systemInfo.connectionSpeed"/>
                            <nc:text id="dealer.systemInfo.connectionSpeed" name="dealer.systemInfo.connectionSpeed"/><br/>

                            <nc:label name="dealer.systemInfo.loginPrefix" for="dealer.systemInfo.loginPrefix"/>
                            <nc:text id="dealer.systemInfo.loginPrefix" name="dealer.systemInfo.loginPrefix"/><br/>

                            <nc:label name="dealer.systemInfo.itSystemDetails" for="dealer.systemInfo.itSystemDetails"/>
                            <nc:textarea id="dealer.systemInfo.itSystemDetails" name="dealer.systemInfo.itSystemDetails"/><br/>
                        </fieldset>
            </li>
        </ul>
         <div class="clear"></div>
    </nc:ifAccessAllowed>


</stripes:layout-definition>