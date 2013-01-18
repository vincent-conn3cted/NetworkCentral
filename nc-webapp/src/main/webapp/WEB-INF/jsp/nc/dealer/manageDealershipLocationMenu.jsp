<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

    <stripes:layout-component name="html-head">
      <link rel="stylesheet" media="screen" type="text/css"
              href="${pageContext.request.contextPath}/css/wib/dealerLocation/nc-dealership.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <!-- MANAGE DEALERSHIP -->
        <div class="pageContent_main_header">
            <h1>Manage Dealership</h1>
        </div>

        <!-- for selenium tests: manage dealer menu page -->
        <c:import url="/WEB-INF/jsp/messages.jsp"/>

        <c:set var="allDealersForCreatingLocation" value="${actionBean.allDealersForCreatingLocation}" scope="page"/>
        <div id="manageDealerLocationMenuPage" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                    <ul id="manageDealerLocationMenu" class="menu_simple_vertical">
                        <fmt:message key="menu.dealershiplocation.search.dealer" var="searchDealershipTitle" scope="page"/>
                        <li>
                            <stripes:link id="searchDealerForEditLink" beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean"
                                title="${searchDealershipTitle}" event="displaySearchPageForEdit">
                                ${searchDealershipTitle}
                            </stripes:link>
                        </li>


                    <nc:ifAllowCreateDealerLocation>
                        <fmt:message key="menu.dealershiplocation.add.dealer" var="addDealershipTitle" scope="page"/>
                            <li>
                             <stripes:link id="createDealerLink" beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean"
                                           title="${addDealershipTitle}" event="newDealer">
                             ${addDealershipTitle}
                             </stripes:link>
                             </li>

                        <%-- Only displays add location if there are locations! --%>
                        <c:if test="${fn:length(allDealersForCreatingLocation) != 0}">
                                <fmt:message key="menu.dealershiplocation.add.location" var="addLocationTitle" scope="page"/>
                                <li><a href="" id="createLocationLink">${addLocationTitle}</a></li>
                        </c:if>
                    </nc:ifAllowCreateDealerLocation>
                    </ul>


                    <!-- show create new location info -->
                    <nc:ifAllowCreateDealerLocation>
                    <c:if test="${fn:length(allDealersForCreatingLocation) !=0}">
                        <div id="newLocationDialog">
                            <div class="hd">Add New Location</div>
                            <div class="bd">
                                <stripes:form id="createLocationForm" beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean">
                                    <fieldset>
                                    <label for="createLocationRequest.locationType"><fmt:message key="location.type"/></label>
                                    <stripes:select id="createLocationRequest.locationType" name="createLocationRequest.locationType">
                                        <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.LocationType"/>
                                    </stripes:select><br/>

                                    <label for="createLocationRequest.dealerId"><fmt:message key="label.dealer"/></label>
                                    <stripes:select id="createLocationRequest.dealerId" name="createLocationRequest.dealerId">
                                        <c:forEach items="${allDealersForCreatingLocation}" var="dealerForCreatingLocation">
                                            <stripes:option value="${dealerForCreatingLocation.dealerId}">
                                                <stripes:layout-render name="/WEB-INF/jsp/nc/formatting/_dealerNameSelection.jsp" dealer="${dealerForCreatingLocation}"/>
                                            </stripes:option>
                                        </c:forEach>
                                    </stripes:select>

                                    <stripes:hidden name="newLocation" value="newLocation"/>
                                    </fieldset>
                                </stripes:form>
                            </div>
                        </div>
                    </c:if>
                </nc:ifAllowCreateDealerLocation>
                <div class="clear"></div>
        </div>
        <div class="clear"></div>
    </div>

    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">
        <script type="text/javascript">

            <nc:ifAllowCreateDealerLocation>
                <c:if test="${fn:length(allDealersForCreatingLocation) !=0}">
                    var newLocationDialog = {
                        onOk: function(){
                            $("#createLocationForm").submit();
                        },
                        initDialog : function(){
                            <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                                    dialogName="NewLocationDialog" dialogId="newLocationDialog" okHandler="newLocationDialog.onOk"/>
                        }
                    };
                </c:if>
            </nc:ifAllowCreateDealerLocation>


            function yuiLoadComplete(){
                YAHOO.util.Event.onDOMReady(function(){
                    <nc:ifAllowCreateDealerLocation>
                        <c:if test="${fn:length(allDealersForCreatingLocation) !=0}">
                                newLocationDialog.initDialog();
                              <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                                                        htmlId="createLocationLink" dialogName="NewLocationDialog"/>
                        </c:if>
                    </nc:ifAllowCreateDealerLocation>
                });
            }
        </script>
    </stripes:layout-component>

</stripes:layout-render>