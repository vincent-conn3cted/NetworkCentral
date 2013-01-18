<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    


    <ul class="column-style-fieldset oneCol">
        <li>
            <!--- =====     Start Franchise Info =========================== -->
            <fieldset id="generalInfo-franchiseSection">
                <legend class="legend">Franchise</legend>
                <nc:ifAccessAllowed name="location.dealer.generalInfo.mainFranchise">
                    <stripes:label name="dealer.generalInfo.mainFranchise" for="location.dealer.generalInfo.mainFranchise"/>
                    <c:out value="${actionBean.location.dealer.generalInfo.mainFranchise}"/>
                    <br/>
                </nc:ifAccessAllowed>
            </fieldset>
            <!--- =====     End Franchise Info  =========================== -->
        </li>
    </ul>
</stripes:layout-definition>