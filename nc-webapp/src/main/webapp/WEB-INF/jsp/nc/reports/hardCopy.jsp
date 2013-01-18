<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<fmt:setBundle basename="nc-reports-resources" var="reports_resources" scope="page"/>
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
      <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/reporting/nc-reports.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: hard copy page -->
         <div class="pageContent_main_header">
            <h1><fmt:message bundle="${reports_resources}" key="dealer.reports.title"/></h1>
        </div>


        <div id="dealerReportsMenu" class="pageContent_wrapper">
                <div class="twoColumnWithLeftMainContent">
                    <div class="leftColumn">
                        <fmt:message bundle="${reports_resources}" key="dealer.reports.description"/>

                            <ul class="menu_simple_vertical">
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                    <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                    <stripes:param name="dealerSearchRequest.dealerRegion" value="Central"/>
                                    <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="central.all"/></stripes:param>
                                    <fmt:message bundle="${reports_resources}" key="central.all"/>
                                </stripes:link>
                            </li>
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                    <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                    <stripes:param name="dealerSearchRequest.dealerRegion" value="Central"/>
                                    <stripes:param name="dealerSearchRequest.metroFlag" value="true"/>
                                    <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="metro.central"/></stripes:param>
                                    <fmt:message bundle="${reports_resources}" key="metro.central"/>
                                </stripes:link>
                            </li>
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                    <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                    <stripes:param name="dealerSearchRequest.dealerRegion" value="Central"/>
                                    <stripes:param name="dealerSearchRequest.metroFlag" value="false"/>
                                    <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="rural.central"/></stripes:param>
                                    <fmt:message bundle="${reports_resources}" key="rural.central"/>
                                </stripes:link>
                            </li>
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                    <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                    <stripes:param name="dealerSearchRequest.dealerRegion" value="Eastern"/>
                                    <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="eastern.all"/></stripes:param>
                                    <fmt:message bundle="${reports_resources}" key="eastern.all"/>
                                </stripes:link>
                            </li>
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                    <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                    <stripes:param name="dealerSearchRequest.dealerRegion" value="Eastern"/>
                                    <stripes:param name="dealerSearchRequest.metroFlag" value="true"/>
                                    <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="metro.eastern"/></stripes:param>
                                    <fmt:message bundle="${reports_resources}" key="metro.eastern"/>
                                </stripes:link>
                            </li>
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                    <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                    <stripes:param name="dealerSearchRequest.dealerRegion" value="Eastern"/>
                                    <stripes:param name="dealerSearchRequest.metroFlag" value="false"/>
                                    <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="rural.eastern"/></stripes:param>
                                    <fmt:message bundle="${reports_resources}" key="rural.eastern"/>
                                </stripes:link>
                            </li>
                                <li>
                                    <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                        <stripes:param name="dealerSearchRequest.franchise" value="Lexus"/>
                                        <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="lexus.all"/></stripes:param>
                                        <fmt:message bundle="${reports_resources}" key="lexus.all"/>
                                    </stripes:link>
                                </li>
                                <li>
                                    <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                        <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                        <stripes:param name="dealerSearchRequest.metroFlag" value="true"/>
                                        <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="metro.all"/></stripes:param>
                                        <fmt:message bundle="${reports_resources}" key="metro.all"/>
                                    </stripes:link>
                                </li>
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                    <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="prius.all"/></stripes:param>
                                    <stripes:param name="dealerSearchRequest.product" value="${actionBean.priusOtherProduct.commonValueId}"/>
                                    <fmt:message bundle="${reports_resources}" key="prius.all"/>
                                </stripes:link>
                            </li>
                                <li>
                                    <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                        <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                        <stripes:param name="dealerSearchRequest.dealerRegion" value="Northern"/>
                                        <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="northern.all"/></stripes:param>
                                        <fmt:message bundle="${reports_resources}" key="northern.all"/>
                                    </stripes:link>
                                </li>
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                    <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                    <stripes:param name="dealerSearchRequest.dealerRegion" value="Northern"/>
                                    <stripes:param name="dealerSearchRequest.metroFlag" value="true"/>
                                    <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="metro.northern"/></stripes:param>
                                    <fmt:message bundle="${reports_resources}" key="metro.northern"/>
                                </stripes:link>
                            </li>
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                    <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                    <stripes:param name="dealerSearchRequest.dealerRegion" value="Northern"/>
                                    <stripes:param name="dealerSearchRequest.metroFlag" value="false"/>
                                    <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="rural.northern"/></stripes:param>
                                    <fmt:message bundle="${reports_resources}" key="rural.northern"/>
                                </stripes:link>
                            </li>
                                <li>
                                    <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                        <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                        <stripes:param name="dealerSearchRequest.metroFlag" value="false"/>
                                        <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="rural.all"/></stripes:param>
                                        <fmt:message bundle="${reports_resources}" key="rural.all"/>
                                    </stripes:link>
                                </li>
                                <li>
                                    <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                        <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                        <stripes:param name="dealerSearchRequest.dealerRegion" value="Southern"/>
                                        <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="southern.all"/></stripes:param>
                                        <fmt:message bundle="${reports_resources}" key="southern.all"/>
                                    </stripes:link>
                                </li>
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                    <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                    <stripes:param name="dealerSearchRequest.dealerRegion" value="Southern"/>
                                    <stripes:param name="dealerSearchRequest.metroFlag" value="true"/>
                                    <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="metro.southern"/></stripes:param>
                                    <fmt:message bundle="${reports_resources}" key="metro.southern"/>
                                </stripes:link>
                            </li>
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                    <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                    <stripes:param name="dealerSearchRequest.dealerRegion" value="Southern"/>
                                    <stripes:param name="dealerSearchRequest.metroFlag" value="false"/>
                                    <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="rural.southern"/></stripes:param>
                                    <fmt:message bundle="${reports_resources}" key="rural.southern"/>
                                </stripes:link>
                            </li>
                                   <li>
                                    <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean"
                                                  event="generate"
                                                  id="downloadAllToyota"
                                                  target="_blank">
                                        <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                        <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="toyota.all"/></stripes:param>
                                        <fmt:message bundle="${reports_resources}" key="toyota.all"/>
                                    </stripes:link>
                                </li>
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                    <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                    <stripes:param name="dealerSearchRequest.dealerRegion" value="Western"/>
                                    <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="western.all"/></stripes:param>
                                    <fmt:message bundle="${reports_resources}" key="western.all"/>
                                </stripes:link>
                            </li>
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                    <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                    <stripes:param name="dealerSearchRequest.dealerRegion" value="Western"/>
                                    <stripes:param name="dealerSearchRequest.metroFlag" value="true"/>
                                    <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="metro.western"/></stripes:param>
                                    <fmt:message bundle="${reports_resources}" key="metro.western"/>
                                </stripes:link>
                            </li>
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                    <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                    <stripes:param name="dealerSearchRequest.dealerRegion" value="Western"/>
                                    <stripes:param name="dealerSearchRequest.metroFlag" value="false"/>
                                    <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="rural.western"/></stripes:param>
                                    <fmt:message bundle="${reports_resources}" key="rural.western"/>
                                </stripes:link>
                            </li>
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                    <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                    <stripes:param name="dealerSearchRequest.dealerRegion" value="Central"/>
                                    <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="toyota.central"/></stripes:param>
                                    <fmt:message bundle="${reports_resources}" key="toyota.central"/>
                                </stripes:link>
                            </li>
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                    <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                    <stripes:param name="dealerSearchRequest.dealerRegion" value="Eastern"/>
                                    <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="toyota.eastern"/></stripes:param>
                                    <fmt:message bundle="${reports_resources}" key="toyota.eastern"/>
                                </stripes:link>
                            </li>
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                    <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                    <stripes:param name="dealerSearchRequest.dealerRegion" value="Northern"/>
                                    <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="toyota.northern"/></stripes:param>
                                    <fmt:message bundle="${reports_resources}" key="toyota.northern"/>
                                </stripes:link>
                            </li>
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                    <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                    <stripes:param name="dealerSearchRequest.dealerRegion" value="Southern"/>
                                    <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="toyota.southern"/></stripes:param>
                                    <fmt:message bundle="${reports_resources}" key="toyota.southern"/>
                                </stripes:link>
                            </li>
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.reports.HardCopyActionBean" event="generate" target="_blank">
                                    <stripes:param name="dealerSearchRequest.franchise" value="Toyota"/>
                                    <stripes:param name="dealerSearchRequest.dealerRegion" value="Western"/>
                                    <stripes:param name="reportTitle" ><fmt:message bundle="${reports_resources}" key="toyota.western"/></stripes:param>
                                    <fmt:message bundle="${reports_resources}" key="toyota.western"/>
                                </stripes:link>
                            </li>
                        </ul>
                        <div class="clear"></div>
                    </div>

                    <div class="rightColumn">
                        <div id="downloadAdobeAcrobatLink">
                            <h2>Adobe Acrobat</h2>
                            <p>
                                Each of the reports on this page will download their output in PDF format. You require the Adobe Acrobat reader to view these files. This utility is a free download available via the link below.                            </p>
                            <ul class="menu_simple_vertical">
                                <li><a href="http://www.adobe.com/products/reader" target="_blank">Get Adobe Reader</a></li>
                            </ul>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="clear"></div>
        </div>
    </stripes:layout-component>

</stripes:layout-render>
