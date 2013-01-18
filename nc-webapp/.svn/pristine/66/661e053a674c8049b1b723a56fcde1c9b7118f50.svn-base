<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    

    <ul class="column-style-fieldset oneCol">
        <li>
            <!--- =====     Start Corporate Info =========================== -->
            <fieldset id="generalInfo-corporateSection">
                <legend class="legend">Corporate</legend>
                <c:if test="${actionBean.location.dealer.principalLocation.dpGmrAppointment ne null}">
                     <nc:label name="position.dpGmr" for="location.dealer.principalLocation.dpGmrAppointment.person.fullName"/>
                    <nc:text id="location.dealer.principalLocation.dpGmrAppointment.person.fullName" name="location.dealer.principalLocation.dpGmrAppointment.person.fullName"/><br/>
                </c:if>

                <nc:label name="operatingEntity.name" for="location.dealer.generalInfo.operatingEntity.name"/>
                <nc:text id="location.dealer.generalInfo.operatingEntity.name" name="location.dealer.generalInfo.operatingEntity.name"/><br/>

                <nc:label name="operatingEntity.abn" for="location.dealer.generalInfo.operatingEntity.abn"/>
                <nc:text id="location.dealer.generalInfo.operatingEntity.abn" name="location.dealer.generalInfo.operatingEntity.abn" readonly="true"/><br/>

                <nc:label name="operatingEntity.acn" for="location.dealer.generalInfo.operatingEntity.acn"/>
                <nc:text id="location.dealer.generalInfo.operatingEntity.acn" name="location.dealer.generalInfo.operatingEntity.acn" readonly="true"/><br/>

                <nc:label name="label.companyStructure" for="location.dealer.generalInfo.operatingEntity.companyStructure"/>
                <nc:text id="location.dealer.generalInfo.operatingEntity.companyStructure" name="location.dealer.generalInfo.operatingEntity.companyStructure" readonly="true"/><br/>

                <nc:label name="group.name" for="location.dealer.generalInfo.group.name"/>
                <nc:text name="location.dealer.generalInfo.group.name"/><br/>
            </fieldset>
            <!--- =====     End Corporate Info  =========================== -->
        </li>
    </ul>


</stripes:layout-definition>