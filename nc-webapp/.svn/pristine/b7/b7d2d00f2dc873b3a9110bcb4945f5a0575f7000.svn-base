<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
            <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/changeOver/nc-changeOver.css"/>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/nc-ajax.js"></script>
    </stripes:layout-component>
 

    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: list dealer changeover page -->
            <div class="pageContent_main_header">
                <!-- PROCESS DEALER CHANGEOVER-->
                 <h1>Process Dealer Changeover</h1>
            </div>

        <div class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                    <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerchangeover.ProcessDealerChangeoverActionBean">
                        <c:import url="/WEB-INF/jsp/messages.jsp"/>
                        

                        <div id="dealerChangeoverPage-listings">
                            <div>
                                <ul class="table-item-control-nav">
                                    <li>
                                    <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.dealerchangeover.ProcessDealerChangeoverActionBean"
                                        event="selectDealers"
                                        id="newChangeoverLink">
                                        <fmt:message key="dealerChangeover.listings.newChangeover"/>
                                    </stripes:link>
                                    </li>
                                </ul>
                                <div class="clear"></div>
                            </div>

                            <table id="resultsTable"  class="resultsTable">
                                <thead>
                                    <tr>
                                        <th>
                                            <fmt:message key="dealerChangeover.listings.table.header.oldDealerName"/>
                                        </th>
                                        <th>
                                            <fmt:message key="dealerChangeover.listings.table.header.newDealerName"/>
                                        </th>
                                        <th>
                                            <fmt:message key="dealerChangeover.listings.table.header.changeoverDate"/>
                                        </th>
                                        <th>
                                            <fmt:message key="dealerChangeover.listings.table.header.status"/>
                                        </th>
                                        <th>&nbsp; </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${actionBean.dealerChangeovers}" var="dealerChangeover" varStatus="loopStatus">
                                        <tr class="${loopStatus.index %2==0 ? 'darkRow':'lightRow'}">
                                            <td>
                                                   <div class="data-line"><c:out value="${dealerChangeover.oldDealer.generalInfo.dealerName}"/></div>
                                            </td>
                                            <td>
                                                   <div class="data-line"> <c:out value="${dealerChangeover.newDealer.generalInfo.dealerName}"/></div>
                                            </td>
                                            <td>
                                                    <div class="data-line"><c:out value="${dealerChangeover.formattedScheduledDate}"/></div>
                                            </td>
                                            <td>
                                                    <div class="data-line"><c:out value="${dealerChangeover.changeoverStatus}"/></div>
                                            </td>
                                            <td>
                                                 <div class="data-line">
                                                <c:if test="${dealerChangeover.changeoverStatus.pending}">
                                                    <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.dealerchangeover.ProcessDealerChangeoverActionBean"
                                                                  event="edit"
                                                                  class="dealerChangeoverPage-listings-edit">
                                                        <stripes:param name="dealerChangeover.dealerChangeoverId" value="${dealerChangeover.dealerChangeoverId}"/>
                                                        [ <fmt:message key="label.edit" /> ]
                                                    </stripes:link>
                                                </c:if>
                                                <c:if test="${dealerChangeover.changeoverStatus.pending || dealerChangeover.changeoverStatus.failed}">
	                                                <div>
	                                                	<a id="cancelChangeOver" onclick="cancelDealerChangeoverFunction('${dealerChangeover.dealerChangeoverId}');" href="#">
	                                                		[ <fmt:message key="dealerChangeover.listings.table.actions.cancel"/> ]
	                                                	</a>
	                                                </div>
                                                </c:if>
                                                 </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <div id="cancelChangeoverDialog" class="dialog dialogWithDefaultCloseButton" >
	                        <div class="hd"><fmt:message key="label.warning"/></div>
	                        <div class="bd">
		                        <p>This screen allows you to cancel a dealer changeover that is scheduled that you do not want to occur,
		                           or to determine what to do after a changeover has failed.</p>
								<br>
								<p>If you wish to delay a changeover then do not use this cancel option. Instead change the date and
								   time of the changeover to a future date via the Edit option.</p>
								<br>
								<div class>
									<stripes:checkbox name="deleteAndPurge" id="deleteAndPurgeCheckBox"/> <b>Delete Cloned Data</b>
								</div>	
								<br>
								<br>
								<p>Only check this delete option if you are sure you do not wish to retain the changeover data.</p>
								<p>If the changeover has failed in NC, but has proceeded at the dealership, then you should not delete the data.</p>
								<br>
								<stripes:submit name="cancelDealerChangeover" id="cancelDealerChangeoverButton" class="btn btn_processCancel" onclick="disableButton('cancelDealerChangeoverButton');">
								</stripes:submit>
								
								<stripes:hidden name="dealerChangeover.dealerChangeoverId" id="dealerChangeover.dealerChangeoverId"/>
								
								<input id="dealerChangeoverCloseButton" type="button" class="btn btn_exitWithoutCancel" onclick="closeCancelDealerChangeoverDialog();" />
							</div>	
                    	</div>
                    
                    </stripes:form>

                    
                    <div class="clear"></div>
                </div>
            <div class="clear"></div>
        </div>
    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">
        
        <script type="text/javascript">

            function closeCancelDealerChangeoverDialog() {
            	YAHOO.au.com.toyota.widget.cancelChangeoverDialog.hide();
            }

            function cancelDealerChangeoverFunction(dealerChangeoverId) {
            	YAHOO.au.com.toyota.widget.cancelChangeoverDialog.show();
            	document.getElementById('dealerChangeover.dealerChangeoverId').value = dealerChangeoverId;
            }

            function yuiLoadComplete() {
                <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp" dialogName="cancelChangeoverDialog" dialogId="cancelChangeoverDialog" noButtons="true"/>
            }
        
            dialogs.add(cancelChangeoverDialog);

        </script>

    </stripes:layout-component>

</stripes:layout-render>
