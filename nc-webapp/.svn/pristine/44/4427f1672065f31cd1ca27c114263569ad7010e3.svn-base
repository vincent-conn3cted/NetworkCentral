<%@ page import="au.com.toyota.nc.common.dealers.impl.SapDealer" %>
<%@ page import="au.com.toyota.nc.webapp.dataproxy.SAPCodeVerifier" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

    <stripes:layout-component name="html-head">
          <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/dealerLocation/nc-dealership.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: dealer update identification page -->
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp"/>

         <c:set var="pageName" value="EditDealership-Identification" scope="page"/>
        <nc:pageName pageName="${pageName}"/>
        <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

        <c:set var="allowVerifyingSAPCode" value="false"/>
        <nc:ifWriteAccessAllowed name="dealer.generalInfo.sapDealerCode">
            <c:set var="allowVerifyingSAPCode" value="true"/>
        </nc:ifWriteAccessAllowed>

        <div id="dealerLocationDetailsPage" class="pageContent_wrapper">
            <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean">
                <%-- ==========================================
                    Secure page stuffs
                    =============================================--%>

                <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_dealerCommonForm.jsp" pageName="${pageName}"/>

                <div id="dealerDetails-identificationSection" class="mainContent_wrapper">
                      <ul class="column-style-fieldset oneCol">
                        <li>
                                <fieldset id="identificationInfo-generalSection">
                                    <nc:label name="code.dealer.sap" for="dealer.generalInfo.sapDealerCode"/>

                                    <%--
                                        Dealer SAP Code is editable only for Draft dealer
                                    --%>
                                    <c:choose>
                                        <c:when test="${actionBean.dealer.draft}">
                                            <nc:text name="dealer.generalInfo.sapDealerCode" id="dealer.generalInfo.sapDealerCode"/><br/>
                                        </c:when>
                                        <c:otherwise>
                                            <%--
                                            We need to put the guard here, since  SAP code is not necessarily displayed for some roles
                                             nc:text already does this business.. so no check is needed there.
                                            --%>
                                            <nc:ifAccessAllowed name="dealer.generalInfo.sapDealerCode">
                                                <span id="dealer.generalInfo.sapDealerCode" class="formValue">${actionBean.dealer.generalInfo.sapDealerCode}</span><br/>
                                            </nc:ifAccessAllowed>
                                        </c:otherwise>
                                    </c:choose>

                                    <nc:label name="code.dealer" for="dealer.generalInfo.dealerCode"/>
                                    <nc:text id="dealer.generalInfo.dealerCode" name="dealer.generalInfo.dealerCode"/><br/>

                                    <nc:label name="code.partsdealer" for="dealer.generalInfo.partsDealerCode"/>
                                    <nc:text id="dealer.generalInfo.partsDealerCode" name="dealer.generalInfo.partsDealerCode"/><br/>

                                    <nc:label name="code.motordealerlicensenumber" for="dealer.generalInfo.motorDealerLicenseNumber"/>
                                    <nc:text id="dealer.generalInfo.motorDealerLicenseNumber" name="dealer.generalInfo.motorDealerLicenseNumber"/><br/>
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
            <div class="clear"></div>
           
            
        </div>
        <c:if test="${allowVerifyingSAPCode eq true && actionBean.showAsReadOnly eq false}">
                <div id="verifySAPDealerCodeDialog" class="dialog">
                    <div class="hd"></div>
                    <div class="bd">
                        <fieldset>
                            <label for="verifiedDealerSAPCode"><fmt:message key="code.sap"/></label>
                            <span id="verifiedDealerSAPCode" class="dealerSAPCode formValue"></span><br/>

                            <label for="verifiedSAPDealerName"><fmt:message key="dealer.generalInfo.dealerName"/></label>
                            <span id="verifiedSAPDealerName" class="dealerName formValue"></span><br/>
                        </fieldset>
                    </div>
                </div>
        </c:if>

    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">
        <script type="text/javascript">
            <c:if test="${allowVerifyingSAPCode eq true && actionBean.showAsReadOnly eq false}">
                    /**
                     *  Perform SAP code verification
                     * */
                    function attachVerifySAPCodeBehaviour(){
                        var VerifySAPDealerCodeCommandObject = {
                               handleSuccess: function(transport){
                                   var verifyResponse = YAHOO.lang.JSON.parse(transport.responseText);
                                   YAHOO.log("Successfully perform SAP code verification","info");

                                   var isSuccess=verifyResponse.<%=SAPCodeVerifier.PROPERTY_SUCCESS%>;
                                   if (isSuccess){
                                       YAHOO.log("Verified - correct SAP code has been used","info");
                                       var sapDealer=verifyResponse.<%=SAPCodeVerifier.PROPERTY_DEALER%>;

                                       $("#verifySAPDealerCodeDialog .hd").text("<fmt:message key="sapCodeVerification.header.verified"/>");
                                       $("#verifySAPDealerCodeDialog .bd #verifiedDealerSAPCode").text(sapDealer.<%=SapDealer.PROPERTY_DEALER_CODE%>);
                                       $("#verifySAPDealerCodeDialog .bd #verifiedSAPDealerName").text(sapDealer.<%=SapDealer.PROPERTY_DEALER_NAME%>);
                                   }else{
                                       var errorMsg = verifyResponse.<%=SAPCodeVerifier.PROPERTY_ERROR_MSG%>;
                                       YAHOO.log("Fail! - invalid SAP code has been used. Error message: " +errorMsg ,"error");

                                        $("#verifySAPDealerCodeDialog .hd").text("<fmt:message key="sapCodeVerification.header.fail"/>");
                                       $("#verifySAPDealerCodeDialog .bd #verifiedDealerSAPCode").text("<fmt:message key="sapCodeVerification.notFound"/>");
                                       $("#verifySAPDealerCodeDialog .bd #verifiedSAPDealerName").text("<fmt:message key="sapCodeVerification.notFound"/>");
                                       $("#dealer\\.generalInfo\\.sapDealerCode").val("");
                                   }
                                   YAHOO.au.com.toyota.widget.VerifySAPCodeDialog.show();
                               },
                               handleFailure: function(transport){
                                    YAHOO.log("An error has occurred while verifying SAP code =" + transport.responseText,"error");
                                    alert("Failed to load data from server");
                               }
                           };


                        YAHOO.log("Attaching verify SAP deale code behavior","info");
                        $("#dealer\\.generalInfo\\.sapDealerCode").blur(function(){
                                YAHOO.log("Verifying SAP dealer code..","info");
                                <stripes:url var="searchSAPCodeURL" beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" event="verifySAPCode"/>
                                if ($(this).val()!=""){
                                    YAHOO.util.Connect.asyncRequest('GET', "${searchSAPCodeURL}&dealerSAPCode=" + $(this).val(),{
                                        cache:false,               // this option is needed. Firefox doesnt cache HTTP GET, but IE does.
                                        success: VerifySAPDealerCodeCommandObject.handleSuccess,
                                        failure: VerifySAPDealerCodeCommandObject.handleFailure
                                    });
                                }
                        });

                         <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                                                dialogName="VerifySAPCodeDialog" dialogId="verifySAPDealerCodeDialog"/>
                    }
            </c:if>
            

            function yuiLoadComplete(){
                YAHOO.util.Event.onDOMReady(function(){
                        <c:if test="${allowVerifyingSAPCode eq true && actionBean.showAsReadOnly eq false}">
                                attachVerifySAPCodeBehaviour();
                        </c:if>
                });
            }
        </script>
    </stripes:layout-component>

</stripes:layout-render>
