<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    

    <ul  class="column-style-fieldset oneCol">
        <li>
            <fieldset id="generalInfo-communicationSection">
                <legend><fmt:message  key="dealer.generaltab.section.communication.header"/></legend>
				<stripes:layout-render name="/WEB-INF/jsp/nc/location/generalInfo/components/_communicationEmailURLContent.jsp" pageName="${pageName}" prefix="location"/>
            </fieldset>
        </li>
    </ul>

</stripes:layout-definition>