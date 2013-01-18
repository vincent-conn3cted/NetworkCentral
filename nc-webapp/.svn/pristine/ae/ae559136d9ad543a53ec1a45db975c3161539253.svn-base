<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    


    <nc:ifAccessAllowed name="dealer.dealerGroupMembershipInfo">
        <li>
        <!--- =====   Start Dealer Group Membership stuffs   ======================================== -->
        <fieldset id="tmcaInfo-dealerGroupMembershipSection">
            <legend><fmt:message  key="dealer.tmcatab.section.dealergroups.header"/></legend>
            <nc:label name="dealer.dealerGroupMembershipInfo.kaizenCommitteeFlag" for="location.dealer.dealerGroupMembershipInfo.kaizenCommitteeFlag"/>
            <nc:checkbox name="location.dealer.dealerGroupMembershipInfo.kaizenCommitteeFlag"/><br/>

            <nc:label name="dealer.dealerGroupMembershipInfo.salesReportingFlag" for="location.dealer.dealerGroupMembershipInfo.salesReportingFlag"/>
            <nc:checkbox name="location.dealer.dealerGroupMembershipInfo.salesReportingFlag"/><br/>

            <nc:label name="dealer.dealerGroupMembershipInfo.stockLocatorFlag" for="location.dealer.dealerGroupMembershipInfo.stockLocatorFlag"/>
            <nc:checkbox name="location.dealer.dealerGroupMembershipInfo.stockLocatorFlag"/><br/>

            <nc:label name="dealer.dealerGroupMembershipInfo.certifiedUsedVehicleFlag" for="location.dealer.dealerGroupMembershipInfo.certifiedUsedVehicleFlag"/>
            <nc:checkbox name="location.dealer.dealerGroupMembershipInfo.certifiedUsedVehicleFlag"/><br/>

            <nc:label name="dealer.dealerGroupMembershipInfo.twrsParticipantFlag" for="location.dealer.dealerGroupMembershipInfo.twrsParticipantFlag"/>
            <nc:checkbox name="location.dealer.dealerGroupMembershipInfo.twrsParticipantFlag"/><br/>

            <nc:label name="dealer.dealerGroupMembershipInfo.tfsAuthToViewFlag" for="location.dealer.dealerGroupMembershipInfo.tfsAuthToViewFlag"/>
            <nc:checkbox name="location.dealer.dealerGroupMembershipInfo.tfsAuthToViewFlag"/><br/>
        </fieldset>
        <!--- =====   End Dealer Group Membership stuffs   ======================================== -->
        </li>
    </nc:ifAccessAllowed>


</stripes:layout-definition>
