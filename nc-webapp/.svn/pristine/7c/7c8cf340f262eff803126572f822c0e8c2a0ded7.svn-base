<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    

    <li>
    <!--- =====   Start TMCA Field Rep  stuffs   ======================================== -->
    <fieldset id="tmcaInfo-representativesSection">
        <legend><fmt:message  key="dealer.businessPartnersInfo.tmcaFieldRep"/></legend>
        <table id="representativesTable">
                <tbody>
                <tr>
                        <%--
                            Here we have two FK fields, one is rendered as a span, and the other is rendered as input.
                            - The span FK is used for retrieving the TMCA Field Rep info, and to display in dialog box
                        --%>
                    <td><span class="formLabel"><fmt:message  key="dealer.businessPartnersInfo.dsmStaff"/></span></td>
                    <td id="DSMColumn" class="tmcaFieldRepColumn">
                        <span id="DSMNameInput" class="formValue">${actionBean.location.dealer.businessPartnersInfo.dsmStaff.fullName}</span>
                        <span id="DSMFKSpan" style="display:none" class="fkField">${actionBean.location.dealer.businessPartnersInfo.dsmStaff.personId}</span>
                    </td>
                </tr>
                <tr>
                    <td><span class="formLabel"><fmt:message  key="dealer.businessPartnersInfo.dsomStaff"/></span></td>
                    <td id="DSOMColumn" class="tmcaFieldRepColumn">
                        <span id="DSOMNameInput" class="formValue">${actionBean.location.dealer.businessPartnersInfo.dsomStaff.fullName}</span>
                        <span id="DSOMFKSpan" style="display:none" class="fkField">${actionBean.location.dealer.businessPartnersInfo.dsomStaff.personId}</span>
                    </td>
                </tr>
                <tr>
                    <td><span class="formLabel"><fmt:message  key="dealer.businessPartnersInfo.dcsaimStaff"/></span></td>
                    <td id="DCSAIMColumn" class="tmcaFieldRepColumn">
                        <span id="DCSAIMNameInput" class="formValue">${actionBean.location.dealer.businessPartnersInfo.dcsaimStaff.fullName}</span>
                        <span id="DCSAIMFKSpan" style="display:none" class="fkField">${actionBean.location.dealer.businessPartnersInfo.dcsaimStaff.personId}</span>
                    </td>
                </tr>
                <tr>
                    <td><span class="formLabel"><fmt:message  key="dealer.businessPartnersInfo.doprmStaff"/></span></td>
                    <td id="DOPRMColumn" class="tmcaFieldRepColumn">
                        <span id="DOPRMNameInput" class="formValue">${actionBean.location.dealer.businessPartnersInfo.doprmStaff.fullName}</span>
                        <span id="DOPRMFKSpan" style="display:none" class="fkField">${actionBean.location.dealer.businessPartnersInfo.doprmStaff.personId}</span>
                    </td>
                </tr>
                <tr>
                    <td><span class="formLabel"><fmt:message  key="dealer.businessPartnersInfo.technicalSpecialistStaff"/></span></td>
                    <td id="TechSpecColumn" class="tmcaFieldRepColumn">
                        <span id="TechSpecNameInput" class="formValue">${actionBean.location.dealer.businessPartnersInfo.technicalSpecialistStaff.fullName}</span>
                        <span id="TechSpecFKSpan" style="display:none" class="fkField">${actionBean.location.dealer.businessPartnersInfo.technicalSpecialistStaff.personId}</span>
                    </td>
                </tr>
                <tr>
                    <td><span class="formLabel"><fmt:message  key="dealer.businessPartnersInfo.raskmStaff"/></span></td>
                    <td id="RASKMColumn" class="tmcaFieldRepColumn">
                        <span id="RASKMNameInput" class="formValue">${actionBean.location.dealer.businessPartnersInfo.raskmStaff.fullName}</span>
                        <span id="RASKMFKSpan" style="display:none" class="fkField">${actionBean.location.dealer.businessPartnersInfo.raskmStaff.personId}</span>
                    </td>
                </tr>
                </tbody>
        </table>
    </fieldset>
    <!--- =====   End TMCA Field Rep  stuffs   ======================================== -->
    </li>



</stripes:layout-definition>
