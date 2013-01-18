<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

    <stripes:layout-component name="html-head">
         <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/dealerLocation/nc-dealership.css"/>
       </stripes:layout-component>


    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: dealer update tmca info page -->
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp" />

        <div id="dealerLocationDetailsPage" class="pageContent_wrapper">
            <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean">
                <%-- ==========================================
                    Secure page stuffs
                 =============================================--%>
                <c:set var="pageName" value="EditDealership-TMCA" scope="page"/>
                 <nc:pageName pageName="${pageName}"/>
                 <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

                <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_dealerCommonForm.jsp" pageName="${pageName}"/>

                <div id="dealerDetails-tmcaSection" class="mainContent_wrapper">
                    <c:set var="initializeSearchPMAFunctionName" value="initializeSearchPMA" scope="page"/>
                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/tmcaInfo/components/_generalInfo.jsp" pageName="${pageName}"
                                           initializeSearchPMAFunctionName="${initializeSearchPMAFunctionName}"/>
                    <div class="clear"></div>
                     
                    <c:set var="initializeOtherProductFunctionName" value="initializeOtherProduct" scope="page"/>
                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/tmcaInfo/components/_otherProducts.jsp" pageName="${pageName}"
                                       initializeOtherProductFunctionName="${initializeOtherProductFunctionName}" />
                    <div class="clear"></div>

                    <ul class="column-style-fieldset twoCols">
                        <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/tmcaInfo/components/_weightsInfo.jsp" pageName="${pageName}"/>
                        <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/tmcaInfo/components/_customerServiceInfo.jsp" pageName="${pageName}"/>
                    </ul>
                    <div class="clear"></div>
                    <ul class="column-style-fieldset twoCols">
                        <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/tmcaInfo/components/_dealerGroupMembershipInfo.jsp" pageName="${pageName}"/>
                        <c:set var="initializeTMCAFieldRepFunctionName" value="initializeTMCAFieldRepsDialog" scope="page"/>
                        <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/tmcaInfo/components/_tmcaFieldRepDialog.jsp" pageName="${pageName}"
                                initializeTMCAFieldRepFunctionName="${initializeTMCAFieldRepFunctionName}"/>
                    </ul>
                     <c:set var="initializeGetTMCAFieldRepInfoFunctionName" value="attachGetTMCAFieldRepInfoBehaviour" scope="page"/>
                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/tmcaInfo/components/_tmcaFieldRepsInfoDialog.jsp"
                            initializeGetTMCAFieldRepInfoFunctionName="${initializeGetTMCAFieldRepInfoFunctionName}"/>
                    <div class="clear"></div>


                    <c:set var="initializeBusinessImprovementFunctionName" value="initializeBusinessImprovementDialog" scope="page"/>
                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/tmcaInfo/components/_businessImprovementDialog.jsp" pageName="${pageName}"
                            initializeBusinessImprovementFunctionName="${initializeBusinessImprovementFunctionName}"/>
                    <div class="clear"></div>


                    <c:set var="initializeFinancialBenchmarkFunctionName" value="initializeFinancialBenchmarkDialog" scope="page"/>
                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/tmcaInfo/components/_financialBenchmarkDialog.jsp" pageName="${pageName}"
                            initializeFinancialBenchmarkFunctionName="${initializeFinancialBenchmarkFunctionName}"/>
                    <div class="clear"></div>

                      <c:set var="initializeDealerCommitteeFunctionName" value="initializeDealerCommitteeDialog" scope="page"/>
                     <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/tmcaInfo/components/_dealerCommmitteeDialog.jsp" pageName="${pageName}"
                             initializeDealerCommitteeFunctionName="${initializeDealerCommitteeFunctionName}"/>
                    <div class="clear"></div>
                     
                     <c:set var="initializeOtherFranchiseFunctionName" value="initializeOtherFranchiseDialog" scope="page"/>
                      <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/tmcaInfo/components/_otherFranchiseDialog.jsp" pageName="${pageName}"
                              initializeOtherFranchiseFunctionName="${initializeOtherFranchiseFunctionName}"/>
                    <div class="clear"></div>
                    <c:if test="${!actionBean.footerDisplayable}"> 
	                    <c:if test="${(actionBean.dealer != null) && (actionBean.dealer.maintenanceDate != null) }"> 
				            <div align="center">
					        	<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.dealer.maintenanceDateAsString}"  />
					        </div>
					    </c:if>
					</c:if>
                    </div>
                    <div class="clear"></div>
            </stripes:form>
            <div class="clear"></div>
        </div>
    </stripes:layout-component>




    <stripes:layout-component name="init-event-handling">
        <script type="text/javascript">
            function yuiLoadComplete(){
                YAHOO.util.Event.onDOMReady(function(){

                <nc:ifWriteAccessAllowed name="dealer.businessImprovements">
                    ${initializeBusinessImprovementFunctionName}();
                </nc:ifWriteAccessAllowed>

                <nc:ifWriteAccessAllowed name="dealer.financialBenchmark">                    
                    ${initializeFinancialBenchmarkFunctionName}();
                </nc:ifWriteAccessAllowed>

                <nc:ifWriteAccessAllowed name="dealer.otherFranchise">
                    ${initializeOtherFranchiseFunctionName}();
                </nc:ifWriteAccessAllowed>

                <nc:ifWriteAccessAllowed name="dealer.committees">
                    ${initializeDealerCommitteeFunctionName}();
                </nc:ifWriteAccessAllowed>

                <nc:ifWriteAccessAllowed name="dealer.tmcafieldreps">
                     ${initializeTMCAFieldRepFunctionName}();
                </nc:ifWriteAccessAllowed>

                    ${initializeGetTMCAFieldRepInfoFunctionName}();

                     <%-- here we check access to dealer.otherProducts, instead of dealer.otherProducts.edit, since we do the
                     initialization there (checking the checked checkboxes) --%>
                    <nc:ifAccessAllowed name="dealer.otherProducts">
                        ${initializeOtherProductFunctionName}();
                    </nc:ifAccessAllowed>
                });
                disableReadOnlyCheckboxes();

                <nc:ifWriteAccessAllowed name="dealer.generalInfo.pma.pmaId">
                    ${initializeSearchPMAFunctionName}();
                </nc:ifWriteAccessAllowed>

            }
        </script>
    </stripes:layout-component>

</stripes:layout-render>
