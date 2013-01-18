<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-definition>
        <!--- =====   Start Other Products stuffs   ======================================== -->
        <fieldset id="tmcaInfo-otherProductsSection">
            <legend><fmt:message key="dealer.otherProducts"/> </legend>

            <c:forEach items="${actionBean.allOtherProduct}" var="otherProduct" varStatus="otherProductStatus">
                <label for="otherProduct${otherProduct.value}Input">${otherProduct.value}</label>
                <input id="otherProduct${otherProduct.value}Input" type="checkbox" disabled="true"/><br/>
            </c:forEach>
        </fieldset>
        <!--- =====   End Other Products stuffs   ======================================== -->

        <script type="text/javascript">
               function initializeOtherProduct(){
                     // Check initialization
                     <c:if test="${fn:length(actionBean.location.dealer.otherProducts) > 0}">
                         <c:forEach items="${actionBean.location.dealer.otherProducts}" var="dealerOtherProduct">
                             YAHOO.log("Initializing other product [${dealerOtherProduct.type.value}] as selected","info");
                             $("#otherProduct${dealerOtherProduct.type.value}Input").attr("checked",'checked');
                         </c:forEach>
                     </c:if>
                     YAHOO.log("Finished initializing 'other product'","info");
                 }
        </script>
</stripes:layout-definition>
