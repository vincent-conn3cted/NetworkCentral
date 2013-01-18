<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>


    <nc:ifAccessAllowed name="dealer.weightsInfo">
        <!--- =====   Start Weights stuffs   ======================================== -->
        <li>
        <fieldset id="tmcaInfo-weightGroupsSection">
            <legend><fmt:message  key="dealer.tmcatab.section.weights.header"/></legend>
            <c:set var="toyotaFranchise" value="<%=au.com.toyota.nc.common.model.hibernate.ToyotaFranchise.Toyota%>"/>
            <c:set var="lexusFranchise" value="<%=au.com.toyota.nc.common.model.hibernate.ToyotaFranchise.Lexus%>"/>

            <c:if test="${actionBean.dealer.generalInfo.mainFranchise eq toyotaFranchise}">
                <nc:label name="dealer.weightsInfo.salesWeight" for="dealer.weightsInfo.salesWeight.commonValueId"/>
                <nc:select-active-values selectedObject="${actionBean.dealer.weightsInfo.salesWeight}"
                                         collections="${actionBean.allToyotaWeightGroupValues}"
                                         valueAttribute="commonValueId"
                                         labelAttribute="value"
                                         id="tmcaInfo-weightGroupsSection-sales"
                                         name="dealer.weightsInfo.salesWeight.commonValueId">
                    <option value=""><fmt:message key="label.selectone"/></option>
                </nc:select-active-values><br/>

                <nc:label name="dealer.weightsInfo.usedVehicleWeight" for="dealer.weightsInfo.usedVehicleWeight.commonValueId"/>
                <nc:select-active-values selectedObject="${actionBean.dealer.weightsInfo.usedVehicleWeight}"
                                         collections="${actionBean.allToyotaWeightGroupValues}"
                                         valueAttribute="commonValueId"
                                         labelAttribute="value"
                                         id="tmcaInfo-weightGroupsSection-usedVehicles"
                                         name="dealer.weightsInfo.usedVehicleWeight.commonValueId">
                    <option value=""><fmt:message key="label.selectone"/></option>
                </nc:select-active-values><br/>

                <nc:label name="dealer.weightsInfo.serviceWeight" for="dealer.weightsInfo.serviceWeight.commonValueId"/>
                <nc:select-active-values selectedObject="${actionBean.dealer.weightsInfo.serviceWeight}"
                                         collections="${actionBean.allToyotaWeightGroupValues}"
                                         valueAttribute="commonValueId"
                                         labelAttribute="value"
                                         id="tmcaInfo-weightGroupsSection-service"
                                         name="dealer.weightsInfo.serviceWeight.commonValueId">
                    <option value=""><fmt:message key="label.selectone"/></option>
                </nc:select-active-values><br/>

                <nc:label name="dealer.weightsInfo.partsWeight" for="dealer.weightsInfo.partsWeight.commonValueId"/>
                <nc:select-active-values selectedObject="${actionBean.dealer.weightsInfo.partsWeight}"
                                         collections="${actionBean.allToyotaWeightGroupValues}"
                                         valueAttribute="commonValueId"
                                         labelAttribute="value"
                                         id="tmcaInfo-weightGroupsSection-parts"
                                         name="dealer.weightsInfo.partsWeight.commonValueId">
                    <option value=""><fmt:message key="label.selectone"/></option>
                </nc:select-active-values><br/>

                <nc:label name="dealer.weightsInfo.accessoriesWeight" for="dealer.weightsInfo.accessoriesWeight.commonValueId"/>
                <nc:select-active-values selectedObject="${actionBean.dealer.weightsInfo.accessoriesWeight}"
                                         collections="${actionBean.allToyotaWeightGroupValues}"
                                         valueAttribute="commonValueId"
                                         labelAttribute="value"
                                         id="tmcaInfo-weightGroupsSection-accessories"
                                         name="dealer.weightsInfo.accessoriesWeight.commonValueId">
                    <option value=""><fmt:message key="label.selectone"/></option>
                </nc:select-active-values><br/>

                <nc:label name="dealer.weightsInfo.csiWeight" for="dealer.weightsInfo.csiWeight.commonValueId"/>
                <nc:select-active-values selectedObject="${actionBean.dealer.weightsInfo.csiWeight}"
                                         collections="${actionBean.allToyotaWeightGroupValues}"
                                         valueAttribute="commonValueId"
                                         labelAttribute="value"
                                         id="tmcaInfo-weightGroupsSection-csi"
                                         name="dealer.weightsInfo.csiWeight.commonValueId">
                    <option value=""><fmt:message key="label.selectone"/></option>
                </nc:select-active-values><br/>
            </c:if>
            <c:if test="${actionBean.dealer.generalInfo.mainFranchise eq lexusFranchise}">
                <nc:label name="dealer.weightsInfo.lexusWeight" for="dealer.weightsInfo.lexusWeight.commonValueId"/>
                <nc:select-active-values selectedObject="${actionBean.dealer.weightsInfo.lexusWeight}"
                                         collections="${actionBean.allLexusWeightGroupValues}"
                                         valueAttribute="commonValueId"
                                         labelAttribute="value"
                                         name="dealer.weightsInfo.lexusWeight.commonValueId">
                    <option value=""><fmt:message key="label.selectone"/></option>
                </nc:select-active-values><br/>
            </c:if>
        </fieldset>
        </li>
        <!--- =====   End Weights stuffs   ======================================== -->
    </nc:ifAccessAllowed>

</stripes:layout-definition>