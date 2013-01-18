<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <%-- ==========================================
    Secure page stuffs
    =============================================--%>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

      <nc:ifAccessAllowed name="dealer.generalInfo.corporateInfo">
        <ul class="column-style-fieldset oneCol">
            <li>
                   <fieldset id="generalInfo-corporateSection">
                  <legend class="legend"><fmt:message  key="dealer.generaltab.section.corporate.header"/></legend>
                    <nc:label name="position.dpGmr" for="dealer.principalLocation.dpGmrAppointment.person.fullName"/>
                    <c:if test="${actionBean.dealer.dpGmrAppointment ne null}">
                        <nc:text id="dealer.principalLocation.dpGmrAppointment.person.fullName" name="dealer.principalLocation.dpGmrAppointment.person.fullName"/>
                        <span class="formValue" id="dealer.dpGmrAppointment.position.description">(<c:out value="${actionBean.dealer.dpGmrAppointment.position.description}"/>)</span>
                    </c:if>
                    <br/>

                     <nc:ifAccessAllowed name="dealer.generalInfo.operatingEntity">
                            <nc:label name="operatingEntity.name" for="dealer.generalInfo.operatingEntity.id"/>
                            <nc:hidden id="dealer.generalInfo.operatingEntity.id" name="dealer.generalInfo.operatingEntity.id"/>
                            <nc:text id="dealer.generalInfo.operatingEntity.name" name="dealer.generalInfo.operatingEntity.name" readonly="true" class="readonly"/>
                            <nc:ifWriteAccessAllowed name="dealer.generalInfo.operatingEntity.id">
                                <a href="" id="addOperatingEntityButton"><fmt:message key="label.add"/></a>
                                <a href="" id="removeOperatingEntityButton"><fmt:message key="label.remove"/></a>
                            </nc:ifWriteAccessAllowed><br/>

                            <nc:label name="operatingEntity.abn" for="dealer.generalInfo.operatingEntity.abn"/>
                            <nc:text id="dealer.generalInfo.operatingEntity.abn" name="dealer.generalInfo.operatingEntity.abn" readonly="true" class="readonly"/><br/>
        
                            <nc:label name="operatingEntity.acn" for="dealer.generalInfo.operatingEntity.acn"/>
                            <nc:text id="dealer.generalInfo.operatingEntity.acn" name="dealer.generalInfo.operatingEntity.acn" readonly="true" class="readonly"/><br/>

                             <nc:label name="label.companyStructure" for="dealer.generalInfo.operatingEntity.companyStructure"/>
                            <nc:text id="dealer.generalInfo.operatingEntity.companyStructure" name="dealer.generalInfo.operatingEntity.companyStructure" readonly="true" class="readonly"/><br/>
                    </nc:ifAccessAllowed>


                    <nc:ifAccessAllowed name="dealer.generalInfo.group">
                              <nc:label name="group.name"  for="dealer.generalInfo.group.groupId"/>
                              <nc:hidden id="dealer.generalInfo.group.groupId" name="dealer.generalInfo.group.groupId"/>
                              <nc:text name="dealer.generalInfo.group.name" id="dealer.generalInfo.group.name" readonly="true" class="readonly"/>
                              <nc:ifWriteAccessAllowed name="dealer.generalInfo.group.groupId">
                                  <a href="" id="addGroupButton"><fmt:message key="label.add"/></a>
                                  <a href="" id="removeGroupButton"><fmt:message key="label.remove"/></a>
                              </nc:ifWriteAccessAllowed>
                      </nc:ifAccessAllowed>
                </fieldset>
            </li>
        </ul>


        <nc:ifWriteAccessAllowed name="dealer.generalInfo.group">
             <!-- ============== Start Add Group Dialog ================== -->
             <div id="addGroupDialog" class="dialog">
                 <div class="hd"><fmt:message key="label.add"/> <fmt:message key="group"/></div>
                 <div class="bd">
                     <label for="selectGroupList"><fmt:message key="group"/></label>
                     <select id="selectGroupList">
                         <c:forEach items="${actionBean.allActiveGroups}" var="group">
                             <option value="${group.groupId}">${group.name}</option>
                         </c:forEach>
                     </select>
                 </div>
             </div>
            <!-- ============== End Add Group Dialog ================== -->
            <script type="text/javascript">
                function initializeGroupFunctionality(){
                    var GroupCommandObject = {
                        handleAdd: function(){
                            var selectedGroupLabel=$("#selectGroupList option:selected").text();
                            var selectedGroupId=$("#selectGroupList").val();

                            $("#addGroupButton").hide();
                            $("#removeGroupButton").show();

                            $("#dealer\\.generalInfo\\.group\\.groupId").val(selectedGroupId)
                            $("#dealer\\.generalInfo\\.group\\.name").val(selectedGroupLabel)
                        },
                        handleRemove: function(){
                            $("#dealer\\.generalInfo\\.group\\.name").val("");
                            $("#dealer\\.generalInfo\\.group\\.groupId").val("");

                            $("#addGroupButton").show();
                            $("#removeGroupButton").hide();
                        }
                    }

                    YAHOO.log("Creating group dialog","info");
                    <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                         dialogName="GroupDialog" dialogId="addGroupDialog" okHandler="GroupCommandObject.handleAdd"/>

                    YAHOO.log("Attaching add group behaviour","info");
                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                        htmlId="addGroupButton" dialogName="GroupDialog"/>

                    $("#removeGroupButton").click(function(event){
                        GroupCommandObject.handleRemove();
                        YAHOO.util.Event.preventDefault(event);
                    });

                    <c:if test="${actionBean.dealer.generalInfo.group ne null || fn:length(actionBean.allActiveGroups)==0}">
                        $("#addGroupButton").hide();
                    </c:if>
                    <c:if test="${actionBean.dealer.generalInfo.group eq null}">
                        $("#removeGroupButton").hide();
                    </c:if>
                }
            </script>
         </nc:ifWriteAccessAllowed>



        <nc:ifWriteAccessAllowed name="dealer.generalInfo.operatingEntity">
            <!-- ============== Start Add Operating Entity  Dialog ================== -->
                <c:set var="allActiveCompany" value="${actionBean.allCompany}"/>
                <div id="addOperatingEntityDialog" class="dialog">
                    <div class="hd"><fmt:message key="label.add"/> <fmt:message key="operatingEntity"/></div>
                    <div class="bd">
                        <label for="selectOperatingEntityList"><fmt:message key="operatingEntity"/></label>
                        <select id="selectOperatingEntityList">
                            <c:forEach items="${allActiveCompany}" var="company">
                                <option value="${company.id}">${company.name}</option>
                            </c:forEach>
                        </select><br/>


                        <label for="operatingEntity.abn"><fmt:message key="operatingEntity.abn"/></label>
                        <span id="operatingEntity.abn" class="formValue"></span><br/>

                        <label for="operatingEntity.acn"><fmt:message key="operatingEntity.acn"/></label>
                        <span id="operatingEntity.acn" class="formValue"></span><br/>

                         <label for="operatingEntity.companyStructure"><fmt:message key="label.companyStructure"/></label>
                        <span id="operatingEntity.companyStructure" class="formValue"></span><br/>
                    </div>
                </div>
            <!-- ============== End Add Operating Entity Dialog ================== -->
            <script type="text/javascript">
                      var companyABN = new Array(<c:out value="${fn:length(allActiveCompany)}"/>);
                     var companyACN = new Array(<c:out value="${fn:length(allActiveCompany)}"/>);
                     var companyStructure = new Array(<c:out value="${fn:length(allActiveCompany)}"/>);

                    <c:forEach items="${allActiveCompany}" var="company">
                            companyABN[${company.id}]="${company.abn}";
                            companyACN[${company.id}]="${company.acn}";
                            companyStructure[${company.id}]="${company.companyStructure}";
                    </c:forEach>

                        function displayOperatingEntityDetails(){
                            YAHOO.log("Changing operating entity details","info");
                           $("#operatingEntity\\.abn").text(companyABN[$("#selectOperatingEntityList").val()]);
                            $("#operatingEntity\\.acn").text(companyACN[$("#selectOperatingEntityList").val()]);
                            $("#operatingEntity\\.companyStructure").text(companyStructure[$("#selectOperatingEntityList").val()]);
                        }

                        function initializeOperatingEntityFunctionality(){
                                    var OperatingEntityCommandObject = {
                                        handleAdd: function(){
                                                var selectedOELabel=$("#selectOperatingEntityList option:selected").text();
                                                var selectedOEId=$("#selectOperatingEntityList").val();

                                                $("#addOperatingEntityButton").hide();
                                                $("#removeOperatingEntityButton").show();

                                                $("#dealer\\.generalInfo\\.operatingEntity\\.id").val(selectedOEId);
                                                $("#dealer\\.generalInfo\\.operatingEntity\\.name").val(selectedOELabel);
                                                $("#dealer\\.generalInfo\\.operatingEntity\\.abn").val($("#operatingEntity\\.abn").text());
                                                $("#dealer\\.generalInfo\\.operatingEntity\\.acn").val($("#operatingEntity\\.acn").text());
                                                $("#dealer\\.generalInfo\\.operatingEntity\\.companyStructure").val($("#operatingEntity\\.companyStructure").text());
                                        },
                                        handleRemove: function(){
                                                $("#dealer\\.generalInfo\\.operatingEntity\\.name").val("");
                                                $("#dealer\\.generalInfo\\.operatingEntity\\.id").val("");
                                                $("#dealer\\.generalInfo\\.operatingEntity\\.abn").val("");
                                                $("#dealer\\.generalInfo\\.operatingEntity\\.acn").val("");
                                                $("#dealer\\.generalInfo\\.operatingEntity\\.companyStructure").val("");

                                                $("#addOperatingEntityButton").show();
                                                $("#removeOperatingEntityButton").hide();
                                        }
                                    }

                                    YAHOO.log("Creating operating entity dialog","info");
                                    <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                                            dialogName="OperatingEntityDialog" dialogId="addOperatingEntityDialog" okHandler="OperatingEntityCommandObject.handleAdd"/>

                                    YAHOO.log("Attaching add operating entity behaviour","info");
                                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                                                    htmlId="addOperatingEntityButton" dialogName="OperatingEntityDialog" extraMethod="displayOperatingEntityDetails"/>

                                    YAHOO.log("Attaching change operating entity behaviour, to display detailed oe information","info");
                                    $("#selectOperatingEntityList").change(function(){
                                            displayOperatingEntityDetails();
                                    });

                                    YAHOO.log("Attaching remove operating entity behaviour","info");
                                    $("#removeOperatingEntityButton").click(function(event){
                                        OperatingEntityCommandObject.handleRemove();
                                        YAHOO.util.Event.preventDefault(event);
                                    });


                                    <c:if test="${actionBean.dealer.generalInfo.operatingEntity ne null || fn:length(allActiveCompany)==0}">
                                        $("#addOperatingEntityButton").hide();
                                    </c:if>
                                    <c:if test="${actionBean.dealer.generalInfo.operatingEntity eq null}">
                                        $("#removeOperatingEntityButton").hide();
                                    </c:if>
                        }
            </script>
        </nc:ifWriteAccessAllowed>
    </nc:ifAccessAllowed>


        <script type="text/javascript">
                function ${initializeCorporateInfoFunctionName}(){
                    <nc:ifWriteAccessAllowed name="dealer.generalInfo.group">
                            initializeGroupFunctionality();
                    </nc:ifWriteAccessAllowed>
                    <nc:ifWriteAccessAllowed name="dealer.generalInfo.operatingEntity">
                            initializeOperatingEntityFunctionality();
                    </nc:ifWriteAccessAllowed>
                }
        </script>





</stripes:layout-definition>