<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

    <nc:ifAccessAllowed name="location.deliveryInfo">
        <!-- ======== Start Delivery Info ============================== -->
        <fieldset id="tmcaInfo-deliverySection">
            <legend><fmt:message key="location.tmcatab.section.delivery.header"/></legend>

        <nc:label name="location.destinationCode" for="location.destinationCode"/>
        <nc:text id="location.destinationCode" name="location.destinationCode"/><br/>

        <nc:label name="location.makerCode" for="location.makerCode"/>
        <nc:select id="location.makerCode" name="location.makerCode"
                   readOnlyValue="${actionBean.location.makerCode.description}">
            <option value=""><fmt:message key="label.selectone"/></option>
            <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.MakerCode" label="description"/>
        </nc:select>
        <!-- ======== End Delivery Info ============================== -->
        </fieldset>
    </nc:ifAccessAllowed>

</stripes:layout-definition>