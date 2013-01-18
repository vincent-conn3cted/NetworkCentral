<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<nc:pageName pageName="EditDealership-System"/>
<stripes:layout-definition>
    <nc:ifAccessAllowed name="dealer.systemInfo.dmsContactPerson.dmsContactPersonId">
        <nc:ifAccessAllowed name="dealer.systemInfo.dmsContactPerson.contact.phone">
            <nc:label name="vendor.contact.phone" for="dealer.systemInfo.dmsContactPerson.contact.phone"/>
            <span id="dealer.systemInfo.dmsContactPerson.contact.phone"><c:out value="${contactPhone}"/></span>
            <br/>
        </nc:ifAccessAllowed>
        <nc:ifAccessAllowed name="dealer.systemInfo.dmsContactPerson.contact.streetAddress.address1">
            <nc:label name="vendor.contact.streetAddress.address1" for="dealer.systemInfo.dmsContactPerson.contact.streetAddress.address1"/>
            <span id="dealer.systemInfo.dmsContactPerson.contact.streetAddress.address1"><c:out value="${addressOne}"/></span>
            <br/>            
            <nc:label name="vendor.contact.streetAddress.address2" for="dealer.systemInfo.dmsContactPerson.contact.streetAddress.address2"/>
            <span id="dealer.systemInfo.dmsContactPerson.contact.streetAddress.address2"><c:out value="${addressTwo}"/></span>
            <br/>
        </nc:ifAccessAllowed>
    </nc:ifAccessAllowed/>
</stripes:layout-definition>
