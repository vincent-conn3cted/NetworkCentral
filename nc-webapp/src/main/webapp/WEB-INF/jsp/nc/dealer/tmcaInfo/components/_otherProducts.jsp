<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>


    <nc:ifAccessAllowed name="dealer.otherProducts">
            <!--- =====   Start Other Products stuffs   ======================================== -->
        <ul class="column-style-fieldset oneCol">
            <li>
            <fieldset id="tmcaInfo-otherProductsSection">
                <legend><fmt:message key="dealer.otherProducts"/> </legend>
                <c:set var="allowChangeOtherProducts" value="false"/>
                <nc:ifWriteAccessAllowed name="dealer.otherProducts">
                    <c:set var="allowChangeOtherProducts" value="true"/>
                </nc:ifWriteAccessAllowed>

                <c:forEach items="${actionBean.allOtherProductIncludingSelectedDisabled}" var="otherProduct" varStatus="otherProductStatus">
                    <label for="otherProduct${otherProduct.value}Input">${otherProduct.value}</label>
                    <c:if test="${!allowChangeOtherProducts || actionBean.showAsReadOnly eq true}">
                        <span id="otherProduct${otherProduct.value}Input"><span class='unCheckedImage'>&nbsp;</span></span><br/>
                    </c:if>
                   <c:if test="${allowChangeOtherProducts && actionBean.showAsReadOnly eq false}">
                        <input id="otherProduct${otherProduct.value}Input" type="checkbox"/><br/>
                        <input type="hidden" id="otherProduct${otherProduct.value}Id" name="dealer.otherProducts[${otherProductStatus.index}].dealerOtherProductId"/>
                        <input type="hidden" id="otherProduct${otherProduct.value}TypeId" name="dealer.otherProducts[${otherProductStatus.index}].type.commonValueId"/>
                        <input type="hidden" id="otherProduct${otherProduct.value}RemoveFlag" name="dealer.otherProducts[${otherProductStatus.index}].removedFromDealer" value="true"/>
                    </c:if>
                </c:forEach>
            </fieldset>
            </li>
        </ul>
            <!--- =====   End Other Products stuffs   ======================================== -->
    </nc:ifAccessAllowed>

    <script type="text/javascript">
           function ${initializeOtherProductFunctionName}(){
               <c:if test="${allowChangeOtherProducts && actionBean.showAsReadOnly eq false}">
                            // Attach listener
                          YAHOO.log("Attaching behaviour for 'other product'","info");
                         <c:forEach items="${actionBean.allOtherProductIncludingSelectedDisabled}" var="otherProduct">
                            $("#otherProduct${otherProduct.value}Input").click(function(){
                                var isChecked=$(this).attr('checked');
                                if (isChecked){
                                    YAHOO.log("Selecting other product [${otherProduct.value}]","info");
                                    $("#otherProduct${otherProduct.value}TypeId").val("${otherProduct.commonValueId}");
                                }else{
                                    YAHOO.log("Deselecting other product [${otherProduct.value}]","info");
                                    $("#otherProduct${otherProduct.value}TypeId").val("");
                                }
                                $("#otherProduct${otherProduct.value}RemoveFlag").val(!isChecked);
                            });
                         </c:forEach>
               </c:if>

                 <c:if test="${fn:length(actionBean.dealer.otherProducts) > 0}">
                     // Initialization
                     <%--
                            We iterate through the 'other products' tied to the dealer, and for each, we either:
                            1. Insert 'checked' image (overwrite the existing unchecked image) - if page is in 'readonly' mode / user
                                is only allowed to see
                            2. Check the appropriate checkbox - if page is in 'write' mode, and user is allowed to do modification
                     --%>
                     <c:forEach items="${actionBean.dealer.otherProducts}" var="dealerOtherProduct">
                         YAHOO.log("Initializing other product [${dealerOtherProduct.type.value}]","info");

                        <c:if test="${allowChangeOtherProducts && actionBean.showAsReadOnly eq false}">
                                $("#otherProduct${dealerOtherProduct.type.value}Input").attr("checked",'checked');
                                $("#otherProduct${dealerOtherProduct.type.value}Id").val("${dealerOtherProduct.dealerOtherProductId}");
                               $("#otherProduct${dealerOtherProduct.type.value}TypeId").val("${dealerOtherProduct.type.commonValueId}");
                               $("#otherProduct${dealerOtherProduct.type.value}RemoveFlag").val("false");
                        </c:if>

                        <c:if test="${!allowChangeOtherProducts || actionBean.showAsReadOnly eq true}">
                               $("#otherProduct${dealerOtherProduct.type.value}Input").html("<span class='checkedImage'>&nbsp;</span>");
                        </c:if>

                        YAHOO.log("Finished initializing other product [${dealerOtherProduct.type.value}]","info");
                     </c:forEach>
                 </c:if>
             }
    </script>
</stripes:layout-definition>