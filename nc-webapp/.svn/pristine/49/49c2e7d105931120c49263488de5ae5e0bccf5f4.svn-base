<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/dealerLocation/nc-dealership.css"/>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/nc-ajax.js"></script>
    </stripes:layout-component>
    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: location staff info page -->

        <div id="dealerLocationStaffInfoPage" class="pageContent_wrapper">
            <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean">

                <c:set var="pageName" value="EditLocation-${actionBean.location.type}-General" scope="page"/>
                <nc:pageName pageName="${pageName}"/>
                <stripes:layout-render name="/WEB-INF/jsp/nc/location/_locationCommonForm.jsp" pageName="${pageName}" showLocationTabs="true"/>

                <div id="dealerLocationDetailsPage" class="mainContent_wrapper">
                    <table id="locationsStaffListingsTable">
                        <thead>
                            <tr>
                                <th>
                                    <fmt:message key="/staff/DealerStaffSearch.action.searchReq.firstname"/>
                                </th>
                                <th>
                                    <fmt:message key="/staff/DealerStaffSearch.action.searchReq.surname"/>
                                </th>
                                <th>
                                    <fmt:message key="/staff/DealerStaffSearch.action.searchReq.position"/>
                                </th>
                                <th>
                                    <fmt:message key="dealerstaffsearch.telephone"/>
                                </th>
                                <th>
                                    <fmt:message key="dealerstaffsearch.email"/>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="locationId" value="${actionBean.location.locationId}"/>
                            <c:forEach items="${actionBean.location.staffWithAppointments}" var="staff">
                                <stripes:url beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffActionBean"
                                             var="viewStaffUrl" event="edit">
                                    <stripes:param name="readOnly" value="true"/>
                                    <stripes:param name="dealerStaff.personId" value="${staff.personId}"/>
                                </stripes:url>
                                <tr>
                                    <td style="vertical-align:top;">
                                        <a href="<c:out value="${viewStaffUrl}"/>" id="viewDealerStaff-<c:out value="${staff.personId}"/>"><c:out value="${staff.firstname}"/></a>
                                        <br/>
                                    </td>
                                    <td style="vertical-align:top;">
                                        <a href="<c:out value="${viewStaffUrl}"/>" id="viewDealerStaff-<c:out value="${staff.personId}"/>"><c:out value="${staff.surname}"/></a>
                                        <br/>
                                    </td>
                                    <c:set var="staffsAppointments" value="${staff.activeAppointments}"/>
                                    <td style="vertical-align:top;">
                                        <ul>
                                        <c:forEach items="${staffsAppointments}" var="staffsAppointment">
                                            <c:if test="${staffsAppointment.location.locationId == locationId}">
                                                <li style="list-style-position:inside;" >
                                                    <c:out value="${staffsAppointment.position.description}"/>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                        </ul>
                                        <br/>
                                    </td>
                                    <td style="vertical-align:top;">
                                        <ul>
                                        <c:forEach items="${staffsAppointments}" var="staffsAppointment">
                                            <c:if test="${(staffsAppointment.location.locationId == locationId) && (not empty staffsAppointment.contact.phone)}">
                                                <li style="list-style-position:inside;" >
                                                    <c:out value="${staffsAppointment.contact.phone}"/>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                        </ul>
                                        <br/>
                                    </td>
                                    <td style="vertical-align:top;">
                                        <ul>
                                        <c:forEach items="${staffsAppointments}" var="staffsAppointment">
                                            <c:if test="${(staffsAppointment.location.locationId == locationId) && (not empty staffsAppointment.contact.email)}">
                                                <li style="list-style-position:inside;" >
                                                    <c:out value="${staffsAppointment.contact.email}"/>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                        </ul>
                                        <br/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </stripes:form>
        </div>
    </stripes:layout-component>
</stripes:layout-render>
