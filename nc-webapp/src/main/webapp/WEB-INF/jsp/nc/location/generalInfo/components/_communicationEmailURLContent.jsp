<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

    <nc:label name="label.salesEmail" for="${prefix}.contact.salesEmail"/>
    <nc:text id="${prefix}.contact.salesEmail" name="${prefix}.contact.salesEmail"/><br/>

    <nc:label name="label.partsEmail" for="${prefix}.contact.partsEmail"/>
    <nc:text id="${prefix}.contact.partsEmail" name="${prefix}.contact.partsEmail"/><br/>

    <nc:label name="label.csEmail" for="${prefix}.contact.csEmail"/>
    <nc:text id="${prefix}.contact.csEmail" name="${prefix}.contact.csEmail"/><br/>

    <nc:label name="label.serviceEmail" for="${prefix}.contact.serviceEmail"/>
    <nc:text id="${prefix}.contact.serviceEmail" name="${prefix}.contact.serviceEmail"/><br/>

    <nc:label name="label.serviceUrl" for="${prefix}.contact.serviceUrl"/>
    <nc:text id="${prefix}.contact.serviceUrl" name="${prefix}.contact.serviceUrl"/><br/>

</stripes:layout-definition>