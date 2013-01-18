<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <!-- for selenium tests: dealer staff appointments section -->

    <c:forEach items="${actionBean.staffsAppointments}" var="appointment" varStatus="appointmentStatus">
        <c:choose>
            <c:when test="${appointment.position.dpGmrFlag}">
                <c:set var="appointmentsPageName" value="Appointments-Manage-dpgmr"/>
            </c:when>
            <c:otherwise>
                <c:set var="appointmentsPageName" value="Appointments-Manage"/>
            </c:otherwise>
        </c:choose>
        <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_appointment.jsp"
                               eligibleDealerships="${actionBean.eligibleDealerships}"
                               readOnly="${actionBean.readOnly}" sourceActionType="<%= au.com.toyota.nc.webapp.stripes.staff.AppointmentSourceActionType.MAINTAIN_STAFF%>"
                               appointmentCount="${appointmentStatus.index}" appointment="${appointment}" appointmentsPageName="${appointmentsPageName}"
                               lastMaintainedAppointmentsUserNameListFromLDAP="${actionBean.lastMaintainedAppointmentsUserNameListFromLDAP}" />
    </c:forEach>
</stripes:layout-definition>
