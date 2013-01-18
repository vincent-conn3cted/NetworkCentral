<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
                      
    <stripes:layout-component name="html-head">
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/nc-ajax.js"></script>
          <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/dealerLocation/nc-dealership.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: dealer update general info page -->
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp"/>

        <%-- ==========================================
                Secure page stuffs
         =============================================--%>
        <c:set var="pageName" value="EditDealership-General" scope="page"/>
        <nc:pageName pageName="${pageName}"/>
        <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>


        <%-- Test if we are creating a new dealer --%>
        <c:choose>
            <c:when test="${actionBean.dealer.dealerId eq null}">
                   <c:set var="isCreatingNewDealer" value="true"/>
            </c:when>
            <c:otherwise>
                <c:set var="isCreatingNewDealer" value="false"/>
            </c:otherwise>
        </c:choose>

        <div id="dealerLocationDetailsPage" class="pageContent_wrapper">
            <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" focus="dealer.generalInfo.dealerName">
                <c:import url="/WEB-INF/jsp/messages.jsp"/>
                
                <stripes:hidden name="showAsReadOnly"/>
                 <c:if test="${isCreatingNewDealer eq true}">
                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_dealerHeaderToolbar.jsp" pageName="${pageName}" submitMethod="<%=ManageDealerLocationActionBean.EVENT_CREATE_DEALER%>" />
                </c:if>
                 <c:if test="${isCreatingNewDealer eq false}">
                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_dealerHeaderToolbar.jsp" pageName="${pageName}" />
                </c:if>
                <div class="clear">&nbsp;</div>
                
                <%-- Dont display the tab when creating a new dealer initially --%>
                <c:if test="${isCreatingNewDealer eq false}">
                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_tabs.jsp"/>
                </c:if>

                <stripes:hidden name="lastTabShown"/>

                <div id="dealerDetails-generalSection" class="mainContent_wrapper">
                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/generalInfo/components/_generalInfo.jsp" pageName="${pageName}"/>
                    <div class="clear"></div>

                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/generalInfo/components/_addressInfo.jsp" pageName="${pageName}" principalLocation="${actionBean.dealer.principalLocation}"/>
                    <div class="clear"></div>

                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/generalInfo/components/_communicationInfo.jsp" pageName="${pageName}"/>
                    <c:set var="initializeCorporateInfoFunctionName" value="initializeCorporateInformationFunctionality" scope="page"/>
                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/generalInfo/components/_corporateInfo.jsp" pageName="${pageName}"
                            initializeCorporateInfoFunctionName="${initializeCorporateInfoFunctionName}"/>
                    <div class="clear"></div>

                    <ul class="column-style-fieldset oneCol">
                        <li>
                            <fieldset>
                                <legend class="legend">Other Information</legend>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/generalInfo/components/_franchiseInfo.jsp" pageName="${pageName}"/>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/generalInfo/components/_datesInfo.jsp" pageName="${pageName}"/>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/generalInfo/components/_notesInfo.jsp" pageName="${pageName}"/>
                            </fieldset>
                        </li>
                    </ul>
                    <div class="clear"></div>
                    <c:if test="${!actionBean.footerDisplayable}">
                    	<c:if test="${(actionBean.dealer != null) && (actionBean.dealer.maintenanceDate != null) }"> 
			                <div align="center">
				            	<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.dealer.maintenanceDateAsString}"  />
				            </div>
			            </c:if>
					</c:if>
                </div>
            </stripes:form>
        </div>
    </stripes:layout-component>


    <stripes:layout-component name="init-event-handling">
        <script type="text/javascript">
            function yuiLoadComplete(){
                YAHOO.util.Event.onDOMReady(function(){
                    ${initializeCorporateInfoFunctionName}();
                });
            }

        </script>
    </stripes:layout-component>

</stripes:layout-render>
