<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    

    <!-- ====== Start Identification Numbers Info =================== -->
    <fieldset id="identificationInfo-generalSection">
        <nc:label name="code.dealer" for="location.dealer.generalInfo.dealerCode"/>
        <nc:text id="location.dealer.generalInfo.dealerCode" name="location.dealer.generalInfo.dealerCode"/><br/>

        <nc:label name="code.dealer.sap" for="location.dealer.generalInfo.sapDealerCode"/>
        <nc:text id="location.dealer.generalInfo.sapDealerCode" name="location.dealer.generalInfo.sapDealerCode"/><br/>

        <nc:label name="code.partsdealer" for="location.dealer.generalInfo.partsDealerCode"/>
        <nc:text id="location.dealer.generalInfo.partsDealerCode" name="location.dealer.generalInfo.partsDealerCode"/><br/>
        
        <nc:label name="code.motordealerlicensenumber" for="location.dealer.generalInfo.motorDealerLicenseNumber"/>
        <nc:text id="location.dealer.generalInfo.motorDealerLicenseNumber" name="location.dealer.generalInfo.motorDealerLicenseNumber"/><br/>

        <nc:label name="code.branch" for="location.branchCode"/>
        <nc:text id="location.branchCode" name="location.branchCode"/><br/>

        <%--
        Entering SAP code is allowed only when Dealer's SAP code has been provided
         Note that Principal Location wont go through this path. The location SAP code for
         a Principal Location is the same as Dealer's SAP code.
        --%>
        <c:if test="${actionBean.location.dealer.generalInfo.sapDealerCode ne null}">
            <nc:label name="code.branch.sap" for="location.sapCode"/>
             <%--
                Location SAP Code is editable only for Draft location
            --%>
            <c:choose>
                <c:when test="${actionBean.location.draft || actionBean.location.type == 'Satellite'}">
                    <nc:text id="location.sapCode" name="location.sapCode"/><br/>
                </c:when>
                <c:otherwise>
                     <%--
                    We need to put the guard here, since  SAP code is not necessarily displayed for some roles
                     nc:text already does this business.. so no check is needed there.
                    --%>
                    <nc:ifAccessAllowed name="location.sapCode">
                        <span id="location.sapCode" class="formValue">${actionBean.location.sapCode}</span><br/>
                    </nc:ifAccessAllowed>
                </c:otherwise>
            </c:choose>
        </c:if>

        <nc:label name="code.partsbranch" for="location.partsBranchCode"/>
        <nc:text id="location.partsBranchCode" name="location.partsBranchCode"/><br/>

        <nc:label name="code.multisite" for="location.multisiteCode"/>
        <nc:text id="location.multisiteCode" name="location.multisiteCode"/><br/>

        <nc:label name="code.daso.dealer" for="location.dasoDealerCode"/>
        <nc:text id="location.dasoDealerCode" name="location.dasoDealerCode"/><br/>

        <nc:label name="code.daso.parts" for="location.dasoPartsCode"/>
        <nc:text id="location.dasoPartsCode" name="location.dasoPartsCode"/><br/>
    </fieldset>

    <nc:ifWriteAccessAllowed name="location.sapCode">
        <stripes:layout-render name="/WEB-INF/jsp/nc/location/_locationSAPCodeVerificator.jsp"
                                   dealerSAPCode="${actionBean.location.dealer.generalInfo.sapDealerCode}"
                                   locationSAPCodeInputId="location\\\\.sapCode"/>
    </nc:ifWriteAccessAllowed>
    <!-- ====== End Identification Numbers Info =================== -->
</stripes:layout-definition>