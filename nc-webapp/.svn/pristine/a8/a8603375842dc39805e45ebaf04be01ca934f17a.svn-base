<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<c:set var="pageName" value="MyDetails-ResetOwnPassword" scope="page"/>
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
          <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/staff/nc-staff.css"/>
    </stripes:layout-component>
    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: reset own password page -->
        <div class="pageContent_main_header">
            <h1 id="resetOwnPassword-title"><c:out value="${actionBean.loggedInUsersAppointment.person.fullName}"/></h1>
        </div>
        <div id="dealerStaffDetailsPage" class="pageContent_wrapper">
            <c:import url="/WEB-INF/jsp/messages.jsp"/>
            <div id="personalDetails" class="mainContent_wrapper">
                <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.staff.mydetails.ResetPasswordActionBean">
                    <div id="resetOwnPassword-eligibleUsercodes">
                        <fmt:message key="message.password.reset.own.heading"/>
                        <ul>
                            <c:forEach items="${actionBean.eligibleUsercodes}" var="eligibleUsercode">
                                <li>
                                    <c:out value="${eligibleUsercode}"/>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <fieldset>
                        <nc:ifWriteAccessAllowed name="oldPassword">
                            <stripes:label name="oldPassword" for="oldPassword" />
                            <stripes:password name="oldPassword" id="oldPassword"/>
                            <br/>
                        </nc:ifWriteAccessAllowed>
                        <nc:ifWriteAccessAllowed name="newPassword">
                            <stripes:label name="newPassword" for="newPassword" />
                            <stripes:password name="newPassword" id="newPassword"/>
                            <br/>
                        </nc:ifWriteAccessAllowed>
                        <nc:ifWriteAccessAllowed name="confirmNewPassword">
                            <stripes:label name="confirmNewPassword" for="confirmNewPassword" />
                            <stripes:password name="confirmNewPassword" id="confirmNewPassword"/>
                            <br/>
                        </nc:ifWriteAccessAllowed>
                        <stripes:submit id="resetOwnPasswordButton" name="resetOwnPassword"><fmt:message key="mydetails.button.resetPassword"/></stripes:submit>
                    </fieldset>
                </stripes:form>
            </div>
        </div>
    </stripes:layout-component>
</stripes:layout-render>
