<%@ page import="au.com.toyota.nc.webapp.dataproxy.SAPCodeVerifier" %>
<%@ page import="au.com.toyota.nc.common.locations.SapLocation" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<%--
    This Stripes component is to be used in conjunction with the page that let user
     to input location SAP Code.
     Parameters needed:
     1. dealerSAPCode : the actual value of the dealer's SAP code. i.e. the numerical value
     2. locationSAPCodeInputId : HTML ID of the input element where user enter the location SAP code to be verified

     Usage:
     call SAPLocationVerificator.initAll() function.
--%>
<stripes:layout-definition>

    <div id="verifySAPLocationCodeDialog" class="dialog">
        <div class="hd"></div>
        <div class="bd">
            <fieldset>
                <label for="verifiedLocationSAPCode"> <fmt:message key="code.sap"/></label>
                <span id="verifiedLocationSAPCode" class="formValue"></span><br/>

                <label for="verifiedSAPLocationName"><fmt:message key="dealer.generalInfo.dealerName"/></label>
                <span id="verifiedSAPLocationName" class="formValue"></span><br/>
            </fieldset>
        </div>
    </div>

    <script type="text/javascript">
         var SAPLocationVerificator= {
             /**
              *  Creates all components, and attach all event handler
               */
                  initAll:function(){
                        YAHOO.log("Initializing location SAP code verificator","info");
                        this._prepareComponents();
                        this._initEventHandling();
                        YAHOO.log("Finished initializing location SAP code verificator","info");
                  },


                  _prepareComponents:function(){
                        YAHOO.log("Creating location SAP code info dialog","info");
                          <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                                            dialogName="VerifySAPCodeDialog" dialogId="verifySAPLocationCodeDialog"/>
                        YAHOO.log("Finished creating location SAP code info dialog","info");
                  },
                  _initEventHandling:function(){
                            YAHOO.log("Attaching listener to blur of location SAP code input","info");
                            $("#${locationSAPCodeInputId}").blur(function(){
                                YAHOO.log("Verifying SAP location code..","info");
                                if ($(this).val()!="") {
                                    <stripes:url var="searchSAPCodeURL" beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean" event="verifySAPCode"/>
                                    YAHOO.util.Connect.asyncRequest('GET', "${searchSAPCodeURL}&dealerSAPCode=${dealerSAPCode}&locationSAPCode="+$(this).val(),{
                                        cache:false,    // this option is needed. Firefox doesnt cache HTTP GET, but IE does.
                                        success: SAPLocationVerificator._onSuccessVerification,
                                        failure: SAPLocationVerificator._onFailureVerification
                                    });
                                }
                            });
                            YAHOO.log("Finished  listener to blur of location SAP code input","info");
                  },
             /**
              * Called when the verification succeed
              * @param transport
              */
                  _onSuccessVerification:function(transport){
                          var verifyResponse = YAHOO.lang.JSON.parse(transport.responseText);
                        YAHOO.log("Successfully perform SAP code verification","info");

                        var isSuccess=verifyResponse.<%=SAPCodeVerifier.PROPERTY_SUCCESS%>;
                        if (isSuccess) {
                            YAHOO.log("Verified - correct SAP code has been used","info");
                            var sapLocation = verifyResponse.<%=SAPCodeVerifier.PROPERTY_LOCATION%>;

                            $("#verifySAPLocationCodeDialog .hd").text("<fmt:message key="sapCodeVerification.header.verified"/>");
                            $("#verifySAPLocationCodeDialog .bd #verifiedLocationSAPCode").text(sapLocation.<%=SapLocation.PROPERTY_LOCATION_CODE%>);
                            $("#verifySAPLocationCodeDialog .bd #verifiedSAPLocationName").text(sapLocation.<%=SapLocation.PROPERTY_LOCATION_NAME%>);
                        }else{
                            var errorMsg = verifyResponse.<%=SAPCodeVerifier.PROPERTY_ERROR_MSG%>;
                            YAHOO.log("Fail! - invalid SAP code has been used. Error message: " + errorMsg,"error");

                            $("#verifySAPLocationCodeDialog .hd").text("<fmt:message key="sapCodeVerification.header.fail"/>");
                            $("#verifySAPLocationCodeDialog .bd #verifiedLocationSAPCode").text("<fmt:message key="sapCodeVerification.notFound"/>");
                            $("#verifySAPLocationCodeDialog .bd #verifiedSAPLocationName").text("<fmt:message key="sapCodeVerification.notFound"/>");
                            $("#${locationSAPCodeInputId}").val("");
                        }
                        YAHOO.au.com.toyota.widget.VerifySAPCodeDialog.show();
                  },
             /**
              * Called when the verification failed
              * @param transport
              */
                  _onFailureVerification:function(transport){
                        YAHOO.log("An error has occurred while verifying SAP code = " + transport.responseText,"error");
                        alert("Failed to load data from server");
                        $("#${locationSAPCodeInputId}").val("");
                  }
                };

    </script>
</stripes:layout-definition>
