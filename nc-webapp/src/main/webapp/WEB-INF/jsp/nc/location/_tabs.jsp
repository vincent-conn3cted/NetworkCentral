<%@ page import="au.com.toyota.nc.common.model.hibernate.DocumentType" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.BaseManageDealerLocationActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <nc:pageName pageName="LocationTabs-${actionBean.location.type}"/>

    <div id="dealerLocation-nav">
        <ul>
            <nc:ifAccessAllowed name="location.tab.general">
                <c:set var="generalInfoTabEvent" value="<%=BaseManageDealerLocationActionBean.EVENT_SHOW_GENERAL_INFORMATION%>"/>
                <c:set var="generalInfoTabMenuClass" value=""/>
                <c:if test="${actionBean.lastTabShown eq generalInfoTabEvent}">
                    <c:set var="generalInfoTabMenuClass" value="active"/>
                </c:if>
                <li class="${generalInfoTabMenuClass}"> 
                    <stripes:submit id="switchToGeneralInfo" class="dealertab" name="${generalInfoTabEvent}"><fmt:message key="dealerlocation.tab.generalinfo"/></stripes:submit>
                </li>
            </nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="location.tab.tmca">
                <c:set var="tmcaInfoTabEvent" value="<%=BaseManageDealerLocationActionBean.EVENT_SHOW_TMCA_INFORMATION%>"/>
                <c:set var="tmcaInfoTabMenuClass" value=""/>
                <c:if test="${actionBean.lastTabShown eq tmcaInfoTabEvent}">
                    <c:set var="tmcaInfoTabMenuClass" value="active"/>
                </c:if>
                <li class="${tmcaInfoTabMenuClass}">
                    <stripes:submit id="switchToTMCAInfo" class="dealertab" name="${tmcaInfoTabEvent}"><fmt:message key="dealerlocation.tab.tmcainfo"/></stripes:submit>
                </li>
            </nc:ifAccessAllowed>

            <c:set var="showStaffInfoTab" value="true"/>
            <nc:evalAccess>
                <c:if test="${! actionBean.userSharesSameDealerAsLocation}">
                    <c:set var="showStaffInfoTab" value="false"/>
                </c:if>
            </nc:evalAccess>
            <c:if test="${showStaffInfoTab eq 'true'}">
                <nc:ifAccessAllowed name="location.tab.staff">
                    <c:set var="staffInfoTabEvent" value="<%=BaseManageDealerLocationActionBean.EVENT_SHOW_STAFF_INFORMATION%>"/>
                    <c:set var="staffInfoTabMenuClass" value=""/>
                    <c:if test="${actionBean.lastTabShown eq staffInfoTabEvent}">
                        <c:set var="staffInfoTabMenuClass" value="active"/>
                    </c:if>
                    <li class="${staffInfoTabMenuClass}">
                        <stripes:submit id="switchToStaffInfo" class="dealertab" name="${staffInfoTabEvent}"><fmt:message key="dealerlocation.tab.staff"/></stripes:submit>
                    </li>
                </nc:ifAccessAllowed>
            </c:if>

             <nc:ifAccessAllowed name="location.tab.identification">
                 <c:set var="identificationInfoTabEvent" value="<%=BaseManageDealerLocationActionBean.EVENT_SHOW_IDENTIFICATION_NUMBERS_INFORMATION%>"/>
                 <c:set var="identificationInfoTabMenuClass" value=""/>
                 <c:if test="${actionBean.lastTabShown eq identificationInfoTabEvent}">
                     <c:set var="identificationInfoTabMenuClass" value="active"/>
                 </c:if>
                <li class="${identificationInfoTabMenuClass}">
                    <stripes:submit id="switchToIdentificationNumberInfo" class="dealertab" name="${identificationInfoTabEvent}"><fmt:message key="dealerlocation.tab.identification"/></stripes:submit>
                </li>
            </nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="location.tab.awards">
                <c:set var="awardsInfoTabEvent" value="<%=BaseManageDealerLocationActionBean.EVENT_SHOW_AWARDS_INFORMATION%>"/>
                <c:set var="awardsInfoTabMenuClass" value=""/>
                <c:if test="${actionBean.lastTabShown eq awardsInfoTabEvent}">
                     <c:set var="awardsInfoTabMenuClass" value="active"/>
                 </c:if>
                <li class="${awardsInfoTabMenuClass}">
                    <stripes:submit id="switchToAwardsInfo"  class="dealertab" name="${awardsInfoTabEvent}"><fmt:message key="dealerlocation.tab.awards"/></stripes:submit>
                </li>
            </nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="location.tab.files">
                <c:set var="filesInfoTabEvent" value="<%=BaseManageDealerLocationActionBean.EVENT_SHOW_FILES_INFORMATION%>"/>
                <c:set var="filesInfoTabMenuClass" value=""/>
                <c:if test="${actionBean.lastTabShown eq filesInfoTabEvent}">
                     <c:set var="filesInfoTabMenuClass" value="active"/>
                 </c:if>
                <li class="${filesInfoTabMenuClass}">
                    <stripes:submit id="switchToFilesInfo" class="dealertab" name="${filesInfoTabEvent}"><fmt:message key="dealerlocation.tab.files"/></stripes:submit>
                </li>
            </nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="location.tab.system">
                <c:set var="systemInfoTabEvent" value="<%=BaseManageDealerLocationActionBean.EVENT_SHOW_SYSTEM_INFORMATION%>"/>
                <c:set var="systemInfoTabMenuClass" value=""/>
                <c:if test="${actionBean.lastTabShown eq systemInfoTabEvent}">
                     <c:set var="systemInfoTabMenuClass" value="active"/>
                 </c:if>
                <li class="${systemInfoTabMenuClass}">
                    <stripes:submit id="switchToSystemInfo" class="dealertab" name="${systemInfoTabEvent}"><fmt:message key="dealerlocation.tab.systemInfo"/></stripes:submit>
                </li>
            </nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="location.tab.marketing">
                <c:set var="marketingInfoTabEvent" value="<%=BaseManageDealerLocationActionBean.EVENT_SHOW_MARKETING_INFORMATION%>"/>
                <c:set var="marketingInfoTabMenuClass" value=""/>
                <c:if test="${actionBean.lastTabShown eq marketingInfoTabEvent}">
                     <c:set var="marketingInfoTabMenuClass" value="active"/>
                 </c:if>
                <li class="${marketingInfoTabMenuClass}">
                    <stripes:submit id="switchToMarketingInfo" class="dealertab" name="${marketingInfoTabEvent}"><fmt:message key="dealerlocation.tab.marketing"/></stripes:submit>
                </li>
            </nc:ifAccessAllowed>
        </ul>
    </div>
    <div class="clear">&nbsp;</div>
    

</stripes:layout-definition>

