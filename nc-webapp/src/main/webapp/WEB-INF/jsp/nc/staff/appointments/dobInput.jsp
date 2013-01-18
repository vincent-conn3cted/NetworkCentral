<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<nc:pageName pageName="Appointments-Manage-Mutiple-Staff-With-Same-Name"/>
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/nc-ajax.js"></script>
    </stripes:layout-component>
    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: add position for staff page -->
         <div class="pageContent_main_header">
            <h1>Enter Date Of Birth</h1>
         </div>

        <div id="addAppointmentPage" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                    <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffPositionDOBValidationActionBean">
                        <stripes:hidden name="sourceActionType" value="<%= au.com.toyota.nc.webapp.stripes.staff.AppointmentSourceActionType.MAINTAIN_STAFF %>"/>
                        <c:import url="/WEB-INF/jsp/messages.jsp"/>

                        <stripes:hidden name="appointment.person.personId"/>
<%--
                        <stripes:hidden name="appointment.person.firstName"/>
                        <stripes:hidden name="appointment.person.surname"/>
--%>

                        <ul class="column-style-fieldset oneCol">
                            <li>
                                <fieldset id="primaryAttributesSection">
                                    <legend>Staff Details</legend>


    <%--<stripes:label for="appointment.person.title" name="appointment.person.title"/>--%>
    <%--<stripes:label name="appointment.person.title" style="text-align:left;">${actionBean.appointment.person.title}</stripes:label><br/>--%>

    <%--<stripes:label name="appointment.person.firstname" for="appointment.person.firstname"/>--%>
    <%--<stripes:label name="appointment.person.firstname" id="appointment.person.firstname">${appointment.person.firstName}</stripes:label><br/>--%>

    <%--<stripes:label name="appointment.person.surname" for="appointment.person.surname"/>--%>
    <%--<stripes:label name="appointment.person.surname" id="appointment.person.surname">${appointment.person.surname}</stripes:label><br/>--%>

    <nc:label for="appointment.person.title" name="appointment.person.title"/>
    <nc:text name="appointment.person.title" id="appointment.person.title" style="text-align:left;"/><br/>

    <nc:label name="appointment.person.firstname" for="appointment.person.firstname"/>
    <nc:text name="appointment.person.firstname" id="appointment.person.firstname"/><br/>

    <nc:label name="appointment.person.surname" for="appointment.person.surname"/>
    <nc:text name="appointment.person.surname" id="appointment.person.surname"/><br/>

        <%--<nc:ifWriteAccessAllowed name="appointment.person.dob">--%>
<%--
            <stripes:label name="appointment.person.dob" for="appointment.person.dob"/>
            <span>
                <nc:datetext name="appointment.person.dob"
                             id="appointment.person.dob"
                             buttonId="dateOfBirthTrigger"
                             skipPermissions="true"/>
            </span><br/>
--%>
        <%--</nc:ifWriteAccessAllowed>--%>



<%--
                                    <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_dealerships.jsp"/>
                                    <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_locations.jsp" showLocationsEvent="showLocationsForDealer"/>
                                    <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_positions.jsp" eligiblePositions="${actionBean.allEligiblePositions}" pageName="${pageName}" readOnly="${readOnly}"/>
--%>
                                </fieldset>
                            </li>
                        </ul>
                        <div class="clear"></div>
<%--
                        <ul class="column-style-fieldset twoCols">
                            <li>
                                    <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_manageEditableCoreDetails.jsp" pageName="Appointments-Manage" readOnly="false"/>
                             </li>
                             <li>
                                 <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_manageContactDetails.jsp" pageName="Appointments-Manage" readOnly="false"/>
                             </li>
                        </ul>
                         <div class="clear"></div>
                         <ul class="column-style-fieldset oneCol">
                            <li>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_manageSystemInformation.jsp" pageName="Appointments-Manage" readOnly="false"/>
                            </li>
                         </ul>
                        <div class="clear"></div>
                        <ul class="column-style-fieldset oneCol">
                            <li>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_manageOtherDetails.jsp" pageName="Appointments-Manage" readOnly="false"/>
                            </li>
                        </ul>
                        <div class="clear"></div>
--%>
                        <stripes:submit id="saveButton" name="check"  class="btn btn_save" value="Check" onclick="disableButton('saveButton');"/>
                        <%--<stripes:reset name="reset" class="btn btn_reset" value="Reset"/>--%>
                    </stripes:form>
                    <div class="clear"></div>
                </div>
                <div class="clear"></div>
        </div>
    </stripes:layout-component>
</stripes:layout-render>