<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
         <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/changeOver/nc-changeOver.css"/>
          <jsp:include page="_exitWizard.jsp"/>
    </stripes:layout-component>


    <stripes:layout-component name="page-contents">
         <div class="pageContent_main_header">
                <!-- PROCESS DEALER CHANGEOVER-->
               <h1>Process Dealer Changeover</h1>
        </div>
        <!-- for selenium tests: select dealer changeover page -->

        <div class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                <c:choose>
                    <c:when test="${empty actionBean.changeoverEnabledDealers}">
                        <fmt:message key="dealerChangeover.dealers.noChangeoverEnabledDealers"/>
                    </c:when>
                    <c:otherwise>
                        <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerchangeover.ProcessDealerChangeoverActionBean">
                            <c:import url="/WEB-INF/jsp/messages.jsp"/>

                            <fieldset>
                                <label for="changeoverEnabledDealersSelectBox">Dealer</label>
                                <stripes:select name="selectedDealerId" id="changeoverEnabledDealersSelectBox">
                                    <stripes:option value=""><fmt:message key="dealerChangeover.dealers.select.prompt"/></stripes:option>
                                    <c:forEach items="${actionBean.changeoverEnabledDealers}" var="changeoverEnabledDealer">
                                        <stripes:option value="${changeoverEnabledDealer.dealerId}">
                                            <stripes:layout-render name="/WEB-INF/jsp/nc/formatting/_dealerNameSelection.jsp" dealer="${changeoverEnabledDealer}"/>
                                        </stripes:option>
                                    </c:forEach>
                                </stripes:select>
                            </fieldset>
                            <div class="clear"></div>

                             <div class="formActionButtons">
                                <stripes:button name="list" value="Exit" onclick="exitWizard();" id="exitButton" class="btn btn_exit"/>
                                <stripes:submit name="saveDealer" value="Save and Continue" id="saveDealerButton" class="btn btn_saveContinue"/>
                                <div class="clear"></div>
                            </div>
                            
                            <div class="clear"></div>
                        </stripes:form>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="clear"></div>
        </div>
    </stripes:layout-component>

</stripes:layout-render>


