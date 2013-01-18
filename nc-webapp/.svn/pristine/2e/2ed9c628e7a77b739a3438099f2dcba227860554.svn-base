<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>


    <nc:ifAccessAllowed name="dealer.dealerGroupMembershipInfo">
        <li>
        <!--- =====   Start Dealer Group Membership stuffs   ======================================== -->
        <fieldset id="tmcaInfo-dealerGroupMembershipSection" class="twocols">
            <legend><fmt:message  key="dealer.tmcatab.section.dealergroups.header"/></legend>
            <nc:label name="dealer.dealerGroupMembershipInfo.kaizenCommitteeFlag" for="dealer.dealerGroupMembershipInfo.kaizenCommitteeFlag"/>
            <nc:checkbox name="dealer.dealerGroupMembershipInfo.kaizenCommitteeFlag"/><br/>

            <nc:label name="dealer.dealerGroupMembershipInfo.salesReportingFlag" for="dealer.dealerGroupMembershipInfo.salesReportingFlag"/>
            <nc:checkbox name="dealer.dealerGroupMembershipInfo.salesReportingFlag"/><br/>

            <nc:label name="dealer.dealerGroupMembershipInfo.stockLocatorFlag" for="dealer.dealerGroupMembershipInfo.stockLocatorFlag"/>
            <nc:checkbox name="dealer.dealerGroupMembershipInfo.stockLocatorFlag"/><br/>

            <nc:label name="dealer.dealerGroupMembershipInfo.certifiedUsedVehicleFlag" for="dealer.dealerGroupMembershipInfo.certifiedUsedVehicleFlag"/>
            <nc:checkbox name="dealer.dealerGroupMembershipInfo.certifiedUsedVehicleFlag"/><br/>

            <nc:label name="dealer.dealerGroupMembershipInfo.twrsParticipantFlag" for="dealer.dealerGroupMembershipInfo.twrsParticipantFlag"/>
            <nc:checkbox name="dealer.dealerGroupMembershipInfo.twrsParticipantFlag"/><br/>

            <nc:label name="dealer.dealerGroupMembershipInfo.tfsAuthToViewFlag" for="dealer.dealerGroupMembershipInfo.tfsAuthToViewFlag"/>
            <nc:checkbox name="dealer.dealerGroupMembershipInfo.tfsAuthToViewFlag"/><br/>
        </fieldset>
        <!--- =====   End Dealer Group Membership stuffs   ======================================== -->
        </li>
    </nc:ifAccessAllowed>



</stripes:layout-definition>