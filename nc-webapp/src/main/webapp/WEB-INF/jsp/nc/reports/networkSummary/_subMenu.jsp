<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<fmt:setBundle basename="nc-reports-resources" var="reports_resources" scope="page"/>

<div class="side_menu">
        <ul class="levelOne">
            <li class="submenu">
                <span class="currentOneDown"><fmt:message bundle="${reports_resources}" key="menu.networksummary.submenu.toyota"/></span>
                <ul class="levelTwo">
                    <li>
                        <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.NetworkSummaryActionBean"
                                      event="national"
                                      id="submenuToyotaNationalLink">
                            <stripes:param name="toyotaFranchise" value="<%= au.com.toyota.nc.common.model.hibernate.ToyotaFranchise.Toyota%>"/>
                            <fmt:message bundle="${reports_resources}" key="menu.networksummary.submenu.national"/>
                        </stripes:link>
                    </li>
                    <li>
                        <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.NetworkSummaryActionBean"
                                      event="regional"
                                      id="submenuToyotaRegionalLink">
                            <stripes:param name="toyotaFranchise" value="<%= au.com.toyota.nc.common.model.hibernate.ToyotaFranchise.Toyota%>"/>
                            <fmt:message bundle="${reports_resources}" key="menu.networksummary.submenu.regional"/>
                        </stripes:link>
                    </li>
                    <li>
                        <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.NetworkSummaryActionBean"
                                      event="state"
                                      id="submenuToyotaStateLink">
                            <stripes:param name="toyotaFranchise" value="<%= au.com.toyota.nc.common.model.hibernate.ToyotaFranchise.Toyota%>"/>
                            <fmt:message bundle="${reports_resources}" key="menu.networksummary.submenu.state"/>
                        </stripes:link>
                    </li>
                </ul>
            </li>
            <li class="submenu">
                <span class="currentOneDown"><fmt:message bundle="${reports_resources}" key="menu.networksummary.submenu.lexus"/></span>
                <ul class="levelTwo">
                    <li>
                        <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.NetworkSummaryActionBean"
                                      event="national"
                                      id="submenuLexusNationalLink">
                            <stripes:param name="toyotaFranchise" value="<%= au.com.toyota.nc.common.model.hibernate.ToyotaFranchise.Lexus%>"/>
                            <fmt:message bundle="${reports_resources}" key="menu.networksummary.submenu.national"/>
                        </stripes:link>
                    </li>
                    <li>
                        <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.NetworkSummaryActionBean"
                                      event="regional"
                                      id="submenuLexusRegionalLink">
                            <stripes:param name="toyotaFranchise" value="<%= au.com.toyota.nc.common.model.hibernate.ToyotaFranchise.Lexus%>"/>
                            <fmt:message bundle="${reports_resources}" key="menu.networksummary.submenu.regional"/>
                        </stripes:link>
                    </li>
                    <li>
                        <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.NetworkSummaryActionBean"
                                      event="state"
                                      id="submenuLexusStateLink">
                            <stripes:param name="toyotaFranchise" value="<%= au.com.toyota.nc.common.model.hibernate.ToyotaFranchise.Lexus%>"/>
                            <fmt:message bundle="${reports_resources}" key="menu.networksummary.submenu.state"/>
                        </stripes:link>
                    </li>
                </ul>
            </li>
        </ul>
</div>
