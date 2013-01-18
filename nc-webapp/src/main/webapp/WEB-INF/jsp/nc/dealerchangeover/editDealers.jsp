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
                <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerchangeover.ProcessDealerChangeoverActionBean">
                    <stripes:hidden name="dealerChangeover.dealerChangeoverId"/>
                    <c:import url="/WEB-INF/jsp/messages.jsp"/>

                    <fieldset>
                        <label for="changeoverEnabledDealersSelectBox">Dealer</label>
                        <stripes:select name="selectedDealerId" id="changeoverEnabledDealersSelectBox" disabled="disabled">
                        <stripes:option value="" selected="selected">
                            <stripes:layout-render name="/WEB-INF/jsp/nc/formatting/_dealerNameSelection.jsp" dealer="${actionBean.dealerChangeover.oldDealer}"/>
                        </stripes:option>
                    </stripes:select>
                    </fieldset>
                    <div class="clear"></div>
                                         
                    <div class="formActionButtons">
                        <stripes:button name="list" value="Exit" onclick="exitWizard();" id="exitButton" class="btn btn_exit"/>
                        <stripes:submit name="saveEditDealer" value="Save and Continue" id="saveDealerButton" class="btn btn_saveContinue"/>
                        <div class="clear"></div>
                    </div>
                    
                </stripes:form>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </div>
    </stripes:layout-component>

</stripes:layout-render>


