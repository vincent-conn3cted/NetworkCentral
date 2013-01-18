<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

    <fieldset id="tmcaInfo-generalSection">
        <label for="location.dealer.generalInfo.pma.name"><fmt:message key="pma.name"/></label>
        <span id="location.dealer.generalInfo.pma.name" class="formValue">${actionBean.location.dealer.generalInfo.pma.name}</span><br/>

        <label for="location.dealer.generalInfo.region"><fmt:message key="dealer.generalInfo.region"/></label>
        <span id="location.dealer.generalInfo.region" class="formValue">${actionBean.location.dealer.generalInfo.region}</span><br/>
        </fieldset>
</stripes:layout-definition>