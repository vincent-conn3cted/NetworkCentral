<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
  <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/nc-dealerinfo-layout.css" />
    </stripes:layout-component>


    <stripes:layout-component name="page-contents">
            <%-- ==========================================
           Secure page stuffs
           =============================================--%>
            <nc:pageName pageName="DealerBulkUpdate"/>
            <nc:pageViewMode readOnly="false"/>
            <!-- for selenium tests: dealer bulk update page -->
            <div class="pageContent_main_header">
                <h1 id="pageTitle"><fmt:message key="dealerbulkupdate.header"/></h1>
            </div>            
            <div class="pageContent_wrapper">
                <div id="dealerBulkUpdate" class="mainContent_wrapper">
                    <div id="selectedDealerNameDiv">
                        <h4><fmt:message key="dealerbulkupdate.selectedDealer.header"/>:</h4>
                        <ul id="selectedDealerNameList">
                            <c:forEach items="${actionBean.dealersToBeUpdated }" var="dealer">
                                <li><c:out value="${dealer.generalInfo.dealerName}"/></li>
                            </c:forEach>
                        </ul>
                    </div>
                    <c:import url="/WEB-INF/jsp/messages.jsp"/>

                    <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.DealerBulkUpdateActionBean" method="post">
                    <%-- Hidden fields of the selected dealer ID --%>
                        <div id="selectedDealerIdDiv">
                            <c:forEach items="${actionBean.request.selectedId}" var="selectedDealerId" varStatus="dealerSelectorStatus">
                                <stripes:hidden name="request.selectedId[${dealerSelectorStatus.index}]" id="selectedDealerId-${dealerSelectorStatus.index}"/>
                            </c:forEach>
                        </div>

                        <div id="bulkUpdateFormFields">
                        <nc:ifAccessAllowed name="request.sampleDealer.districtsInfo">
                            <fieldset id="districtSection">
                                <legend><fmt:message key="dealer.tmcatab.section.districts.header"/></legend>
                                <nc:label name="dealer.generalInfo.salesDistrict" for="request.sampleDealer.generalInfo.salesDistrict"/>
                                <nc:text id="request.sampleDealer.generalInfo.salesDistrict" name="request.sampleDealer.generalInfo.salesDistrict"/><br/>

                                <nc:label name="dealer.generalInfo.operationDistrict" for="request.sampleDealer.generalInfo.operationDistrict"/>
                                <nc:text id="request.sampleDealer.generalInfo.operationDistrict" name="request.sampleDealer.generalInfo.operationDistrict"/><br/>

                                <nc:label name="dealer.generalInfo.serviceDistrict" for="request.sampleDealer.generalInfo.serviceDistrict"/>
                                <nc:text id="request.sampleDealer.generalInfo.serviceDistrict" name="request.sampleDealer.generalInfo.serviceDistrict"/><br/>
                            </fieldset>
                        </nc:ifAccessAllowed>

                        <nc:ifAccessAllowed name="request.sampleDealer.businessPartnersInfo">
                            <c:set var="allTMCAStaff" value="${actionBean.allTMCAStaff}" scope="page"/>
                            <c:if test="${fn:length(allTMCAStaff)>0}"> <%-- only display form if there are TMCA field reps --%>
                            <fieldset id="representativesSection">
                                <legend><fmt:message  key="dealer.businessPartnersInfo.tmcaFieldRep"/></legend>
                                <table id="representativesTable">
                                    <nc:ifWriteAccessAllowed name="request.sampleDealer.businessPartnersInfo.dsmStaff.personId">
                                        <tr>
                                            <td><span class="formLabel"><fmt:message  key="dealer.businessPartnersInfo.dsmStaff"/></span></td>
                                             <td id="DSMColumn" class="tmcaFieldRepColumn">
                                                    <nc:text id="DSMNameInput" name="request.sampleDealer.businessPartnersInfo.dsmStaff.fullName" readonly="true" class="readonly"/>
                                                    <nc:hidden id="DSMFK" name="request.sampleDealer.businessPartnersInfo.dsmStaff.personId" class="fkField"/>
                                            </td>
                                             <td><a href="" id="addDSMButton" class="addTMCARepLink"><fmt:message key="label.add"/></a></td>
                                             <td><a href="" id="deleteDSMButton" class="deleteTMCARepLink"><fmt:message key="label.remove"/></a></td>
                                        </tr>
                                    </nc:ifWriteAccessAllowed>
                                    <nc:ifWriteAccessAllowed name="request.sampleDealer.businessPartnersInfo.dsomStaff.personId">
                                        <tr>
                                            <td><span class="formLabel"><fmt:message  key="dealer.businessPartnersInfo.dsomStaff"/></span></td>
                                            <td id="DSOMColumn" class="tmcaFieldRepColumn">
                                                <nc:text id="DSOMNameInput" name="request.sampleDealer.businessPartnersInfo.dsomStaff.fullName" readonly="true" class="readonly"/>
                                                <nc:hidden id="DSOMFK" name="request.sampleDealer.businessPartnersInfo.dsomStaff.personId" class="fkField"/>
                                            </td>
                                            <td><a href="" id="addDSOMButton" class="addTMCARepLink"><fmt:message key="label.add"/></a></td>
                                            <td><a href="" id="deleteDSOMButton" class="deleteTMCARepLink"><fmt:message key="label.remove"/></a></td>
                                        </tr>
                                    </nc:ifWriteAccessAllowed>
                                    <nc:ifWriteAccessAllowed name="request.sampleDealer.businessPartnersInfo.dsomStaff.personId">
                                        <tr>
                                            <td><span class="formLabel"><fmt:message  key="dealer.businessPartnersInfo.dcsaimStaff"/></span></td>
                                            <td id="DCSAIMColumn" class="tmcaFieldRepColumn">
                                                <nc:text id="DCSAIMNameInput" name="request.sampleDealer.businessPartnersInfo.dcsaimStaff.fullName" readonly="true" class="readonly"/>
                                                <nc:hidden id="DCSAIMFK" name="request.sampleDealer.businessPartnersInfo.dcsaimStaff.personId" class="fkField"/>
                                            </td>
                                            <td><a href="" id="addDCSAIMButton" class="addTMCARepLink"><fmt:message key="label.add"/></a></td>
                                            <td><a href="" id="deleteDCSAIMButton" class="deleteTMCARepLink"><fmt:message key="label.remove"/></a></td>
                                        </tr>
                                    </nc:ifWriteAccessAllowed>
                                    <nc:ifWriteAccessAllowed name="request.sampleDealer.businessPartnersInfo.doprmStaff.personId">
                                        <tr>
                                            <td><span class="formLabel"><fmt:message  key="dealer.businessPartnersInfo.doprmStaff"/></span></td>
                                            <td id="DOPRMColumn" class="tmcaFieldRepColumn">
                                                <nc:text id="DOPRMNameInput" name="request.sampleDealer.businessPartnersInfo.doprmStaff.fullName" readonly="true" class="readonly"/>
                                                <nc:hidden id="DOPRMFK" name="request.sampleDealer.businessPartnersInfo.doprmStaff.personId" class="fkField"/>
                                            </td>
                                            <td><a href="" id="addDOPRMButton" class="addTMCARepLink"><fmt:message key="label.add"/></a></td>
                                            <td><a href="" id="deleteDOPRMButton" class="deleteTMCARepLink"><fmt:message key="label.remove"/></a></td>
                                        </tr>
                                    </nc:ifWriteAccessAllowed>
                                    <nc:ifWriteAccessAllowed name="request.sampleDealer.businessPartnersInfo.technicalSpecialistStaff.personId">
                                        <tr>
                                            <td><span class="formLabel"><fmt:message  key="dealer.businessPartnersInfo.technicalSpecialistStaff"/></span></td>
                                            <td id="TechSpecColumn" class="tmcaFieldRepColumn">
                                                <nc:text id="TechSpecNameInput" name="request.sampleDealer.businessPartnersInfo.technicalSpecialistStaff.fullName" readonly="true" class="readonly"/>
                                                <nc:hidden id="TechSpecFK" name="request.sampleDealer.businessPartnersInfo.technicalSpecialistStaff.personId" class="fkField"/>
                                            </td>
                                            <td><a href="" id="addTechSpecButton" class="addTMCARepLink"><fmt:message key="label.add"/></a></td>
                                            <td><a href="" id="deleteTechSpecButton" class="deleteTMCARepLink"><fmt:message key="label.remove"/></a></td>
                                        </tr>
                                    </nc:ifWriteAccessAllowed>
                                    <nc:ifWriteAccessAllowed name="request.sampleDealer.businessPartnersInfo.raskmStaff.personId">
                                        <tr>
                                            <td><span class="formLabel"><fmt:message  key="dealer.businessPartnersInfo.raskmStaff"/></span></td>
                                            <td id="RASKMColumn" class="tmcaFieldRepColumn">
                                                <nc:text id="RASKMNameInput" name="request.sampleDealer.businessPartnersInfo.raskmStaff.fullName" readonly="true" class="readonly"/>
                                                <nc:hidden id="RASKMFK" name="request.sampleDealer.businessPartnersInfo.raskmStaff.personId" class="fkField"/>
                                            </td>
                                            <td><a href="" id="addRASKMButton" class="addTMCARepLink"><fmt:message key="label.add"/></a></td>
                                            <td><a href="" id="deleteRASKMButton" class="deleteTMCARepLink"><fmt:message key="label.remove"/></a></td>
                                        </tr>
                                    </nc:ifWriteAccessAllowed>
                                </table>
                            </fieldset>

                                    <!--
                                    Dialog for adding TMCA field reps
                                    -->
                                  <div id="addTMCAFieldRepDialog" class="dialog" style="width: 30em">
                                        <div class="hd"><fmt:message key="label.add"/><fmt:message  key="dealer.businessPartnersInfo.tmcaFieldRep"/></div>
                                        <div class="bd">
                                            <span id="fieldRepType" style="display:none"></span>
                                             <select id="tmcaStaffSelectList">
                                                <c:forEach items="${allTMCAStaff}" var="tmcaStaff">
                                                    <option value="${tmcaStaff.personId}">${tmcaStaff.fullName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>


                                        <script type="text/javascript">
                                        /**
                                         *  Handler for TMCA Field Reps functionalities
                                         * Call initAll() method to do all initialization.
                                         */
                                        var TMCAFieldRepHandler={
                                            initAll:function(){
                                                YAHOO.log("Initializing TMCA field functionality","info");
                                                this.prepareComponents();
                                                this.initEventHandling();
                                                this.initUIState();
                                                YAHOO.log("Finished initializing TMCA field functionality","info");
                                            },
                                            prepareComponents: function(){
                                                 YAHOO.log("Creating TMCA Field Reps dialog","info");
                                                <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                                                               dialogName="AddTMCAFieldRepDialog" dialogId="addTMCAFieldRepDialog" okHandler="TMCAFieldRepHandler.addTMCAFieldRep"/>
                                                YAHOO.log("Finished creating TMCA Field Reps dialog","info");
                                            },
                                            initEventHandling:function(){
                                                var setDSMVar = function(){
                                                    $("#fieldRepLabel").text("DSM");
                                                    $("#fieldRepType").text("DSM");
                                                };
                                                var setDCSAIM = function(){
                                                    $("#fieldRepLabel").text("DCSAIM");
                                                    $("#fieldRepType").text("DCSAIM");
                                                };
                                                var setDSOM = function(){
                                                    $("#fieldRepLabel").text("DSOM");
                                                    $("#fieldRepType").text("DSOM");
                                                };
                                                var setDOPRM = function(){
                                                    $("#fieldRepLabel").text("DOPRM");
                                                    $("#fieldRepType").text("DOPRM");
                                                };
                                                var setTechSpec = function(){
                                                    $("#fieldRepLabel").text("Technical Specialist");
                                                    $("#fieldRepType").text("TechSpec");
                                                };
                                                var setRASKM = function(){
                                                    $("#fieldRepLabel").text("RASKM");
                                                    $("#fieldRepType").text("RASKM");
                                                };
                                                YAHOO.log("Attaching show TMCA field reps dialog to links","info");
                                                <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                                                        htmlId="addDSMButton" dialogName="AddTMCAFieldRepDialog" extraMethod="setDSMVar"/>
                                                <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                                                        htmlId="addDCSAIMButton" dialogName="AddTMCAFieldRepDialog" extraMethod="setDCSAIM"/>
                                                <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                                                        htmlId="addDSOMButton" dialogName="AddTMCAFieldRepDialog" extraMethod="setDSOM"/>
                                                <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                                                        htmlId="addDOPRMButton" dialogName="AddTMCAFieldRepDialog" extraMethod="setDOPRM"/>
                                                <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                                                        htmlId="addTechSpecButton" dialogName="AddTMCAFieldRepDialog" extraMethod="setTechSpec"/>
                                                <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                                                        htmlId="addRASKMButton" dialogName="AddTMCAFieldRepDialog" extraMethod="setRASKM"/>
                                                YAHOO.log("Finished attaching show TMCA field reps dialog to links","info");

                                                YAHOO.log("Attaching delete TMCA field reps behaviour  to links..","info");
                                                $("a.deleteTMCARepLink").click(this.deleteTMCAFieldRep);
                                                YAHOO.log("Finished attaching delete TMCA field reps behaviour  to links.","info");
                                            },
                                            initUIState: function(){
                                                YAHOO.log("Initializing UI State for TMCA field representatives..", "info");
                                                <c:if test="${fn:length(allTMCAStaff)==0}">
                                                    $("#addDSMButton").hide();
                                                    $("#addDSOMButton").hide();
                                                    $("#addDCSAIMButton").hide();
                                                    $("#addDOPRMButton").hide();
                                                    $("#addTechSpecButton").hide();
                                                    $("#addRASKMButton").hide();
                                                </c:if>

                                                $("#deleteDSMButton").hide();
                                                $("#deleteDSOMButton").hide();
                                                $("#deleteDCSAIMButton").hide();
                                                $("#deleteDOPRMButton").hide();
                                                $("#deleteTechSpecButton").hide();
                                                $("#deleteRASKMButton").hide();
                                                YAHOO.log("Finished initializing UI State for TMCA field representatives..", "info");
                                            },
                                            addTMCAFieldRep: function(){
                                                    YAHOO.log("Adding TMCA field rep..","info");
                                                    var selectedType=$("#fieldRepType").text();
                                                    var selectedPersonName=$("#tmcaStaffSelectList option:selected").text();
                                                    var selectedPersonId=$("#tmcaStaffSelectList").val();

                                                    // Hide the add button
                                                    $("#add"+selectedType+"Button").hide();

                                                    // Show the remove button
                                                    $("#delete"+selectedType+"Button").show();

                                                    // show the person name in the appropriate column
                                                    $("#" + selectedType + "NameInput").val(selectedPersonName);

                                                    // set the foreign key in the appropriate hidden field
                                                    var fkId=selectedType+"FK";
                                                    $("input[type=hidden]#"+fkId).val(selectedPersonId);
                                                    YAHOO.log("Finished adding TMCA field rep..","info");
                                            },
                                            deleteTMCAFieldRep:function(event){
                                                    YAHOO.log("Deleting TMCA field rep..","info");
                                                    // Clear out the foreign key - which is used by the backend
                                                    $(this).closest("tr").find("input.fkField").val("");

                                                    // Clear out the displayed name
                                                    $(this).closest("tr").find("td.tmcaFieldRepColumn input[type=text]").val("");

                                                    // Show the add link
                                                    $(this).closest("tr").find(".addTMCARepLink").show();

                                                    // Hide the delete link
                                                    $(this).hide();

                                                    // Prevent default behaviour of link (navigate to other page)
                                                    YAHOO.util.Event.preventDefault(event);
                                                    YAHOO.log("Finished deleting TMCA field rep..","info");
                                            }
                                        };
                                    </script>
                            </c:if>
                        </nc:ifAccessAllowed>

                         <nc:ifAccessAllowed name="request.sampleDealer.weightsInfo">
                                <c:set var="allToyotaWeightGroups" value="${actionBean.allToyotaWeightGroupValues}" scope="page"/>
                                <c:set var="allLexusWeightGroups" value="${actionBean.allLexusWeightGroupValues}" scope="page"/>

                                <c:if test="${fn:length(allToyotaWeightGroups)>0 || fn:length(allLexusWeightGroups)>0}">
                                <fieldset id="weightGroupsSection">
                                    <legend><fmt:message key="dealer.tmcatab.section.weights.header"/></legend>

                                    <c:if test="${actionBean.showToyotaWeightGroups && fn:length(allToyotaWeightGroups)>0}">
                                            <nc:label name="dealer.weightsInfo.salesWeight" for="request.sampleDealer.weightsInfo.salesWeight.commonValueId"/>
                                            <nc:select id="request.sampleDealer.weightsInfo.salesWeight.commonValueId" name="request.sampleDealer.weightsInfo.salesWeight.commonValueId"
                                                       readOnlyValue="${actionBean.request.sampleDealer.weightsInfo.salesWeight.value}">
                                                <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                                <stripes:options-collection collection="${allToyotaWeightGroups}" value="commonValueId" label="value"/>
                                            </nc:select><br/>

                                            <nc:label name="dealer.weightsInfo.usedVehicleWeight" for="request.sampleDealer.weightsInfo.usedVehicleWeight.commonValueId"/>
                                            <nc:select id="request.sampleDealer.weightsInfo.usedVehicleWeight.commonValueId" name="request.sampleDealer.weightsInfo.usedVehicleWeight.commonValueId"
                                                    readOnlyValue="${actionBean.request.sampleDealer.weightsInfo.usedVehicleWeight.value}">
                                                <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                                <stripes:options-collection collection="${allToyotaWeightGroups}"
                                                                            value="commonValueId" label="value"/>
                                            </nc:select><br/>

                                            <nc:label name="dealer.weightsInfo.serviceWeight" for="request.sampleDealer.weightsInfo.serviceWeight.commonValueId"/>
                                            <nc:select id="request.sampleDealer.weightsInfo.serviceWeight.commonValueId" name="request.sampleDealer.weightsInfo.serviceWeight.commonValueId"
                                                    readOnlyValue="${actionBean.request.sampleDealer.weightsInfo.serviceWeight.value}">
                                                <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                                <stripes:options-collection collection="${allToyotaWeightGroups}" value="commonValueId" label="value"/>
                                            </nc:select><br/>

                                            <nc:label name="dealer.weightsInfo.partsWeight" for="request.sampleDealer.weightsInfo.partsWeight.commonValueId"/>
                                            <nc:select id="request.sampleDealer.weightsInfo.partsWeight.commonValueId" name="request.sampleDealer.weightsInfo.partsWeight.commonValueId"
                                                    readOnlyValue="${actionBean.request.sampleDealer.weightsInfo.partsWeight.value}">
                                                <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                                <stripes:options-collection collection="${allToyotaWeightGroups}" value="commonValueId" label="value"/>
                                            </nc:select><br/>

                                            <nc:label name="dealer.weightsInfo.accessoriesWeight" for="request.sampleDealer.weightsInfo.accessoriesWeight.commonValueId"/>
                                            <nc:select id="request.sampleDealer.weightsInfo.accessoriesWeight.commonValueId" name="request.sampleDealer.weightsInfo.accessoriesWeight.commonValueId"
                                                    readOnlyValue="${actionBean.request.sampleDealer.weightsInfo.accessoriesWeight.value}">
                                                <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                                <stripes:options-collection collection="${allToyotaWeightGroups}" value="commonValueId" label="value"/>
                                            </nc:select><br/>

                                            <nc:label name="dealer.weightsInfo.csiWeight" for="request.sampleDealer.weightsInfo.csiWeight.commonValueId"/>
                                            <nc:select id="request.sampleDealer.weightsInfo.csiWeight.commonValueId" name="request.sampleDealer.weightsInfo.csiWeight.commonValueId"
                                                    readOnlyValue="${actionBean.request.sampleDealer.weightsInfo.csiWeight.value}">
                                                <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                                <stripes:options-collection collection="${allToyotaWeightGroups}" value="commonValueId" label="value"/>
                                            </nc:select><br/>
                                    </c:if>
                                    <c:if test="${actionBean.showLexusWeightGroups && fn:length(allLexusWeightGroups) > 0}">
                                            <nc:label name="dealer.weightsInfo.lexusWeight" for="request.sampleDealer.weightsInfo.lexusWeight.commonValueId"/>
                                            <nc:select id="request.sampleDealer.weightsInfo.lexusWeight.commonValueId" name="request.sampleDealer.weightsInfo.lexusWeight.commonValueId"
                                                    readOnlyValue="${actionBean.request.sampleDealer.weightsInfo.lexusWeight.value}">
                                                <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                                <stripes:options-collection collection="${allLexusWeightGroups}" value="commonValueId" label="value"/>
                                            </nc:select>
                                    </c:if>
                                </fieldset>
                             </c:if>
                        </nc:ifAccessAllowed>

                         <nc:ifAccessAllowed name="request.sampleDealer.awards">
                                <c:set var="allAwardName" value="${actionBean.allAwardName}" scope="page"/>
                                <c:set var="allAwardLevel" value="${actionBean.allAwardLevel}" scope="page"/>
                                <c:if test="${fn:length(allAwardName)>0 && fn:length(allAwardLevel)>0}">
                                 <fieldset id="dealerAwardsSection" class="tableEncapsulatingFieldSet">
                                     <a href="" id="addAwardLink" class="addItemToTableLink">
                                        <fmt:message key="label.add"/>
                                     </a>
                                     <legend><fmt:message key="dealer.awardtab.section.award.header"/></legend>
                                     <table id="awardsTable">
                                         <thead>
                                         <tr>
                                             <th><fmt:message key="award.year"/></th>
                                             <th><fmt:message key="award.type"/></th>
                                             <th><fmt:message key="award.level"/></th>
                                             <th class="controlColumn">&nbsp;</th>
                                         </tr>
                                         </thead>
                                         <tbody>
                                         <c:forEach items="${actionBean.request.sampleDealer.awards}" var="award" varStatus="awardStatus">
                                             <tr class="itemRow">
                                                 <td>
                                                     <stripes:text name="request.sampleDealer.awards[${awardStatus.index}].yearWon" readonly="true"
                                                                   class="awardYearField"/>
                                                 </td>
                                                 <td>
                                                     <stripes:hidden name="request.sampleDealer.awards[${awardStatus.index}].name.commonValueId"
                                                                     class="awardTypeIdField"/>
                                                     <stripes:text name="request.sampleDealer.awards[${awardStatus.index}].name.value" readonly="true"
                                                                   class="awardTypeLabelField"/>
                                                 </td>
                                                 <td>
                                                     <stripes:hidden name="request.sampleDealer.awards[${awardStatus.index}].awardLevel.commonValueId"
                                                                     class="awardLevelIdField"/>
                                                     <stripes:text name="request.sampleDealer.awards[${awardStatus.index}].awardLevel.value"
                                                                   readonly="true" class="awardLevelLabelField"/>
                                                 </td>
                                                 <td class="controlColumn">
                                                     <stripes:hidden name="request.sampleDealer.awards[${awardStatus.index}].removedFromDealer"
                                                                     class="removeFlagField"/>
                                                     <a href="" class="editLink"><fmt:message key="label.edit"/></a>
                                                     <a href="" class="deleteLink"><fmt:message key="label.remove"/></a>
                                                 </td>
                                             </tr>
                                         </c:forEach>
                                         </tbody>
                                     </table>
                                 </fieldset>
                                    <!--
                                    Dialog for adding/editing award
                                    -->
                                    <div id="addAwardDialog" class="dialog">
                                        <div class="hd"><fmt:message key="label.add"/> <fmt:message key="dealer.awards"/></div>
                                        <div class="bd">
                                                <%-- used for editing existing award. If this field is populated, it means we are editing an existing award --%>
                                            <input type="hidden" id="awardRowBeingEdited" name="awardRowBeingEdited"/>

                                            <label for="awardType"><fmt:message key="award.type"/></label>
                                            <select id="awardType" name="awardType">
                                                <c:forEach items="${allAwardName}" var="awardName">
                                                    <option value="${awardName.commonValueId}">${awardName.value}</option>
                                                </c:forEach>
                                            </select><br/>

                                            <label for="awardYear"><fmt:message key="award.year"/></label>
                                            <input type="text" name="awardYear" id="awardYear"/><br/>

                                            <label for="awardLevel"><fmt:message key="award.level"/></label>
                                            <select id="awardLevel" name="awardLevel">
                                                <c:forEach items="${allAwardLevel}" var="awardLevel">
                                                    <option value="${awardLevel.commonValueId}">${awardLevel.value}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>

                                    <!--
                                      Javascripts for DealerAwards
                                    -->
                                    <script type="text/javascript">
                                        /**
                                         *  Handler for Dealer Award functionalities
                                         * Call initAll() method to do all initialization.
                                         */
                                        var DealerAwardHandler ={
                                            initAll: function(){
                                                this.prepareComponents();
                                                this.initEventHandling();
                                                this.initUIState();
                                            },
                                            prepareComponents:function(){
                                                                  YAHOO.log("Creating dealer award dialog box","info");
                                                                  <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                                                                        dialogName="AddAwardDialog" dialogId="addAwardDialog" okHandler="DealerAwardHandler.addUpdateAward"/>
                                                                   YAHOO.log("Finished creating dealer award dialog box","info");
                                                                },
                                            initEventHandling:function(){
                                                                YAHOO.log("Initializing event handling for dealer award functionality","info");
                                                                var clearAwardsDialogForAdding = function(){
                                                                   YAHOO.log("Clearning awards dialog","info");
                                                                   $("#awardRowBeingEdited,#awardYear,#awardType,#awardLevel").val("");
                                                                };
                                                                <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                                                                        htmlId="addAwardLink" dialogName="AddAwardDialog" extraMethod="clearAwardsDialogForAdding"/>

                                                                 YAHOO.log("Attaching edit dealer award functionality","info");
                                                                attachTableColumnEditBehaviour($("table#awardsTable a.editLink"), this.editAward);

                                                                YAHOO.log("Attaching delete dealer award functionality","info");
                                                                attachDeleteBehaviourWithFlagField($("table#awardsTable a.deleteLink"));

                                                                YAHOO.log("Finished initializing event handling for dealer award functionality","info");
                                                            },
                                            initUIState:function(){
                                                                YAHOO.log("Finished initializing add dealer award functionality ","info");
                                                            },
                                            editAward:    function(editedAwardRow, event){
                                                                $("#awardRowBeingEdited").val(editedAwardRow.attr('rowIndex')-1); // html table rows start from 1

                                                                YAHOO.log("Editing award " + $("#awardRowBeingEdited").val(), "info");
                                                                 $("#awardYear").val(editedAwardRow.find(".awardYearField").val());
                                                                 $("#awardType").val(editedAwardRow.find(".awardTypeIdField").val());
                                                                 $("#awardLevel").val(editedAwardRow.find(".awardLevelIdField").val());

                                                                YAHOO.au.com.toyota.widget.AddAwardDialog.show();
                                                            },
                                            addUpdateAward:    function(){
                                                                var editedRowIndex = $("#awardRowBeingEdited").val();
                                                                var isEditing = (editedRowIndex != "");

                                                                var newIndex = $("table#awardsTable tbody tr").length;
                                                                var awardYearValue = $("#awardYear").val();
                                                                var awardTypeValueId = $("#awardType").val();
                                                                var awardTypeLabel = $("#awardType option:selected").text();
                                                                var awardLevelValueId = $("#awardLevel").val();
                                                                var awardLevelLabel = $("#awardLevel option:selected").text();

                                                                if (isEditing) {
                                                                    YAHOO.log("Editing existing award", "info");
                                                                    var rowBeingEdited = $($("table#awardsTable tbody tr")[editedRowIndex]);
                                                                    rowBeingEdited.find(".awardYearField").val(awardYearValue);
                                                                    rowBeingEdited.find(".awardTypeIdField").val(awardTypeValueId);
                                                                    rowBeingEdited.find(".awardTypeLabelField").val(awardTypeLabel);
                                                                    rowBeingEdited.find(".awardLevelIdField").val(awardLevelValueId);
                                                                    rowBeingEdited.find(".awardLevelLabelField").val(awardLevelLabel);
                                                                } else {
                                                                    YAHOO.log("Adding new award", "info");
                                                                    $("<tr class='itemRow'>" +
                                                                      "<td>" +
                                                                      "<input type='text' name='request.sampleDealer.awards[" + newIndex + "].yearWon' readonly='readonly' class='awardYearField' value='" + awardYearValue + "'/>" +
                                                                      "</td>" +
                                                                      "<td>" +
                                                                      "<input type='hidden' name='request.sampleDealer.awards[" + newIndex + "].name.commonValueId' class='awardTypeIdField' value='" + awardTypeValueId + "'/>" +
                                                                      "<input type='text' name='request.sampleDealer.awards[" + newIndex + "].name.value' readonly='readonly' class='awardTypeLabelField' value='" + awardTypeLabel + "'/>" +
                                                                      "</td>" +
                                                                      "<td>" +
                                                                      "<input type='hidden' name='request.sampleDealer.awards[" + newIndex + "].awardLevel.commonValueId' class='awardLevelIdField' value='" + awardLevelValueId + "'/>" +
                                                                      "<input type='text' name='request.sampleDealer.awards[" + newIndex + "].awardLevel.value' readonly='readonly' class='awardLevelLabelField' value='" + awardLevelLabel + "'/>" +
                                                                      "</td>" +
                                                                      "<td  class='controlColumn'>" +
                                                                      "<input type='hidden' name='request.sampleDealer.awards[" + newIndex + "].removedFromDealer' class='removeFlagField'/>" +
                                                                      "<a href='' class='editLink'><fmt:message key='label.edit'/></a>" +
                                                                      "<a href='' class='deleteLink'><fmt:message key='label.remove'/></a>" +
                                                                      "</td>" +
                                                                      "</tr>"
                                                                            ).appendTo($("table#awardsTable tbody"));

                                                                    YAHOO.log("Attaching delete behaviour for 'awards' ", "info");
                                                                    attachDeleteBehaviourWithFlagField($("table#awardsTable tr:last-child a.deleteLink"));

                                                                    YAHOO.log("Attaching edit behaviour for 'awards' ", "info");
                                                                    attachTableColumnEditBehaviour($("table#awardsTable tr:last-child a.editLink"), this.editAward);
                                                                }
                                                  }
                                        };
                                    </script>
                                </c:if>
                         </nc:ifAccessAllowed>
                        </div>

                        <div id="bulkUpdateNavButtons">
                            <stripes:submit name="showConfirmation" id="showConfirmationButton"><fmt:message key="label.updateAll"/></stripes:submit>
                        </div>
                        
                        <c:if test="${actionBean.showConfirmation eq true}">
							<input id="showConfirmationFlag" type="hidden" value="true" />
						</c:if>
					
						<div id="openConfirmationDialog" class="dialog dialogWithDefaultCloseButton">
							<div class="hd">Warning</div>
							<div class="bd">
									<p>
										You have changed one or more fields on this screen. <br/>
										Please confirm that you want to save the changes.
									</p>
								<stripes:submit name="performBulkUpdate" id="updateButton" class="btn btn_ok" onclick="disableButton('updateButton');" />
									
								<input id="confirmationDialogCloseButton" type="button" class="btn btn_cancel" onclick="closeDialog();" />
							</div>
						</div>
					
                    </stripes:form>
                </div>
            </div>


    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">
        <script type="text/javascript">

            function yuiLoadComplete() {
                YAHOO.util.Event.onDOMReady(function() {
                    <nc:ifAccessAllowed name="request.sampleDealer.weightsInfo">
                        <c:if test="${fn:length(allTMCAStaff)>0}">
                            TMCAFieldRepHandler.initAll();
                        </c:if>
                    </nc:ifAccessAllowed>
                    <nc:ifAccessAllowed name="request.sampleDealer.awards">
                        <c:if test="${fn:length(allAwardName)>0 && fn:length(allAwardLevel)>0}">
                            DealerAwardHandler.initAll();
                        </c:if>
                    </nc:ifAccessAllowed>
                    
                    var flagElem = $('#showConfirmationFlag');
        			if (flagElem && flagElem.val() == 'true'){
        				openConfirmationDialogBox();
        			}
                });
            }
            
            function closeDialog() {
    			YAHOO.au.com.toyota.widget.openConfirmationDialog.hide();
    		}
            
            function openConfirmationDialogBox() {
				YAHOO.au.com.toyota.widget.openConfirmationDialog.show();
			}
            
            var openConfirmationDialog = {
	                initDialog : function(){
	                   <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp" dialogName="openConfirmationDialog" dialogId="openConfirmationDialog" noButtons="true" />
	                }
	            };

	        dialogs.add(openConfirmationDialog);
	        
        </script>
    </stripes:layout-component>

</stripes:layout-render>