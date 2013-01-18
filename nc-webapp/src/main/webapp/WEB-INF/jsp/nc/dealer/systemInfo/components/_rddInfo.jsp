<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>



    <nc:ifAccessAllowed name="dealer.rddInfo">
        <ul class="column-style-fieldset oneCol">
            <li>
                <fieldset id="systemInfo-rddAgreementSection">
                    <legend><fmt:message key="dealer.sysinfotab.section.rddagreement.header"/></legend>
                    <nc:label name="dealer.systemInfo.foundationFlag" for="dealer.systemInfo.foundationFlag"/>
                    <nc:checkbox id="dealer.systemInfo.foundationFlag" name="dealer.systemInfo.foundationFlag"/><br/>

                    <nc:label name="dealer.systemInfo.papisFlag" for="dealer.systemInfo.papisFlag"/>
                    <nc:checkbox id="dealer.systemInfo.papisFlag" name="dealer.systemInfo.papisFlag"/><br/>

                    <nc:label name="dealer.systemInfo.showroomFlag" for="dealer.systemInfo.showroomFlag"/>
                    <nc:checkbox id="dealer.systemInfo.showroomFlag" name="dealer.systemInfo.showroomFlag"/><br/>

                    <nc:label name="dealer.systemInfo.tjunctionRenewalDate" for="dealer.systemInfo.tjunctionRenewalDate"/>
                    <nc:datetext  id="dealer.systemInfo.tjunctionRenewalDate" name="dealer.systemInfo.tjunctionRenewalDate" class="dateField" showTime="true"  buttonId="renewalDateTrigger"/>
                </fieldset>
           </li>
        </ul>
        <div class="clear"></div>
    </nc:ifAccessAllowed>


</stripes:layout-definition>