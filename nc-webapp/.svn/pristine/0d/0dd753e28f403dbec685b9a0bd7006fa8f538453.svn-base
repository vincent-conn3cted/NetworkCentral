<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <%-- ==========================================
                    Secure page stuffs
     =============================================--%>
    <nc:pageName pageName="${pageName}"/>
     <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
        
        <li>
        <fieldset id="tmcaInfo-representativesSection" class="twocols">
                <legend><fmt:message  key="dealer.businessPartnersInfo.tmcaFieldRep"/></legend>
                <table id="representativesTable">
                    <tbody>
                    <tr>
                        <%--
                            Here we have two FK fields, one is rendered as a span, and the other is rendered as input.
                            - The span FK is used for retrieving the TMCA Field Rep info, and to display in dialog box
                            - The input field is used for setting the TMCA field rep (saving in DB)

                            The reason of this separation is:
                            1. We dont want the FK to be rendered at all (even as a hidden field) - when user is only allowed to view the TMCA field rep.
                                  But.. .we still need a way to access the FK to display the TMCA field rep info, hence the span.
                            2. We still need the FK to be rendered as input field, for setting new field rep, hence the hidden input.
                        --%>
                        <td><span class="formLabel"><fmt:message  key="dealer.businessPartnersInfo.dsmStaff"/></span></td>
                        <td id="DSMColumn" class="tmcaFieldRepColumn">
                            <nc:text id="DSMNameInput" name="dealer.businessPartnersInfo.dsmStaff.fullName" readonly="true" class="readonly"/>
                            <span id="DSMFKSpan" style="display:none" class="fkField">${actionBean.dealer.businessPartnersInfo.dsmStaff.personId}</span>
                        </td>
                        <nc:ifWriteAccessAllowed name="dealer.businessPartnersInfo.dsmStaff.personId">
                            <td>
                                <stripes:hidden id="DSMFK" name="dealer.businessPartnersInfo.dsmStaff.personId" class="fkField"/>
                                <stripes:hidden id="DSMRemoveFlagField" name="dealer.businessPartnersInfo.removeDSMStaff" class="removeFlagField"/>
                            </td>
                            <td><a href="" id="addDSMButton" class="addTMCARepLink"><fmt:message key="label.add"/></a></td>
                            <td><a href="" id="deleteDSMButton" class="deleteTMCARepLink"><fmt:message key="label.remove"/></a></td>
                        </nc:ifWriteAccessAllowed>
                    </tr>
                    <tr>
                        <td><span class="formLabel"><fmt:message  key="dealer.businessPartnersInfo.dsomStaff"/></span></td>
                        <td id="DSOMColumn" class="tmcaFieldRepColumn">
                            <nc:text id="DSOMNameInput" name="dealer.businessPartnersInfo.dsomStaff.fullName" readonly="true" class="readonly"/>
                            <span id="DSOMFKSpan" style="display:none" class="fkField">${actionBean.dealer.businessPartnersInfo.dsomStaff.personId}</span>
                        </td>
                        <nc:ifWriteAccessAllowed name="dealer.businessPartnersInfo.dsomStaff.personId">
                            <td>
                                <stripes:hidden id="DSOMFK" name="dealer.businessPartnersInfo.dsomStaff.personId" class="fkField"/>
                                <stripes:hidden id="DSOMRemoveFlagField" name="dealer.businessPartnersInfo.removeDSOMStaff" class="removeFlagField"/>
                            </td>
                            <td><a href="" id="addDSOMButton" class="addTMCARepLink"><fmt:message key="label.add"/></a></td>
                            <td><a href="" id="deleteDSOMButton" class="deleteTMCARepLink"><fmt:message key="label.remove"/></a></td>
                        </nc:ifWriteAccessAllowed>
                    </tr>
                    <tr>
                        <td><span class="formLabel"><fmt:message  key="dealer.businessPartnersInfo.dcsaimStaff"/></span></td>
                        <td id="DCSAIMColumn" class="tmcaFieldRepColumn">
                            <nc:text id="DCSAIMNameInput" name="dealer.businessPartnersInfo.dcsaimStaff.fullName" readonly="true" class="readonly"/>
                            <span id="DCSAIMFKSpan" style="display:none" class="fkField">${actionBean.dealer.businessPartnersInfo.dcsaimStaff.personId}</span>
                        </td>
                        <nc:ifWriteAccessAllowed name="dealer.businessPartnersInfo.dcsaimStaff.personId">
                            <td>
                                <stripes:hidden id="DCSAIMFK" name="dealer.businessPartnersInfo.dcsaimStaff.personId" class="fkField"/>
                                <stripes:hidden id="DCSAIMRemoveFlagField" name="dealer.businessPartnersInfo.removeDCSAIMStaff" class="removeFlagField"/>
                            </td>
                            <td><a href="" id="addDCSAIMButton" class="addTMCARepLink"><fmt:message key="label.add"/></a></td>
                            <td><a href="" id="deleteDCSAIMButton" class="deleteTMCARepLink"><fmt:message key="label.remove"/></a></td>
                        </nc:ifWriteAccessAllowed>
                    </tr>
                    <tr>
                        <td><span class="formLabel"><fmt:message  key="dealer.businessPartnersInfo.doprmStaff"/></span></td>
                        <td id="DOPRMColumn" class="tmcaFieldRepColumn">
                            <nc:text id="DOPRMNameInput" name="dealer.businessPartnersInfo.doprmStaff.fullName" readonly="true" class="readonly"/>
                            <span id="DOPRMFKSpan" style="display:none" class="fkField">${actionBean.dealer.businessPartnersInfo.doprmStaff.personId}</span>
                        </td>
                        <nc:ifWriteAccessAllowed name="dealer.businessPartnersInfo.doprmStaff.personId">
                            <td>
                                <stripes:hidden id="DOPRMFK" name="dealer.businessPartnersInfo.doprmStaff.personId" class="fkField"/>
                                <stripes:hidden id="DOPRMRemoveFlagField" name="dealer.businessPartnersInfo.removeDOPRMStaff" class="removeFlagField"/>
                            </td>
                            <td><a href="" id="addDOPRMButton" class="addTMCARepLink"><fmt:message key="label.add"/></a></td>
                            <td><a href="" id="deleteDOPRMButton" class="deleteTMCARepLink"><fmt:message key="label.remove"/></a></td>
                        </nc:ifWriteAccessAllowed>
                    </tr>
                    <tr>
                        <td><span class="formLabel"><fmt:message  key="dealer.businessPartnersInfo.technicalSpecialistStaff"/></span></td>
                        <td id="TechSpecColumn" class="tmcaFieldRepColumn">
                            <nc:text id="TechSpecNameInput" name="dealer.businessPartnersInfo.technicalSpecialistStaff.fullName" readonly="true" class="readonly"/>
                            <span id="TechSpecFKSpan" style="display:none" class="fkField">${actionBean.dealer.businessPartnersInfo.technicalSpecialistStaff.personId}</span>
                        </td>
                        <nc:ifWriteAccessAllowed name="dealer.businessPartnersInfo.technicalSpecialistStaff.personId">
                                <td>
                                    <stripes:hidden id="TechSpecFK" name="dealer.businessPartnersInfo.technicalSpecialistStaff.personId" class="fkField"/>
                                    <stripes:hidden id="TechSpecRemoveFlagField" name="dealer.businessPartnersInfo.removeTechnicalSpecialistStaff" class="removeFlagField"/>
                                </td>
                                <td><a href="" id="addTechSpecButton" class="addTMCARepLink"><fmt:message key="label.add"/></a></td>
                                <td><a href="" id="deleteTechSpecButton" class="deleteTMCARepLink"><fmt:message key="label.remove"/></a></td>
                        </nc:ifWriteAccessAllowed>
                    </tr>
                      <tr>
                        <td><span class="formLabel"><fmt:message  key="dealer.businessPartnersInfo.raskmStaff"/></span></td>
                        <td id="RASKMColumn" class="tmcaFieldRepColumn">
                            <nc:text id="RASKMNameInput" name="dealer.businessPartnersInfo.raskmStaff.fullName" readonly="true" class="readonly"/>
                            <span id="RASKMFKSpan" style="display:none" class="fkField">${actionBean.dealer.businessPartnersInfo.raskmStaff.personId}</span>
                        </td>
                          <nc:ifWriteAccessAllowed name="dealer.businessPartnersInfo.raskmStaff.personId">
                                <td>
                                    <stripes:hidden id="RASKMFK" name="dealer.businessPartnersInfo.raskmStaff.personId" class="fkField"/>
                                    <stripes:hidden id="RASKMRemoveFlagField" name="dealer.businessPartnersInfo.removeRASKMStaff" class="removeFlagField"/>
                                </td>
                                <td><a href="" id="addRASKMButton" class="addTMCARepLink"><fmt:message key="label.add"/></a></td>
                                <td><a href="" id="deleteRASKMButton" class="deleteTMCARepLink"><fmt:message key="label.remove"/></a></td>
                          </nc:ifWriteAccessAllowed>
                    </tr>
                    </tbody>
                </table>
            </fieldset>
        </li>

        <nc:ifWriteAccessAllowed name="dealer.tmcafieldreps">
             <div id="addTMCAFieldRepDialog" class="dialog" style="width: 30em">
                <div class="hd"><fmt:message key="label.add"/><fmt:message  key="dealer.businessPartnersInfo.tmcaFieldRep"/></div>
                <div class="bd">
                    Add <span id="fieldRepLabel"></span> Staff
                    <%--
                        NOTE: this element (fieldRepType) is used by the javascript to determine the appropriate TMCA field.
                        Modify the id carefully!
                    --%>
                    <span id="fieldRepType" style="display:none"></span>
                    <select id="tmcaStaffSelectList">
                        <c:forEach items="${actionBean.allTMCAStaff}" var="tmcaStaff">
                            <option value="${tmcaStaff.personId}">${tmcaStaff.fullName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <script type="text/javascript">
                        function ${initializeTMCAFieldRepFunctionName}(){
                                        var addSelectedTMCAFieldRep = function(){
                                            var selectedType=$("#fieldRepType").text();
                                            var selectedPersonName=$("#tmcaStaffSelectList option:selected").text();
                                            var selectedPersonId=$("#tmcaStaffSelectList").val();

                                            // Hide the add button
                                            $("#add"+selectedType+"Button").hide();

                                            // Show the remove button
                                            $("#delete"+selectedType+"Button").show();

                                            // show the person name in the appropriate column
                                            /*var columnId=selectedType+"Column";
                                            $("table#representativesTable td#"+columnId).text(selectedPersonName);*/
                                            $("#" + selectedType + "NameInput").val(selectedPersonName);

                                            // set the foreign key in the appropriate hidden field
                                            var fkId=selectedType+"FK";
                                            $("input[type=hidden]#"+fkId).val(selectedPersonId);
                                            $("#" + fkId + "Span").text(selectedPersonId);
                                            $("input[type=hidden]#"+selectedType+"RemoveFlagField").val("");
                                        };
                                        <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                                                dialogName="AddTMCAFieldRepDialog"
                                                dialogId="addTMCAFieldRepDialog"
                                                okHandler="addSelectedTMCAFieldRep"/>

                                         // Set both the label and the type. The type is used by the javascript to determine which staff to set
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


                           $("a.deleteTMCARepLink").each(function() {
                                attachDeleteTMCAFieldRepBehaviour($(this));
                            });
                            initializeTMCAFieldRepresentativeButtons();
                    }


                     function initializeTMCAFieldRepresentativeButtons(){
                        <c:if test="${fn:length(actionBean.allTMCAStaff) > 0}">
                            <nc:ifWriteAccessAllowed name="dealer.businessPartnersInfo.dsmStaff.personId">
                                    <c:if test="${actionBean.dealer.businessPartnersInfo.dsmStaff != null}">
                                        $("#addDSMButton").hide();
                                    </c:if>
                                    <c:if test="${actionBean.dealer.businessPartnersInfo.dsmStaff == null}">
                                        $("#deleteDSMButton").hide();
                                    </c:if>
                            </nc:ifWriteAccessAllowed>

                            <nc:ifWriteAccessAllowed name="dealer.businessPartnersInfo.dsomStaff.personId">
                                    <c:if test="${actionBean.dealer.businessPartnersInfo.dsomStaff != null}">
                                        $("#addDSOMButton").hide();
                                    </c:if>
                                    <c:if test="${actionBean.dealer.businessPartnersInfo.dsomStaff == null}">
                                        $("#deleteDSOMButton").hide();
                                    </c:if>
                            </nc:ifWriteAccessAllowed>


                            <nc:ifWriteAccessAllowed name="dealer.businessPartnersInfo.dcsaimStaff.personId">
                                    <c:if test="${actionBean.dealer.businessPartnersInfo.dcsaimStaff != null}">
                                        $("#addDCSAIMButton").hide();
                                    </c:if>
                                    <c:if test="${actionBean.dealer.businessPartnersInfo.dcsaimStaff == null}">
                                        $("#deleteDCSAIMButton").hide();
                                    </c:if>
                            </nc:ifWriteAccessAllowed>


                            <nc:ifWriteAccessAllowed name="dealer.businessPartnersInfo.doprmStaff.personId">
                                    <c:if test="${actionBean.dealer.businessPartnersInfo.doprmStaff != null}">
                                        $("#addDOPRMButton").hide();
                                    </c:if>
                                    <c:if test="${actionBean.dealer.businessPartnersInfo.doprmStaff == null}">
                                        $("#deleteDOPRMButton").hide();
                                    </c:if>
                            </nc:ifWriteAccessAllowed>


                            <nc:ifWriteAccessAllowed name="dealer.businessPartnersInfo.technicalSpecialistStaff.personId">
                                    <c:if test="${actionBean.dealer.businessPartnersInfo.technicalSpecialistStaff != null}">
                                        $("#addTechSpecButton").hide();
                                    </c:if>
                                    <c:if test="${actionBean.dealer.businessPartnersInfo.technicalSpecialistStaff == null}">
                                        $("#deleteTechSpecButton").hide();
                                    </c:if>
                            </nc:ifWriteAccessAllowed>

                            <nc:ifWriteAccessAllowed name="dealer.businessPartnersInfo.raskmStaff.personId">
                                    <c:if test="${actionBean.dealer.businessPartnersInfo.raskmStaff != null}">
                                        $("#addRASKMButton").hide();
                                    </c:if>
                                    <c:if test="${actionBean.dealer.businessPartnersInfo.raskmStaff == null}">
                                        $("#deleteRASKMButton").hide();
                                    </c:if>
                            </nc:ifWriteAccessAllowed>
                         </c:if>


                         <c:if test="${fn:length(actionBean.allTMCAStaff) == 0}">
                             $(["a.addTMCARepLink","a.deleteTMCARepLink"]).each(function(){
                               $(""+this).hide();
                             });
                         </c:if>
                    }

                    function attachDeleteTMCAFieldRepBehaviour(element){
                        element.click(function(event){

                            // clear out the foreign key, for both span & hidden input. We need to clear the span,
                            // otherwise if user just delete the TMCA field rep, and click that area, the dialog will still
                            // get displayed
                            //$(this).closest("tr").find("input[type=hidden].fkField").each(function(){
                            //    $(this).val("");
                            //});
                            $(this).closest("tr").find("input.removeFlagField").each(function(){
                               $(this).val("true");
                            });
                            $(this).closest("tr").find("span.fkField").each(function(){
                               $(this).text("");
                            });

                            // clear out the name
                            $(this).closest("tr").find("td.tmcaFieldRepColumn input[type=text]").each(function(){
                               $(this).val("");
                            });

                            // Show the add link,
                            $(this).closest("tr").find(".addTMCARepLink").show();

                            // Hide the delete link (this)
                            $(this).hide();

                            YAHOO.util.Event.preventDefault(event);
                        });
                    }
        </script>
        </nc:ifWriteAccessAllowed>
</stripes:layout-definition>