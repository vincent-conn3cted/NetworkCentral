<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <!-- for selenium tests: dealer staff staff numbers section -->
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${readOnly}"/>
    <ul class="column-style-fieldset oneCol">
        <li>
             <fieldset>
                <legend class="legend">Other Staff Numbers</legend>
                <nc:label name="dealerStaff.trainingIdNumber" for="dealerStaff.trainingIdNumber"/>
                <nc:text name="dealerStaff.trainingIdNumber" id="dealerStaff.trainingIdNumber"/><br/>

                <nc:label name="dealerStaff.salesSocietyNumber" for="dealerStaff.salesSocietyNumber"/>
                <nc:text name="dealerStaff.salesSocietyNumber" id="dealerStaff.salesSocietyNumber"/><br/>

                <nc:label name="dealerStaff.technicianSocietyNumber" for="dealerStaff.technicianSocietyNumber"/>
                <nc:text name="dealerStaff.technicianSocietyNumber" id="dealerStaff.technicianSocietyNumber"/><br/>
            </fieldset>
        </li>
    </ul>
    <div class="clear"></div>

    <nc:ifAccessAllowed name="dealerStaff.notes">
        <ul class="column-style-fieldset oneCol">
            <li>
               <fieldset>
                    <legend class="legend">Notes</legend>
                    <nc:label name="dealerStaff.notes" for="dealerStaff.notes"/>
                    <nc:textarea name="dealerStaff.notes" rows="4" cols="50" id="dealerStaff.notes"/><br/>
                </fieldset>
            </li>
        </ul>
    </nc:ifAccessAllowed>
    <div class="clear"></div>
</stripes:layout-definition>
