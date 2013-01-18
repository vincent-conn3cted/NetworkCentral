<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    

    <ul class="column-style-fieldset oneCol">
        <li>
            <!--- =====     Start Notes Info =========================== -->
            <nc:ifAccessAllowed name="location.note">
                <fieldset id="generalInfo-notesSection">
                    <nc:label name="label.note" for="location.note"/>
                    <nc:textarea name="location.note"/>
                </fieldset>                
            </nc:ifAccessAllowed>
            <!--- =====     End Notes Info  =========================== -->
        </li>
    </ul>

</stripes:layout-definition>