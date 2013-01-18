<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<fmt:setBundle basename="nc-admin-resources" var="admin_resources" scope="page"/>
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: admin menu page -->
        <div class="pageContent_main_header">
            <h1><fmt:message key="globalMenu.administration.label"/></h1>
        </div>
        
        <div id="adminMenuPage" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                <ul id="adminMenuList"class="menu_simple_vertical">
                    <li>
                        <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageCommonValuesActionBean"
                                      id="listCommonValuesLink"
                                      event="listCommonValues">
                            <fmt:message bundle="${admin_resources}" key="menu.drop-down"/>
                        </stripes:link>
                    </li>
                    <li>
                        <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.admin.ManagePositionTypesActionBean"
                                      id="listPositionLink"
                                      event="listPositionType">
                            <fmt:message bundle="${admin_resources}" key="menu.position-type"/>
                        </stripes:link>
                    </li>
                    <li>
                        <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.admin.ManagePMAActionBean" event="listPMA"
                                id="listPMALink">
                            <fmt:message bundle="${admin_resources}" key="menu.pma"/>
                        </stripes:link>
                    </li>
                    <li>
                        <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.admin.ManagePMAActionBean" event="viewOpenPoints">
                            <fmt:message bundle="${admin_resources}" key="menu.open-points"/>
                        </stripes:link>
                    </li>
                    <li>
                        <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageGroupActionBean"
                                      id="listGroupLink"
                                      event="listGroup">
                            <fmt:message bundle="${admin_resources}" key="menu.groups"/>
                        </stripes:link>
                    </li>
                    <li>
                        <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageTMCAFieldRepresentativesActionBean"
                                      id="listTMCAFieldRepsLink"
                                      event="listTMCAFieldReps">
                            <fmt:message bundle="${admin_resources}" key="menu.tmca-representatives"/>
                        </stripes:link>
                    </li>
                     <li>
                        <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.admin.ManageDMSVendorActionBean"
                                      id="listVendorLink"
                                      event="listVendor">
                            <fmt:message bundle="${admin_resources}" key="menu.dms-vendors"/>
                        </stripes:link>
                    </li>
                    <li>
                        <a href="<c:out value="${actionBean.linksConfiguration.webmasterUrl}"/>" target="_blank">
                            <fmt:message bundle="${admin_resources}" key="menu.tmca-access"/>
                        </a>
                    </li>
                </ul>
                <div class="clear"></div>
            </div>
        </div>
    </stripes:layout-component>



</stripes:layout-render>