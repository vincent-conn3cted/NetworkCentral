<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
            <%-- ==========================================
        Secure page stuffs
        =============================================--%>
        <nc:pageName pageName="${pageName}"/>
       <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

       <!-- ================================================================
            Start location stuffs
        =================================================================== -->
        <fieldset id="locationInfo-locationSection">
            <table id="locationTable" class="resultsTable">
                <thead>
                    <tr>
                        <th><fmt:message key="location.locationId"/></th>
                        <th><fmt:message key="location.locationName"/></th>
                        <th><fmt:message key="location.type"/></th>
                        <th><fmt:message key="label.address.street.header"/></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${actionBean.allowedLocationsForDealer}" var="location" varStatus="locationStatus">
                        <tr class="itemRow">
                            <td class="locationIdColumn">
                                   <c:choose>
                                          <c:when test="${actionBean.showAsReadOnly eq true}">
                                              <stripes:url var="url"
                                                           beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean"
                                                           event="viewLocation"
                                                           scope="page"/>
                                        </c:when>
                                        <c:otherwise>
                                            <stripes:url var="url"
                                                         beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean"
                                                         event="editLocation"
                                                         scope="page"/>
                                        </c:otherwise>
                                </c:choose>
                                <a href="${url}&<%=ManageLocationActionBean.REQUEST_PARAM_LOCATION_ID%>=${location.locationId}"
                                   id="editLocationLink-${location.locationId}">${location.locationId}</a>
                            </td>
                            <td class="locationNameColumn">${location.locationName}</td>
                            <td class="locationTypeColumn">${location.type}</td>
                            <td class="locationStreetAddressColumn"><nc:addressDecorator contact="${location.contact}" addressType="street"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </fieldset>
           <!-- ================================================================
            End location stuffs
        =================================================================== -->

    
</stripes:layout-definition>