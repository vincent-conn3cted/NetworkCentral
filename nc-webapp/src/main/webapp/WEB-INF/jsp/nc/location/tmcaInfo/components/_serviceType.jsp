<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

    <nc:ifAccessAllowed name="location.serviceTypes">
            <!-- ======== Start Service Type stuffs ============================ -->
                <fieldset id="tmcaInfo-serviceTypeSection" class="tableEncapsulatingFieldSet">
                    <nc:ifPageViewMode mode="Edit">
                         <nc:ifAccessAllowed name="location.serviceTypes.add">
                            <c:if test="${fn:length(actionBean.allServiceType)> 0}">
                                <a href="" id="addServiceTypeLink" class="addItemToTableLink">
                                    <fmt:message key="label.addItemToTable"/>
                                </a>
                            </c:if>
                        </nc:ifAccessAllowed>
                    </nc:ifPageViewMode>


                    <legend><fmt:message key="serviceType.title"/></legend>
                    <table id="serviceTypeTable">
                        <tbody>
                            <c:forEach items="${actionBean.location.serviceTypes}" var="st" varStatus="stStatus">
                                <tr  class="itemRow">
                                    <td>
                                        <nc:hidden name="location.serviceTypes[${stStatus.index}].locationServiceTypeId"/>
                                    </td>
                                    <td>
                                        <nc:hidden name="location.serviceTypes[${stStatus.index}].type.commonValueId"/>
                                        <nc:text name="location.serviceTypes[${stStatus.index}].type.value" readonly="true"/>
                                    </td>
                                    <nc:ifPageViewMode mode="Edit">
                                        <nc:ifAccessAllowed name="location.serviceTypes.delete">
                                            <td class="controlColumn">
                                                <nc:hidden name="location.serviceTypes[${stStatus.index}].removedFromLocation" class="removeFlagField"/>
                                                <a href="" class="deleteLink"><fmt:message key="label.removeItemInTable"/></a>
                                            </td>
                                        </nc:ifAccessAllowed>
                                    </nc:ifPageViewMode>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </fieldset>
            <!-- ======== End Service Type stuffs ============================ -->
        
        
        <nc:ifWriteAccessAllowed name="location.serviceTypes">
            <!--- =====================  Start Service Type dialog ======================== -->
             <div id="addServiceTypeDialog" class="dialog">
                <div class="hd"><fmt:message key="label.add"/> <fmt:message  key="serviceType.title"/></div>
                <div class="bd">
                    <select id="addServiceTypeSelectList">
                        <c:forEach items="${actionBean.allServiceType}" var="st">
                            <option value="${st.commonValueId}">${st.value}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <!--- =====================  End Service Type dialog ======================== -->

            <script type="text/javascript">
                function ${initializeServiceTypeFunctionName}(){
                    YAHOO.log("Initializing service type","info");

                    var addSelectedServiceType = function(){
                        YAHOO.log("Adding new 'service type'","info");

                        var newIndex=$("table#serviceTypeTable tbody tr").length;
                        var selectedValue = $("select#addServiceTypeSelectList").val();
                        var selectedOption = $("select#addServiceTypeSelectList option:selected").text();

                        $("<tr class='itemRow'>" +
                                "<td>"+
                                        "<input type='hidden' name='location.serviceTypes["+newIndex+"].locationServiceTypeId'/>"+
                                "</td>"+
                                "<td>"+
                                        "<input type='hidden' name='location.serviceTypes["+newIndex+"].type.commonValueId' value='"+selectedValue+"'/>"+
                                        "<input type='text' name='location.serviceTypes["+newIndex+"].type.value' readonly='readonly' value='"+selectedOption+"'/>"+
                                "</td>"+
                                "<td class='controlColumn'>"+
                                        "<input type='hidden' name='location.serviceTypes["+newIndex+"].removedFromLocation' class='removeFlagField'/>"+
                                        "<a href='' class='deleteLink'><fmt:message key="label.removeItemInTable"/></a>"+
                                "</td>"+
                        "</tr>").appendTo("table#serviceTypeTable tbody");

                        YAHOO.log("Attaching delete behaviour to newly added 'service type'","info");
                        attachDeleteBehaviourWithFlagField($("table#serviceTypeTable tr:last-child a.deleteLink"));

                        YAHOO.log("Finished adding new 'service type'");
                    };

                    YAHOO.log("Creating service type dialog","info");
                    <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                               dialogName="AddServiceTypeDialog" dialogId="addServiceTypeDialog" okHandler="addSelectedServiceType"/>

                    YAHOO.log("Attaching popup listener for adding service type","info");
                    <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                            htmlId="addServiceTypeLink" dialogName="AddServiceTypeDialog"/>

                   YAHOO.log("Attaching delete behaviour to 'service type'","info");
                    attachDeleteBehaviourWithFlagField($("table#serviceTypeTable a.deleteLink"));

                    YAHOO.log("Finished initializing service type","info");
                }
            </script>
        </nc:ifWriteAccessAllowed>
        
    </nc:ifAccessAllowed>



</stripes:layout-definition>