<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    

    <nc:ifAccessAllowed name="dealer.systemInfo.dmsVendor">
        <fieldset id="systemInfo-dmsSection">
            <legend><fmt:message  key="dealer.sysinfotab.section.dms.header"/></legend>

            <nc:label name="vendor.name" for="location.dealer.systemInfo.dmsVendor.name"/>
            <nc:text id="location.dealer.systemInfo.dmsVendor.name" name="location.dealer.systemInfo.dmsVendor.name"/><br/>

            <nc:label name="vendor.product.name" for="location.dealer.systemInfo.dmsProduct.name"/>
            <nc:text id="location.dealer.systemInfo.dmsProduct.name" name="location.dealer.systemInfo.dmsProduct.name"/><br/>

            <nc:label name="vendor.contactPerson" for="location.dealer.systemInfo.dmsContactPerson.name"/>
            <nc:text id="location.dealer.systemInfo.dmsContactPerson.name" name="location.dealer.systemInfo.dmsContactPerson.name"/><br/>

            <nc:label name="vendor.contact.phone" for="location.dealer.systemInfo.dmsContactPerson.contact.phone"/>
            <nc:text id="location.dealer.systemInfo.dmsContactPerson.contact.phone" name="location.dealer.systemInfo.dmsContactPerson.contact.phone"/><br/>

            <nc:label name="vendor.contact.streetAddress.address1" for="location.dealer.systemInfo.dmsContactPerson.contact.streetAddress.address1"/>
            <nc:text id="location.dealer.systemInfo.dmsContactPerson.contact.streetAddress.address1" name="location.dealer.systemInfo.dmsContactPerson.contact.streetAddress.address1"/><br/>

            <nc:label name="vendor.contact.streetAddress.address2" for="location.dealer.systemInfo.dmsContactPerson.contact.streetAddress.address2"/>
            <nc:text id="location.dealer.systemInfo.dmsContactPerson.contact.streetAddress.address2" name="location.dealer.systemInfo.dmsContactPerson.contact.streetAddress.address2"/><br/>
        </fieldset>
    </nc:ifAccessAllowed>



</stripes:layout-definition>