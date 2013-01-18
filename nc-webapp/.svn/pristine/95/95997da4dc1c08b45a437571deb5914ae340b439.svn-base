<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <nc:pageName pageName="Menu"/>

    <c:if test="${not empty actionBean.context.userDetails}">
        <div class="nav-v2">
            <ul class="nav">
                <li>
                    <stripes:link id="homeLink"
                            beanclass="au.com.toyota.nc.webapp.stripes.HomeActionBean">
                            <fmt:message key="globalMenu.home"/>
                    </stripes:link>
                </li>

                <nc:ifAccessAllowed name="menu.search.people">
                    <fmt:message key="menu.search.staff.title" var="dealerStaffSearchTitle" scope="page"/>
                    <li>
                         <stripes:link id="searchStaffLink"
                                  beanclass="au.com.toyota.nc.webapp.stripes.staff.DealerStaffSearchActionBean"
                                  event="displaySearchPageForView"
                                  title="${dealerStaffSearchTitle}">
                                <fmt:message key="globalMenu.search.staff.label"/>
                        </stripes:link>
                    </li>
                </nc:ifAccessAllowed>


                <nc:ifAccessAllowed name="menu.search.dealer">
                    <fmt:message key="menu.search.dealershipLocation.title" var="searchDealershipTitle" scope="page"/>
                    <li>
                           <stripes:link id="searchDealerLink"
                                  beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean"
                                  event="displaySearchPage"
                                  title="${searchDealershipTitle}">
                               <fmt:message key="globalMenu.search.dealershipLocation.label"/>
                            </stripes:link>
                    </li>
                </nc:ifAccessAllowed>


                <nc:ifAccessAllowed name="menu.manage.mydetails">
                    <fmt:message key="menu.mydetails.title" var="myDetailsTitle" scope="page"/>
                    <li>
                        <stripes:link id="myDetailsLink"
                                  beanclass="au.com.toyota.nc.webapp.stripes.staff.mydetails.MyDetailsActionBean"
                                  title="${myDetailsTitle}">
                                 <fmt:message key="globalMenu.mydetails.label"/>
                        </stripes:link>
                    </li>
                </nc:ifAccessAllowed>


                <nc:ifAccessAllowed name="menu.manage.staffdetails">
                    <fmt:message key="menu.manage.staff.title" var="manageDealerStaffTitle" scope="page"/>
                    <li>
                        <stripes:link id="manageStaffLink"
                                  beanclass="au.com.toyota.nc.webapp.stripes.staff.DealerStaffSearchActionBean"
                                  title="${manageDealerStaffTitle}">
                                <fmt:message key="globalMenu.manage.staff.label"/>
                        </stripes:link>
                    </li>
                </nc:ifAccessAllowed>

                <nc:ifAccessAllowed name="menu.manage.dealer">
                    <fmt:message key="menu.manage.dealershipLocation.title" var="manageDealershipTitle" scope="page"/>
                    <li>
                        <stripes:link id="manageDealerLink"
                                      beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.DealerLocationMenuActionBean"
                                      title="${manageDealershipTitle}">
                                <fmt:message key="globalMenu.manage.dealershipLocation.label"/>
                        </stripes:link>
                    </li>
                </nc:ifAccessAllowed>


                <nc:ifAccessAllowed name="menu.manage.operatingentity">
                    <fmt:message key="menu.manage.operatingEntity.title" var="manageOperatingEntityTitle" scope="page"/>
                    <li>
                         <stripes:link id="manageOperatingEntitiesLink"
                              beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.OwnershipEntitySearchActionBean"
                              title="${manageOperatingEntityTitle}">
                             <fmt:message key="globalMenu.manage.operatingEntity.label"/>
                        </stripes:link>
                    </li>
                </nc:ifAccessAllowed>


                <nc:ifAccessAllowed name="menu.changeover">
                    <fmt:message key="menu.dealerChangeover.title" var="dealerChangeOverTitle" scope="page"/>
                    <li>
                        <stripes:link id="dealerChangeoverLink"
                              beanclass="au.com.toyota.nc.webapp.stripes.dealerchangeover.ProcessDealerChangeoverActionBean"
                              event="list"
                              title="${dealerChangeOverTitle}">
                            <fmt:message key="globalMenu.dealerChangeOver.label"/>
                        </stripes:link>
                    </li>
                </nc:ifAccessAllowed>


                <nc:ifAccessAllowed name="menu.securitysettings">
                    <fmt:message key="menu.security.title" var="securityTitle" scope="page"/>
                    <li>
                        <a href="<c:out value="${actionBean.linksConfiguration.delegatedAdminUrl}"/>" target="_blank" id="securitySettingsLink" title="${securityTitle}">
                            <fmt:message key="globalMenu.security.label"/>
                        </a>
                    </li>
                </nc:ifAccessAllowed>

                <nc:ifAccessAllowed name="menu.administration">
                    <fmt:message key="menu.administration.title" var="adminTitle" scope="page"/>
                    <li>
                        <stripes:link id="administrationLink"
                                      beanclass="au.com.toyota.nc.webapp.stripes.admin.AdministrationActionBean"
                                      title="${adminTitle}">
                            <fmt:message key="globalMenu.administration.label"/>
                        </stripes:link>
                    </li>
                </nc:ifAccessAllowed>


                <nc:ifAccessAllowed name="menu.reports">
                    <fmt:message key="menu.reports.title" var="reportsTitle" scope="page"/>
                    <li class="last">
                        <stripes:link id="reportsLink" beanclass="au.com.toyota.nc.webapp.stripes.reports.ReportsActionBean"
                                                        title="${reportsTitle}">
                                <fmt:message key="globalMenu.reports.label"/>
                        </stripes:link>
                    </li>
                </nc:ifAccessAllowed>


            </ul>
        </div>
    </c:if>


</stripes:layout-definition>
