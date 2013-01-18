<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<nc:pageName pageName="EditDealership-System"/>
<stripes:layout-definition>
    <nc:pageViewMode readOnly="${showAsReadOnly}"/>
    <nc:label name="vendor.product.name" for="dealer.systemInfo.dmsProduct.dmsProductId"/>
    <nc:select-active-values selectedObject="${dealer.systemInfo.dmsProduct}"
                             valueAttribute="dmsProductId"
                             labelAttribute="name"
                             collections="${selectedDmsVendor.activeProducts}"
                             id="dealer.systemInfo.dmsProduct.dmsProductId" 
                             name="dealer.systemInfo.dmsProduct.dmsProductId">
        <option value=""><fmt:message key="label.selectone"/></option>
    </nc:select-active-values><br/>

    <nc:label name="vendor.contactPerson" for="dealer.systemInfo.dmsContactPerson.dmsContactPersonId"/>
    <nc:select-active-values selectedObject="${dealer.systemInfo.dmsContactPerson}"
                             valueAttribute="dmsContactPersonId"
                             labelAttribute="name"
                             collections="${selectedDmsVendor.contacts}"
                             name="dealer.systemInfo.dmsContactPerson.dmsContactPersonId"
                             id="dealer.systemInfo.dmsContactPerson.dmsContactPersonId"
                             onchange="showInfoForDmsContact(this);">
        <option value=""><fmt:message key="label.selectone"/></option>
    </nc:select-active-values><br/>

    <div id="systemInfo-dmsSection-contact-info">
        <c:if test="${dealer.systemInfo.dmsContactPerson != null}">
            <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/systemInfo/components/_dmsVendorContactInfo.jsp"
                                   addressOne="${dealer.systemInfo.dmsContactPerson.contact.streetAddress.address1}"
                                   addressTwo="${dealer.systemInfo.dmsContactPerson.contact.streetAddress.address2}"
                                   contactPhone="${dealer.systemInfo.dmsContactPerson.contact.phone}"/>
        </c:if>
    </div>
</stripes:layout-definition>
