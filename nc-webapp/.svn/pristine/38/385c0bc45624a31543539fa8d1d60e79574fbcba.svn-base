<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <nc:pageName pageName="Menu"/>

    <div class="main-menu-row">
        <nc:ifAccessAllowed name="menu.search.people">
            <!-- search for dealer staff -->
            <div class="main-menu-item">
                <fmt:message key="menu.search.staff.title" var="dealerStaffSearchTitle" scope="page"/>
                <stripes:link id="searchStaffLink"
                              beanclass="au.com.toyota.nc.webapp.stripes.staff.DealerStaffSearchActionBean"
                              event="displaySearchPageForView"
                              title="${dealerStaffSearchTitle}">
                    <img src="${pageContext.request.contextPath}/images/icons/dealer_staff.gif" title="${dealerStaffSearchTitle}" alt="${dealerStaffSearchTitle}"/>
                </stripes:link>
            </div>
        </nc:ifAccessAllowed>

        <nc:ifAccessAllowed name="menu.search.dealer">
            <div class="main-menu-item">
                <fmt:message key="menu.search.dealershipLocation.title" var="searchDealershipTitle" scope="page"/>
                <stripes:link id="searchDealerLink"
                              beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean"
                              event="displaySearchPage"
                              title="${searchDealershipTitle}">
                    <img src="${pageContext.request.contextPath}/images/icons/search_dealership.gif" title="${searchDealershipTitle}" alt="${searchDealershipTitle}"/>
                </stripes:link>
            </div>
        </nc:ifAccessAllowed>

        <nc:ifAccessAllowed name="menu.manage.mydetails">
            <div class="main-menu-item">
                <fmt:message key="menu.mydetails.title" var="myDetailsTitle" scope="page"/>
                <stripes:link id="myDetailsLink"
                              beanclass="au.com.toyota.nc.webapp.stripes.staff.mydetails.MyDetailsActionBean"
                              title="${myDetailsTitle}">
                    <img src="${pageContext.request.contextPath}/images/icons/my_details.gif" alt="${myDetailsTitle}" title="${myDetailsTitle}"/>
                </stripes:link>
            </div>
        </nc:ifAccessAllowed>
        <nc:ifAccessAllowed name="menu.manage.staffdetails">
            <div class="main-menu-item">
                <fmt:message key="menu.manage.staff.title" var="manageDealerStaffTitle" scope="page"/>
                <stripes:link id="manageStaffLink"
                              beanclass="au.com.toyota.nc.webapp.stripes.staff.DealerStaffSearchActionBean"
                              title="${manageDealerStaffTitle}">
                    <img src="${pageContext.request.contextPath}/images/icons/manage_staff.gif" alt="${manageDealerStaffTitle}" title="${manageDealerStaffTitle}"/>
                </stripes:link>
            </div>
        </nc:ifAccessAllowed>

        <nc:ifAccessAllowed name="menu.manage.dealer">
            <div class="main-menu-item">
                    <fmt:message key="menu.manage.dealershipLocation.title" var="manageDealershipTitle" scope="page"/>
                    <stripes:link id="manageDealerLink"
                                  beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.DealerLocationMenuActionBean"
                                  title="${manageDealershipTitle}">
                        <img src="${pageContext.request.contextPath}/images/icons/manage_dealer.gif" alt="${manageDealershipTitle}" title="${manageDealershipTitle}"/>
                    </stripes:link>
            </div>
        </nc:ifAccessAllowed>
        <nc:ifAccessAllowed name="menu.manage.operatingentity">
            <div class="main-menu-item">
                <fmt:message key="menu.manage.operatingEntity.title" var="manageOperatingEntityTitle" scope="page"/>
                <stripes:link id="manageOperatingEntitiesLink"
                          beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.OwnershipEntitySearchActionBean"
                          title="${manageOperatingEntityTitle}">
                    <img src="${pageContext.request.contextPath}/images/icons/manage_entity.gif" alt="${manageOperatingEntityTitle}" title="${manageOperatingEntityTitle}"/>
                </stripes:link>
            </div>
        </nc:ifAccessAllowed>
        <nc:ifAccessAllowed name="menu.changeover">
            <div class="main-menu-item">
                <fmt:message key="menu.dealerChangeover.title" var="dealerChangeOverTitle" scope="page"/>
                <stripes:link id="dealerChangeoverLink"
                          beanclass="au.com.toyota.nc.webapp.stripes.dealerchangeover.ProcessDealerChangeoverActionBean"
                          event="list"
                          title="${dealerChangeOverTitle}">
                    <img src="${pageContext.request.contextPath}/images/icons/process_changeover.gif" alt="${dealerChangeOverTitle}" title="${dealerChangeOverTitle}"/>
                </stripes:link>
            </div>
        </nc:ifAccessAllowed>
        <nc:ifAccessAllowed name="menu.securitysettings">
            <div class="main-menu-item">
                <fmt:message key="menu.security.title" var="securityTitle" scope="page"/>
                    <a href="<c:out value="${actionBean.linksConfiguration.delegatedAdminUrl}"/>" target="_blank" id="securitySettingsLink" title="${securityTitle}"><img src="${pageContext.request.contextPath}/images/icons/security_settings.gif" alt="${securityTitle}" title="${securityTitle}"/></a>
            </div>
        </nc:ifAccessAllowed>

        <nc:ifAccessAllowed name="menu.administration">
            <div class="main-menu-item">
                <fmt:message key="menu.administration.title" var="adminTitle" scope="page"/>
                <stripes:link id="administrationLink"
                              beanclass="au.com.toyota.nc.webapp.stripes.admin.AdministrationActionBean"
                              title="${adminTitle}">
                    <img src="${pageContext.request.contextPath}/images/icons/administration.gif" alt="${adminTitle}" title="${adminTitle}"/>
                </stripes:link>
            </div>
        </nc:ifAccessAllowed>
        <nc:ifAccessAllowed name="menu.reports">
            <div class="main-menu-item">
                <fmt:message key="menu.reports.title" var="reportsTitle" scope="page"/>
                <stripes:link id="reportsLink" beanclass="au.com.toyota.nc.webapp.stripes.reports.ReportsActionBean"
                                                title="${reportsTitle}">
                    <img src="${pageContext.request.contextPath}/images/icons/reporting.gif" title="${reportsTitle}" alt="${reportsTitle}"/>
                </stripes:link>
            </div>
        </nc:ifAccessAllowed>

        <nc:ifAccessAllowed name="menu.bulkimport">
            <div class="main-menu-item">
                <fmt:message key="menu.bulkImport.title" var="bulkImportTitle" scope="page"/>
                <stripes:link id="bulkImportLink" beanclass="au.com.toyota.nc.webapp.stripes.bulkimport.BulkImportActionBean"
                                                title="${bulkImportTitle}">
                    <img src="${pageContext.request.contextPath}/images/icons/bulk_import.gif" title="${bulkImportTitle}" alt="${bulkImportTitle}"/>
                </stripes:link>
            </div>
        </nc:ifAccessAllowed>
        
        <nc:ifAccessAllowed name="menu.approvingManager">
            <div class="main-menu-item">
                <fmt:message key="menu.approvingManager.title" var="approvingManagerTitle" scope="page"/>
                <stripes:link id="approvingManagerLink" beanclass="au.com.toyota.nc.webapp.stripes.approvingmanager.ApprovingManagerActionBean"
                                                title="${approvingManagerTitle}">
                    <img src="${pageContext.request.contextPath}/images/icons/approving_managers.png" title="${approvingManagerTitle}" alt="${approvingManagerTitle}"/>
                </stripes:link>
            </div>
        </nc:ifAccessAllowed>

        <div class="clear"></div>
    </div>
</stripes:layout-definition>