<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

    <ul class="column-style-fieldset oneCol">
        <li>
            <fieldset id="tmcaInfo-generalSection">
                <legend><fmt:message  key="dealer.tmcatab.section.general.header"/></legend>
                   <nc:ifWriteAccessAllowed name="dealer.generalInfo.pma.pmaId">
                        <nc:label name="pma.name" for="dealer.generalInfo.pma.pmaId"/>
                        <nc:hidden id="dealer.generalInfo.pma.pmaId" name="dealer.generalInfo.pma.pmaId"/>
                        <input type="text" id="searchPMATextBox" value="${actionBean.dealer.generalInfo.pma.code}"/>
                        <span id="searchPMAResult">${actionBean.dealer.generalInfo.pma.name}</span><br/>
                   </nc:ifWriteAccessAllowed>
                    <nc:ifReadOnlyAccess name="dealer.generalInfo.pma.pmaId">
                        <nc:label name="pma.name" for="dealer.generalInfo.pma.pmaId"/>
                        <span id="dealer.generalInfo.pma.pmaId" class="formValue">${actionBean.dealer.generalInfo.pma.code} ${actionBean.dealer.generalInfo.pma.name}</span><br/>
                    </nc:ifReadOnlyAccess>

                    <%--
                        Warning dialog shown for searching PMA
                    --%>
                    <nc:ifWriteAccessAllowed name="dealer.generalInfo.pma.pmaId">
                        <div id="pmaWarningDialog" class="dialog">
                            <div class="hd"><fmt:message key="label.warning"/></div>
                            <div class="bd"></div>
                        </div>
                    </nc:ifWriteAccessAllowed>

                    <nc:label name="dealer.generalInfo.metroFlag" for="dealer.generalInfo.metroFlag"/>
                    <nc:ifWriteAccessAllowed name="dealer.generalInfo.metroFlag">
                        <nc:radio value="true" name="dealer.generalInfo.metroFlag" checkedLabel="Metro"/><fmt:message key="label.metro"/>
                        <nc:radio value="false" name="dealer.generalInfo.metroFlag" checkedLabel="Rural"/><fmt:message key="label.rural"/><br/>
                    </nc:ifWriteAccessAllowed>

                    <nc:ifReadOnlyAccess name="dealer.generalInfo.metroFlag">
                        <nc:radio value="true" name="dealer.generalInfo.metroFlag" checkedLabel="Metro"/>
                        <nc:radio value="false" name="dealer.generalInfo.metroFlag" checkedLabel="Rural"/><br/>
                    </nc:ifReadOnlyAccess>

                    <nc:label name="dealer.generalInfo.region" for="dealer.generalInfo.region"/>
                    <nc:select name="dealer.generalInfo.region" readOnlyValue="${actionBean.dealer.generalInfo.region}">
                        <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                        <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.Region"/>
                    </nc:select><br/>

                    <nc:label name="dealer.generalInfo.regionClassification" for="dealer.generalInfo.regionClassification"/>
                    <nc:select name="dealer.generalInfo.regionClassification" readOnlyValue="${actionBean.dealer.generalInfo.regionClassification.description}">
                        <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                        <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.RegionClassification" label="description"/>
                    </nc:select><br/>

                    <nc:label name="dealer.generalInfo.salesDistrict" for="dealer.generalInfo.salesDistrict"/>
                    <nc:text name="dealer.generalInfo.salesDistrict"/><br/>

                    <nc:label name="dealer.generalInfo.operationDistrict" for="dealer.generalInfo.operationDistrict"/>
                    <nc:text name="dealer.generalInfo.operationDistrict"/><br/>

                    <nc:label name="dealer.generalInfo.serviceDistrict" for="dealer.generalInfo.serviceDistrict"/>
                    <nc:text name="dealer.generalInfo.serviceDistrict"/><br/>

                    <nc:label name="dealer.generalInfo.financialReportingFlag" for="dealer.generalInfo.financialReportingFlag"/>
                    <nc:checkbox name="dealer.generalInfo.financialReportingFlag"/><br/>
            </fieldset>
        </li>
    </ul>
     <nc:ifWriteAccessAllowed name="dealer.generalInfo.pma.pmaId">
         <script type="text/javascript">
                /**
                *   Clear search PMA result
               */
                function clearPMASearchResult(){
                         $("#searchPMAResult").text("");
                        $("#dealer\\.generalInfo\\.pma\\.pmaId").val("");
                }
                /**
                 * Show PMA warning message
                 * @param message
                 */
                function showPMAWarningDialog(message){
                     $("#pmaWarningDialog div.bd").text(message);
                    YAHOO.au.com.toyota.widget.PMAWarningDialog.show();
                }

                function ${initializeSearchPMAFunctionName}(){
                                var PMASearchCommandObject = {
                                    handleSuccess: function(transport){
                                        try{
                                            var pmaSearchResponse =YAHOO.lang.JSON.parse(transport.responseText);
                                            YAHOO.log("Successfully fetched PMA","info");

                                            var openPMA = pmaSearchResponse.openPMA;
                                            var activeDealerUsedForPMA = pmaSearchResponse.activeDealerName;
                                            var activeDealerIdUsedForPMA = pmaSearchResponse.activeDealerId;
                                            var currentEditingDealerId = $("#dealerId").val();
                                            var pmaName= pmaSearchResponse.name;
                                            var pmaId= pmaSearchResponse.id;

                                        <c:choose>
                                            <c:when test="${actionBean.dealer.generalInfo.status.active}">
                                            // If  the PMA has been used for other active PMA, then dont allow using it
                                            if (!openPMA && (activeDealerIdUsedForPMA != null) && (activeDealerIdUsedForPMA != currentEditingDealerId))
                                            {
                                                    YAHOO.log("PMA is already been used for dealer: "+activeDealerIdUsedForPMA + " " + activeDealerUsedForPMA,"info");
                                                    clearPMASearchResult();
                                                    showPMAWarningDialog("The PMA is already used for dealer '" +activeDealerUsedForPMA + "'. Please enter another PMA");
                                            }
                                            else
                                            {
                                                updatePma(pmaId, pmaName);
                                            }
                                            </c:when>
                                            <c:otherwise>
                                                updatePma(pmaId, pmaName);
                                            </c:otherwise>
                                        </c:choose>
                                        }catch(e){
                                            YAHOO.log("Error has occurred while interpreting PMA from server " + transport.responseText,"error");
                                            alert("Failed to interpret data from server !");
                                        }
                                    },
                                    handleFailure: function(transport){
                                        YAHOO.log("An error has occurred while fetching PMA " + transport.responseText,"error");
                                        alert("Failed to load data from server")
                                    }
                                };

                                // Attach behaviour on lost focus of PMA search text
                                $("#searchPMATextBox").blur(function(){
                                    if ($(this).val()!="" && $(this).val !=null){
                                        <stripes:url beanclass="au.com.toyota.nc.webapp.stripes.admin.ManagePMAActionBean" event="getJSONPMA" var="searchPMAURL"/>
                                                YAHOO.util.Connect.asyncRequest('GET', "${searchPMAURL}&searchRequest.code=" + $(this).val(),
                                           {
                                               cache:false,             // this option is needed. Firefox doesnt cache HTTP GET, but IE does.
                                                success:PMASearchCommandObject.handleSuccess,
                                                failure:PMASearchCommandObject.handleFailure
                                           });
                                    }else{
                                            $("#searchPMAResult").text("");
                                            $("#dealer\\.generalInfo\\.pma\\.pmaId").val("");
                                    }
                                });

                                <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                                        dialogName="PMAWarningDialog" dialogId="pmaWarningDialog"/>
                }

             function updatePma(pmaId, pmaName)
             {
                 if (pmaId != null){
                     YAHOO.log("PMA is an open PMA","info");
                     $("#searchPMAResult").text(pmaName );
                     $("#dealer\\.generalInfo\\.pma\\.pmaId").val(pmaId);
                 }else{
                     YAHOO.log("PMA is not found","info");
                     showPMAWarningDialog("Invalid PMA Code entered.");
                     $("#searchPMATextBox").val("");
                     clearPMASearchResult();
                 }                 
             }
            </script>
          </nc:ifWriteAccessAllowed>

</stripes:layout-definition>