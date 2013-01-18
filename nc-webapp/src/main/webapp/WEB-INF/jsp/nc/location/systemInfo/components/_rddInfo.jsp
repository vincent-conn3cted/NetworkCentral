<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    

    <nc:ifAccessAllowed name="dealer.rddInfo">
        <!-- ====================== Start RDD Info Section ===================== -->
        <fieldset id="systemInfo-rddAgreementSection">
            <legend><fmt:message key="dealer.sysinfotab.section.rddagreement.header"/></legend>

            <nc:label name="dealer.systemInfo.foundationFlag" for="location.dealer.systemInfo.foundationFlag"/>
            <nc:checkbox id="location.dealer.systemInfo.foundationFlag" name="location.dealer.systemInfo.foundationFlag"/><br/>

            <nc:label name="dealer.systemInfo.papisFlag" for="location.dealer.systemInfo.papisFlag"/>
            <nc:checkbox id="location.dealer.systemInfo.papisFlag" name="location.dealer.systemInfo.papisFlag"/><br/>

            <nc:label name="dealer.systemInfo.showroomFlag" for="location.dealer.systemInfo.showroomFlag"/>
            <nc:checkbox id="location.dealer.systemInfo.showroomFlag" name="location.dealer.systemInfo.showroomFlag"/><br/>

            <nc:label name="dealer.systemInfo.tjunctionRenewalDate" for="location.dealer.systemInfo.tjunctionRenewalDate"/>
            <nc:text  id="location.dealer.systemInfo.tjunctionRenewalDate" name="location.dealer.systemInfo.tjunctionRenewalDate"/><br/>
        </fieldset>
        <!-- ====================== End RDD Info Section ===================== -->
    </nc:ifAccessAllowed>

</stripes:layout-definition>

