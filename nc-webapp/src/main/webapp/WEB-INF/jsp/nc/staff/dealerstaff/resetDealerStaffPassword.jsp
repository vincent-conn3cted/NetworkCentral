<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<nc:pageName pageName="DealerStaff-ResetOtherPassword"/>
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
          <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/staff/nc-staff.css"/>
    </stripes:layout-component>
    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: reset others password page -->
        <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.ResetDealerStaffPasswordActionBean">
            <stripes:hidden name="dealer.dealerId"/>
            <stripes:hidden name="dealerStaff.personId"/>
            <div class="pageContent_main_header">
                <h1 id="resetOthersPassword-title"><c:out value="${actionBean.loadedSelectedDealerStaff.fullName}"/> - <c:out value="${actionBean.loadedSelectedDealer.generalInfo.dealerName}"/></h1>
            </div>
            <div class="pageContent_wrapper">
                <c:import url="/WEB-INF/jsp/messages.jsp"/>
                <div id="personalDetails" class="mainContent_wrapper">
                    <div id="resetOthersPassword-eligibleUsercodes">
                        <c:choose>
                            <c:when test="${fn:length(actionBean.eligibleUsercodes) > 1}">
                                <fmt:message key="message.password.reset.other.heading.eligibleUsercodes.moreThanOne">
                                    <fmt:param value="${actionBean.loadedSelectedDealerStaff.fullName}"/>
                                </fmt:message>
                            </c:when>
                            <c:otherwise>
                                <fmt:message key="message.password.reset.other.heading.eligibleUsercodes.one"/>
                            </c:otherwise>
                        </c:choose>
                        <ul>
                            <c:forEach items="${actionBean.eligibleUsercodes}" var="eligibleUsercode">
                                <li>
                                    <c:out value="${eligibleUsercode}"/>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div id="resetOthersPassword-nonEligibleUsercodes">
                        <fmt:message key="message.password.reset.other.heading.nonEligibleUsercodes">
                            <fmt:param value="${actionBean.dealerStaff.fullName}"/>
                        </fmt:message>
                        <ul>
                            <c:forEach items="${actionBean.nonEligibleUsercodes}" var="nonEligibleUsercode">
                                <li>
                                    <c:out value="${nonEligibleUsercode}"/>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <fieldset>
                        <nc:ifWriteAccessAllowed name="newPassword">
                            <stripes:label name="newPassword" for="newPassword"/>
                            <stripes:text name="newPassword" id="newPassword"/>
                            <br/>
                        </nc:ifWriteAccessAllowed>
                        <nc:ifWriteAccessAllowed name="confirmNewPassword">
                            <stripes:label name="confirmNewPassword" for="confirmNewPassword"/>
                            <stripes:text name="confirmNewPassword" id="confirmNewPassword"/>
                            <br/>
                        </nc:ifWriteAccessAllowed>
                        <nc:ifWriteAccessAllowed name="resetPasswordButton">
                            <stripes:submit id="resetPasswordButton" name="resetPassword">Reset</stripes:submit>
                        </nc:ifWriteAccessAllowed>
                    </fieldset>
                </div>
            </div>
        </stripes:form>
    </stripes:layout-component>
</stripes:layout-render>
