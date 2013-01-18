<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    

    <nc:ifAccessAllowed name="location.deliveryInfo">
        <!-- ======== Start Delivery Info ============================== -->
        <fieldset id="tmcaInfo-deliverySection">
                <legend><fmt:message key="location.tmcatab.section.delivery.header"/></legend>
                <nc:label name="location.partsDelivery.address" for="location.partsDelivery.address"/>
                <nc:text id="location.partsDelivery.address" name="location.partsDelivery.address"/><br/>

                <nc:label name="location.partsDelivery.fromTime" for="location.partsDelivery.fromTime"/>
                <nc:text id="location.partsDelivery.fromTime" name="location.partsDelivery.fromTime"/><br/>

                <nc:label name="location.partsDelivery.toTime" for="location.partsDelivery.toTime"/>
                <nc:text id="location.partsDelivery.toTime" name="location.partsDelivery.toTime"/><br/>

                <nc:label name="location.partsDelivery.instructions" for="location.partsDelivery.instructions"/>
                <nc:text id="location.partsDelivery.instructions" name="location.partsDelivery.instructions"/><br/>

                <nc:label name="location.vehiclesDelivery.address" for="location.vehiclesDelivery.address"/>
                <nc:text id="location.vehiclesDelivery.address" name="location.vehiclesDelivery.address"/><br/>

                <nc:label name="location.vehiclesDelivery.fromTime" for="location.vehiclesDelivery.fromTime"/>
                <nc:text id="location.vehiclesDelivery.fromTime" name="location.vehiclesDelivery.fromTime"/><br/>

                <nc:label name="location.vehiclesDelivery.toTime" for="location.vehiclesDelivery.toTime"/>
                <nc:text id="location.vehiclesDelivery.toTime" name="location.vehiclesDelivery.toTime"/><br/>

                <nc:label name="location.vehiclesDelivery.instructions" for="location.vehiclesDelivery.instructions"/>
                <nc:text id="location.vehiclesDelivery.instructions" name="location.vehiclesDelivery.instructions"/><br/>

                <nc:label name="location.destinationCode" for="location.destinationCode"/>
                <nc:text id="location.destinationCode" name="location.destinationCode"/><br/>

                <nc:label name="location.makerCode" for="location.makerCode"/>
                <nc:select id="location.makerCode" name="location.makerCode"
                           readOnlyValue="${actionBean.location.makerCode.description}">
                    <option value=""><fmt:message key="label.selectone"/></option>
                    <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.MakerCode" label="description"/>
                </nc:select>
            <br/>

        </fieldset>
        <!-- ======== End Delivery Info ============================== -->
    </nc:ifAccessAllowed>

</stripes:layout-definition>