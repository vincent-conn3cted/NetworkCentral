<%@ page import="au.com.toyota.nc.webapp.stripes.staff.AppointmentSourceActionType" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<c:set var="pageName" value="MyDetails" scope="page"/>
<nc:pageName pageName="${pageName}"/>
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
          <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/staff/nc-staff.css"/>
    </stripes:layout-component>
    <stripes:layout-component name="page-contents">
        <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.staff.mydetails.MyDetailsActionBean" method="post">
        <!-- for selenium tests: my details page -->
        <div class="pageContent_main_header">
            <h1>Personal Details</h1>                
        </div>
            <div id="dealerStaffDetailsPage" class="pageContent_wrapper">
                <div id="personalDetails" class="mainContent_wrapper">
                        <c:import url="/WEB-INF/jsp/messages.jsp"/>

                        <stripes:hidden name="dealerStaff.personId"/>
                        <stripes:hidden name="oldFirstname" value="${actionBean.oldFirstname}"/>
                        <stripes:hidden name="oldLastname" value="${actionBean.oldLastname}"/>
                        <stripes:hidden name="oldDob" value="${actionBean.oldDob}"/>

                        <ul class="column-style-fieldset twoCols">
                            <li>
                                &nbsp;
                            </li>
                            <li>
                                <div class="personal_details_save_button">
                                    &nbsp;
                                    <stripes:submit name="saveOrUpdate" value="Save" id="saveOrUpdateButton" class="btn btn_save" style="float:left;" onclick="disableButton('saveOrUpdateButton');"/>
                                </div>
                            </li>
                            <li>
                                <fieldset id="staff-personal-details">
                                    <legend class="legend">Personal Details</legend>
                                    <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_dealerStaffNumber.jsp" pageName="${pageName}" readOnly="${readOnly}"/>
                                    <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_coreDetails.jsp" pageName="${pageName}" readOnly="${readOnly}"/>
                                    <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_languages.jsp" pageName="${pageName}" readOnly="${readOnly}"/>
                                </fieldset>
                            </li>
                            <li>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_spouseDetails.jsp" pageName="${pageName}" readOnly="${readOnly}"/>
                            </li>
                        </ul>

                        <div class="clear"></div>
                        <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_misc.jsp" pageName="${pageName}" readOnly="${readOnly}"/>

                        <ul class="table-item-control-nav">
                            <li id="resetOwnPassword">
                                <nc:ifAccessAllowed name="mydetails.password.reset.own">
                                    <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.staff.mydetails.ResetPasswordActionBean"
                                                  id="showResetOwnPasswordLink"
                                                  event="showResetOwnPassword">
                                        <fmt:message key="mydetails.link.password.reset.own"/>
                                    </stripes:link>
                                </nc:ifAccessAllowed>
                            </li>
                        </ul>
                    <div class="clear"></div>
                        
                    <c:forEach items="${actionBean.dealerStaff.activeAndDraftAppointments}" var="appointment" varStatus="appointmentStatus">
                        <!-- for selenium tests: dealer staff appointments section -->
                        <c:set var="pageName" value="MyDetails" scope="page"/>
                        <c:if test="${appointment.position.dpGmrFlag}">
                            <c:set var="pageName" value="MyDetails-dpgmr"/>
                        </c:if>
                        <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_appointment.jsp"
                                               appointmentCount="${appointmentStatus.index}" appointment="${appointment}" appointmentsPageName="${pageName}"
                                               eligibleDealerships="${actionBean.loggedInUsersAppointment.dealer}"
                                               sourceActionType="<%= AppointmentSourceActionType.MY_DETAILS%>"/>
                    </c:forEach>
                </div>
            </div>
        </stripes:form>
        <stripes:layout-render name="/WEB-INF/jsp/nc/staff/dealerstaff/_languageDialogBox.jsp" readOnly="false"/>
    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">
        <jsp:include page="/WEB-INF/jsp/nc/staff/dealerstaff/_js.jsp"/>
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp"/>
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarItem.jsp" inputField="dealerStaff.dob" button="dateOfBirthTrigger"/>
    </stripes:layout-component>
</stripes:layout-render>
