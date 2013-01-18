<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.BaseManageDealerLocationActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <nc:pageName pageName="DealerTabs"/>

    <div id="dealerLocation-nav">
        <ul>
            <nc:ifAccessAllowed name="dealer.tab.general">
                    <c:set var="generalInfoTabEvent" value="<%=BaseManageDealerLocationActionBean.EVENT_SHOW_GENERAL_INFORMATION%>"/>
                    <c:set var="generalInfoTabMenuClass" value=""/>
                    <c:if test="${actionBean.lastTabShown eq generalInfoTabEvent}">
                        <c:set var="generalInfoTabMenuClass" value="active"/>
                    </c:if>
                    <li class="${generalInfoTabMenuClass}"> 
                        <stripes:submit id="switchToGeneralInfo" class="dealertab" name="${generalInfoTabEvent}"><fmt:message key="dealerlocation.tab.generalinfo"/></stripes:submit>
                    </li>
            </nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealer.tab.tmca">
                    <c:set var="tmcaInfoTabEvent" value="<%=BaseManageDealerLocationActionBean.EVENT_SHOW_TMCA_INFORMATION%>"/>
                    <c:set var="tmcaInfoTabMenuClass" value=""/>
                    <c:if test="${actionBean.lastTabShown eq tmcaInfoTabEvent}">
                        <c:set var="tmcaInfoTabMenuClass" value="active"/>
                    </c:if>
                    <li class="${tmcaInfoTabMenuClass}">
                        <stripes:submit id="switchToTMCAInfo" class="dealertab" name="${tmcaInfoTabEvent}"><fmt:message key="dealerlocation.tab.tmcainfo"/></stripes:submit>
                    </li>
            </nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealer.tab.legal">
                    <c:set var="legalInfoTabEvent" value="<%=BaseManageDealerLocationActionBean.EVENT_SHOW_LEGAL_INFORMATION%>"/>
                    <c:set var="legalInfoTabMenuClass" value=""/>
                   <c:if test="${actionBean.lastTabShown eq legalInfoTabEvent}">
                        <c:set var="legalInfoTabMenuClass" value="active"/>
                    </c:if>
                    <li class="${legalInfoTabMenuClass}">
                        <stripes:submit id="switchToLegalInfo" class="dealertab"  name="${legalInfoTabEvent}"><fmt:message key="dealerlocation.tab.legal"/></stripes:submit>
                    </li>
            </nc:ifAccessAllowed>

            <nc:ifAccessAllowed name="dealer.tab.awards">
                    <c:set var="awardsInfoTabEvent" value="<%=BaseManageDealerLocationActionBean.EVENT_SHOW_AWARDS_INFORMATION%>"/>
                    <c:set var="awardsInfoTabMenuClass" value=""/>
                    <c:if test="${actionBean.lastTabShown eq awardsInfoTabEvent}">
                        <c:set var="awardsInfoTabMenuClass" value="active"/>
                    </c:if>
                    <li class="${awardsInfoTabMenuClass}"><stripes:submit id="switchToAwardsInfo" class="dealertab"  name="${awardsInfoTabEvent}"><fmt:message key="dealerlocation.tab.awards"/></stripes:submit></li>
            </nc:ifAccessAllowed>

            <c:set var="locationInfoTabEvent" value="<%=BaseManageDealerLocationActionBean.EVENT_SHOW_LOCATION_INFORMATION%>"/>
            <c:set var="locationInfoTabMenuClass" value=""/>
            <c:if test="${actionBean.lastTabShown eq locationInfoTabEvent}">
                <c:set var="locationInfoTabMenuClass" value="active"/>
            </c:if>
            <li class="${locationInfoTabMenuClass}"><stripes:submit id="switchToLocationInfo" class="dealertab" name="<%=BaseManageDealerLocationActionBean.EVENT_SHOW_LOCATION_INFORMATION%>"><fmt:message key="dealerlocation.tab.location"/></stripes:submit></li>

            <nc:ifAccessAllowed name="dealer.tab.identification">
                    <c:set var="identificationInfoTabEvent" value="<%=BaseManageDealerLocationActionBean.EVENT_SHOW_IDENTIFICATION_NUMBERS_INFORMATION%>"/>
                    <c:set var="identificationInfoTabMenuClass" value=""/>
                      <c:if test="${actionBean.lastTabShown eq identificationInfoTabEvent}">
                        <c:set var="identificationInfoTabMenuClass" value="active"/>
                    </c:if>
                    <li class="${identificationInfoTabMenuClass}"><stripes:submit id="switchToIdentificationNumberInfo" class="dealertab" name="${identificationInfoTabEvent}"><fmt:message key="dealerlocation.tab.identification"/></stripes:submit></li>
            </nc:ifAccessAllowed>

            <nc:ifAccessAllowed name="dealer.tab.files">
                    <c:set var="filesInfoTabEvent" value="<%=BaseManageDealerLocationActionBean.EVENT_SHOW_FILES_INFORMATION%>"/>
                    <c:set var="filesInfoTabMenuClass" value=""/>
                    <c:if test="${actionBean.lastTabShown eq filesInfoTabEvent}">
                        <c:set var="filesInfoTabMenuClass" value="active"/>
                    </c:if>
                    <li class="${filesInfoTabMenuClass}"><stripes:submit id="switchToFilesInfo" class="dealertab" name="${filesInfoTabEvent}"><fmt:message key="dealerlocation.tab.files"/></stripes:submit></li>
            </nc:ifAccessAllowed>

            <nc:ifAccessAllowed name="dealer.tab.system">
                    <c:set var="systemInfoTabEvent" value="<%=BaseManageDealerLocationActionBean.EVENT_SHOW_SYSTEM_INFORMATION%>"/>
                    <c:set var="systemInfoTabMenuClass" value=""/>
                    <c:if test="${actionBean.lastTabShown eq systemInfoTabEvent}">
                        <c:set var="systemInfoTabMenuClass" value="active"/>
                    </c:if>
                    <li class="${systemInfoTabMenuClass}"><stripes:submit id="switchToSystemInfo" class="dealertab" name="${systemInfoTabEvent}"><fmt:message key="dealerlocation.tab.systemInfo"/></stripes:submit></li>
            </nc:ifAccessAllowed>
        
            <nc:ifAccessAllowed name="dealer.tab.marketing">
                    <c:set var="marketingInfoTabEvent" value="<%=BaseManageDealerLocationActionBean.EVENT_SHOW_MARKETING_INFORMATION%>"/>
                    <c:set var="marketingInfoTabMenuClass" value=""/>
                     <c:if test="${actionBean.lastTabShown eq marketingInfoTabEvent}">
                        <c:set var="marketingInfoTabMenuClass" value="active"/>
                    </c:if>
                    <li class="${marketingInfoTabMenuClass}"><stripes:submit id="switchToMarketingInfo" class="dealertab" name="${marketingInfoTabEvent}"><fmt:message key="dealerlocation.tab.marketing"/></stripes:submit></li>
            </nc:ifAccessAllowed>
        </ul>
        <div class="clear"></div>
    </div>
    <div class="clear">&nbsp;</div>
</stripes:layout-definition>

