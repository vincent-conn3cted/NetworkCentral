<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${readOnly}"/>

    <nc:ifAccessAllowed name="dealerStaff.spouseTitle">
        <nc:ifAccessAllowed name="dealerStaff.spouseFirstname">
            <nc:ifAccessAllowed name="dealerStaff.spouseSurname">

                <%-- Only show the fieldset area if at least one of the fields is available for viewing --%>

                <fieldset id="staff-spouse-details">
                    <legend class="legend">Spouse Details</legend>
                    <nc:label name="dealerStaff.spouseTitle" for="dealerStaff.spouseTitle"/>
                    <nc:select name="dealerStaff.spouseTitle" id="dealerStaff.spouseTitle" readOnlyValue="${actionBean.dealerStaff.spouseTitle}">
                            <stripes:option value=""/>
                            <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.Title"/>
                    </nc:select><br/>

                    <nc:label name="dealerStaff.spouseFirstname" for="dealerStaff.spouseFirstname"/>
                    <nc:text name="dealerStaff.spouseFirstname" id="dealerStaff.spouseFirstname"/><br/>

                    <nc:label name="dealerStaff.spouseSurname" for="dealerStaff.spouseSurname"/>
                    <nc:text name="dealerStaff.spouseSurname" id="dealerStaff.spouseSurname"/><br/>
                </fieldset>
                
            </nc:ifAccessAllowed>
        </nc:ifAccessAllowed>
    </nc:ifAccessAllowed>

</stripes:layout-definition>
