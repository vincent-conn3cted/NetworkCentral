<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

    <stripes:layout-component name="html-head">
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/nc-ajax.js"></script>
         <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/dealerLocation/nc-dealership.css"/>
    </stripes:layout-component>



    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: dealer update system info page -->
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp" />

        <div id="dealerLocationDetailsPage" class="pageContent_wrapper">
            <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean">
                 <%-- ==========================================
                    Secure page stuffs
                 =============================================--%>
                <c:set var="pageName" value="EditDealership-System" scope="page"/>

                <nc:pageName pageName="${pageName}"/>
                <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
                <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_dealerCommonForm.jsp" pageName="${pageName}"/>

                <div id="dealerDetails-systemSection" class="mainContent_wrapper">
                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/systemInfo/components/_systemInfo.jsp" pageName="${pageName}"/>

                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/systemInfo/components/_rddInfo.jsp" pageName="${pageName}"/>

                    <nc:ifAccessAllowed name="dealer.systemInfo.dmsVendor">
                        <ul class="column-style-fieldset oneCol">
                            <li>
                                <fieldset id="systemInfo-dmsSection" class="twocols">
                                    <legend><fmt:message  key="dealer.sysinfotab.section.dms.header"/></legend>

                                    <nc:label name="vendor.name" for="dealer.systemInfo.dmsVendor.dmsVendorId"/>
                                    <nc:select-active-values selectedObject="${actionBean.dealer.systemInfo.dmsVendor}"
                                                             valueAttribute="dmsVendorId"
                                                             labelAttribute="name"
                                                             collections="${actionBean.allActiveVendors}"
                                                             name="dealer.systemInfo.dmsVendor.dmsVendorId"
                                                             id="dealer.systemInfo.dmsVendor.dmsVendorId"
                                                             onchange="showOptionsForSelectedDmsVendor(this);">
                                        <option value=""><fmt:message key="label.selectone"/></option>
                                    </nc:select-active-values><br/>

                                    <div id="systemInfo-dmsSection-options">
                                        <c:if test="${actionBean.dealer.systemInfo.dmsVendor != null}">
                                            <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/systemInfo/components/_dmsVendorOptions.jsp"
                                                                   dealer="${actionBean.dealer}"
                                                                   showAsReadOnly="${actionBean.showAsReadOnly eq true}"
                                                                   selectedDmsVendor="${actionBean.dealer.systemInfo.dmsVendor}"/>
                                        </c:if>
                                    </div>
                                </fieldset>
                            </li>
                    </ul>
                    <div class="clear"></div>
                    </nc:ifAccessAllowed>
	            <c:if test="${!actionBean.footerDisplayable}"> 
		            <c:if test="${(actionBean.dealer != null) && (actionBean.dealer.maintenanceDate != null) }"> 
			            <div align="center">
				        	<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.dealer.maintenanceDateAsString}"  />
				        </div>
				    </c:if>
				</c:if>
                </div>
            </stripes:form>
            <div class="clear"></div>
        </div>
    </stripes:layout-component>

<stripes:layout-component name="init-event-handling">
        <script type="text/javascript">
            function showOptionsForSelectedDmsVendor(selectElement)
            {
                var selectedId = selectElement.value;
                if(selectedId != '')
                {
                    var getUrl = '<stripes:url beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ShowDmsVendorOptionsActionBean" event="showSelectedDmsVendorOptions"/>';
                    getUrl += '&dmsVendorId=' + selectedId;
                    getUrl += '&dealer.dealerId=' + <c:out value="${actionBean.dealer.dealerId}"/>;
                    getAjaxUpdate(getUrl, 'systemInfo-dmsSection-options');
                }
                else
                {
                    document.getElementById('systemInfo-dmsSection-options').innerHTML = '';
                }
            }

            function showInfoForDmsContact(selectElement)
            {
                var selectedId = selectElement.value;
                if(selectedId != '')
                {
                    var getUrl = '<stripes:url beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ShowDmsVendorOptionsActionBean" event="showInfoForDmsContact"/>';
                    getUrl += '&dmsContactId=' + selectedId;
                    getUrl += '&dealer.dealerId=' + <c:out value="${actionBean.dealer.dealerId}"/>;
                    getAjaxUpdate(getUrl, 'systemInfo-dmsSection-contact-info');
                }
                else
                {
                    document.getElementById('systemInfo-dmsSection-contact-info').innerHTML = '';
                }
            }

            function yuiLoadComplete(){
                YAHOO.util.Event.onDOMReady(function(){
                });
            }
        </script>
    </stripes:layout-component>

</stripes:layout-render>
