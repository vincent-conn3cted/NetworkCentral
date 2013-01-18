<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    

        <li>
        <!--- =====   Start Weights stuffs   ======================================== -->
        <fieldset id="tmcaInfo-weightGroupsSection">
            <legend><fmt:message  key="dealer.tmcatab.section.weights.header"/></legend>
            <c:set var="toyotaFranchise" value="<%=au.com.toyota.nc.common.model.hibernate.ToyotaFranchise.Toyota%>"/>
            <c:set var="lexusFranchise" value="<%=au.com.toyota.nc.common.model.hibernate.ToyotaFranchise.Lexus%>"/>

            <c:if test="${actionBean.location.dealer.generalInfo.mainFranchise eq toyotaFranchise}">
                <nc:label name="dealer.weightsInfo.salesWeight" for="location.dealer.weightsInfo.salesWeight.value"/>
                <nc:text name="location.dealer.weightsInfo.salesWeight.value" id="location.dealer.weightsInfo.salesWeight.value"/><br/>

                <nc:label name="dealer.weightsInfo.usedVehicleWeight" for="location.dealer.weightsInfo.usedVehicleWeight.value"/>
                <nc:text name="location.dealer.weightsInfo.usedVehicleWeight.value" id="location.dealer.weightsInfo.usedVehicleWeight.value"/><br/>

                <nc:label name="dealer.weightsInfo.serviceWeight" for="location.dealer.weightsInfo.serviceWeight.value"/>
                <nc:text name="location.dealer.weightsInfo.serviceWeight.value" id="location.dealer.weightsInfo.serviceWeight.value"/><br/>

                <nc:label name="dealer.weightsInfo.partsWeight" for="location.dealer.weightsInfo.partsWeight.value"/>
                <nc:text name="location.dealer.weightsInfo.partsWeight.value" id="location.dealer.weightsInfo.partsWeight.value"/><br/>

                <nc:label name="dealer.weightsInfo.accessoriesWeight" for="location.dealer.weightsInfo.accessoriesWeight.value"/>
                <nc:text name="location.dealer.weightsInfo.accessoriesWeight.value" id="location.dealer.weightsInfo.accessoriesWeight.value"/><br/>

                <nc:label name="dealer.weightsInfo.csiWeight" for="location.dealer.weightsInfo.csiWeight.value"/>
                <nc:text name="location.dealer.weightsInfo.csiWeight.value" id="location.dealer.weightsInfo.csiWeight.value"/><br/>
            </c:if>
            <c:if test="${actionBean.location.dealer.generalInfo.mainFranchise eq lexusFranchise}">
                <nc:label name="dealer.weightsInfo.lexusWeight" for="location.dealer.weightsInfo.lexusWeight.value"/>
                <nc:text name="location.dealer.weightsInfo.lexusWeight.value" id="location.dealer.weightsInfo.lexusWeight.value"/><br/>
            </c:if>
        </fieldset>
        <!--- =====   End Weights stuffs   ======================================== -->
        </li>    


</stripes:layout-definition>
