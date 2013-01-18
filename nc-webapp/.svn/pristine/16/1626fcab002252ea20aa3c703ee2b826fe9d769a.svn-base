<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
       <%-- ==========================================
     Secure page stuffs
     =============================================--%>
        <nc:pageName pageName="${pageName}"/>
     <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>


    <nc:ifAccessAllowed name="dealer.ownershipInfo">
       <ul class="column-style-fieldset oneCol">
            <li>
                <fieldset id="legalInfo-ownershipDetailsSection">
                     <legend><fmt:message  key="dealer.legaltab.section.ownership.header"/></legend>
                    <nc:label name="dealer.ownershipInfo.dpPercentageEquity" for="dealer.ownershipInfo.dpPercentageEquity"/>
                    <nc:text id="dealer.ownershipInfo.dpPercentageEquity" name="dealer.ownershipInfo.dpPercentageEquity"/><br/>

                    <nc:label name="dealer.ownershipInfo.tmcaOwnershipFlag" for="dealer.ownershipInfo.tmcaOwnershipFlag"/>
                    <nc:checkbox id="dealer.ownershipInfo.tmcaOwnershipFlag" name="dealer.ownershipInfo.tmcaOwnershipFlag"/><br/>
                </fieldset>
           </li>
        </ul>
        <div class="clear"></div>
    </nc:ifAccessAllowed>
</stripes:layout-definition>