<%@ page import="au.com.toyota.nc.common.dealers.impl.SapDealer" %>
<%@ page import="au.com.toyota.nc.common.model.hibernate.AbstractContact" %>
<%@ page import="au.com.toyota.nc.common.model.hibernate.DMSContactPerson" %>
<%@ page import="au.com.toyota.nc.common.model.hibernate.DMSProduct" %>
<%@ page import="au.com.toyota.nc.common.model.hibernate.DocumentType" %>
<%@ page import="au.com.toyota.nc.common.utils.NCConstants" %>
<%@ page import="au.com.toyota.nc.webapp.dataproxy.SAPCodeVerifier" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.admin.ManageDMSVendorActionBean" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.admin.ManageGroupActionBean" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.admin.ManagePMAActionBean" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.admin.ManagePositionTypesActionBean" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.admin.ManageTMCAFieldRepresentativesActionBean" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <div id="footerMenuLayoutSection">
        <p> &copy; Toyota Motor Corporation Australia Limited ABN 64 009 686 097. Built from version (set via Maven): <strong><fmt:message key="application.buildNumber"/></strong> </p>
    <%-- Temporarily put this here because a selenium is failing without this link to be able to click --%>
        <nc:pageName pageName="Menu"/>
        <nc:ifAccessAllowed name="menu.manage.dealer">
            <!-- for seleniums at the moment-->
           <stripes:link id="manageDealerLink"
                      beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.DealerLocationMenuActionBean"
                      title="${manageDealershipTitle}" style="display:none;">
               Manage Dealer
           </stripes:link>
        </nc:ifAccessAllowed>
    </div>
</stripes:layout-definition>
