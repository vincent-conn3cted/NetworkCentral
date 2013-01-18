<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<nc:pageName pageName="EditDealership-System"/>
<stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ShowDmsVendorOptionsActionBean" partial="true">
    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/systemInfo/components/_dmsVendorContactInfo.jsp"
                           contactPhone="${actionBean.selectedContactPerson.contact.phone}"
                           addressOne="${actionBean.selectedContactPerson.contact.streetAddress.address1}" 
                           addressTwo="${actionBean.selectedContactPerson.contact.streetAddress.address2}"/>
</stripes:form>
