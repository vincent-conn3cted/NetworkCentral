<%@ page import="au.com.toyota.nc.webapp.stripes.staff.AppointmentSourceActionType" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <c:set var="myDetailsSourceActionType" value="<%= AppointmentSourceActionType.MY_DETAILS%>"/>
    <c:if test="${readOnly == null}">
        <c:set var="readOnly" value="false"/>
    </c:if>
    <stripes:hidden name="selectedAppointments[${appointmentCount}].appointmentId" value="${appointment.appointmentId}"/>
    
    <nc:pageName pageName="${appointmentsPageName}"/>
    <div class="subContent_wrapper addDealerStaffAppointmentContainer">
            <h3 class="subContent_title">
                <nc:ifAccessAllowed name="appointment.dealer.dealerId">
                    <span class="addDealerStaffAppointmentDealerValue"><c:out value="${appointment.dealer.generalInfo.dealerName}"/></span>
                </nc:ifAccessAllowed>/
                <nc:ifAccessAllowed name="appointment.location.locationId">
                    <span class="addDealerStaffAppointmentLocation"><c:out value="${appointment.location.locationName}"/></span>
                </nc:ifAccessAllowed>
            </h3>

        <c:if test="${appointment.provisionalIndicator}">
            <div class="addDealerStaffAppointmentProvisionalIndicator">
                <div class="addDealerStaffAppointmentProvisionalIndicatorIcon"></div>
                <div class="addDealerStaffAppointmentProvisionalIndicatorText">This Position is Provisional !</div>
            </div>
        </c:if>

        <div class="addDealerStaffAppointment">
            <ul class="column-style-fieldset twoCols">
                <li>
                    <table class="form appointmentDetailsTable">
                        <caption>Appointment Details</caption>
                        <tbody>
                            <nc:ifAccessAllowed name="appointment.position.positionId">
                                <tr class="addDealerStaffAppointmentPosition">
                                    <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.position.positionId"/></th>
                                    <td class="addDealerStaffAppointmentPositionValue"><c:out value="${appointment.position.description}"/></td>
                                </tr>
                                <tr class="addDealerStaffAppointmentPosition">
                                    <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.positionDefinition"/></th>
                                    <td class="addDealerStaffAppointmentPositionValue"><c:out value="${appointment.positionDefinition.description}"/></td>
                                </tr>
                            </nc:ifAccessAllowed>
                            <nc:ifAccessAllowed name="appointmentDepartments">
                                <tr class="addDealerStaffAppointmentDepartments">
                                    <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointmentDepartments"/></th>
                                    <td>
                                            <ul id="addDealerStaffAppointmentDepartmentsValues">
                                                <c:forEach items="${appointment.departments}" var="department">
                                                    <li>
                                                        <c:out value="${department.department.description}"/>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                    </td>
                                </tr>
                            </nc:ifAccessAllowed>
                            <nc:ifAccessAllowed name="appointment.appointmentDate.startDate">
                                <tr>
                                     <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.appointmentDate.startDate"/></th>
                                    <td><fmt:formatDate value="${appointment.appointmentDate.startDate}" pattern="dd/MM/yyyy"/></td>
                                </tr>
                            </nc:ifAccessAllowed>
                            <nc:ifAccessAllowed name="appointment.partTimeFlag">
                                <tr class="addDealerStaffAppointmentPartTime">
                                    <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.partTimeFlag"/></th>
                                    <td class="addDealerStaffAppointmentPartTimeValue"><stripes:checkbox name="appointment.partTimeFlag" disabled="disabled" checked="${appointment.partTimeFlag}"/></td>
                                </tr>
                            </nc:ifAccessAllowed>
                            <nc:ifAccessAllowed name="appointment.primaryPosition">
                                <tr>
                                    <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.primaryPosition"/></th>
                                    <td><stripes:checkbox name="appointment.primaryPosition" disabled="disabled" checked="${appointment.primaryPosition}"/></td>
                                </tr>
                            </nc:ifAccessAllowed>
                            
                            <nc:ifAccessAllowed name="appointment.trainingApprovalManager">
                                <tr class="addDealerStaffAppointmentTrainingApprovalManager">
                                    <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointmentTrainingApprovalManager"/></th>
                                    <td class="addDealerStaffAppointmentTrainingApprovalManagerValue">
                                    <c:choose>
				                        <c:when test="${empty appointment.trainingManager and appointment.dpGmrFlag}">
				                            None Required
				                        </c:when>
				                        <c:when test="${not empty appointment.trainingManager}">
                                    		${appointment.trainingManager.appointmentDescription}
				                        </c:when>
				                    </c:choose>
                                    </td>
                                </tr>
                            </nc:ifAccessAllowed>                            
                        </tbody>
                    </table>
                </li>
          </ul>


            <div class="clear"></div>
            <ul class="column-style-fieldset twoCols">
                <li>
                    <table class="form appointmentDetailsTable">
                        <caption>Contact Details</caption>
                        <tbody>
                        <nc:ifAccessAllowed name="appointment.contact.phone">
                            <tr class="addDealerStaffAppointmentPhone">
                                <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.contact.phone"/></th>
                                <td class="addDealerStaffAppointmentPhoneValue"><c:out value="${appointment.contact.phone}"/></td>
                            </tr>
                        </nc:ifAccessAllowed>
                        <nc:ifAccessAllowed name="appointment.contact.email">
                            <tr class="addDealerStaffAppointmentEmail">
                                <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.contact.email"/></th>
                                <td class="addDealerStaffAppointmentEmailValue"><c:out value="${appointment.contact.email}"/></td>
                            </tr>
                        </nc:ifAccessAllowed>
                        <nc:ifAccessAllowed name="appointment.contact.fax">
                            <tr class="addDealerStaffAppointmentFax">
                                <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.contact.fax"/></th>
                                <td class="addDealerStaffAppointmentFaxValue"><c:out value="${appointment.contact.fax}"/></td>
                            </tr>
                        </nc:ifAccessAllowed>
                        <nc:ifAccessAllowed name="appointment.contact.mobile">
                            <tr class="addDealerStaffAppointmentMobile">
                                <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.contact.mobile"/></th>
                                <td class="addDealerStaffAppointmentMobileValue"><c:out value="${appointment.contact.mobile}"/></td>
                            </tr>
                        </nc:ifAccessAllowed>

                        </tbody>
                    </table>
                </li>
            </ul>
            <div class="clear"></div>

            <ul class="column-style-fieldset twoCols">
                <li>
                        <table class="form appointmentDetailsTable">
                            <caption>Miscellaneous</caption>
                            <tbody>
                                    <tr>
                                         <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.activeForToyotaSystems"/></th>
                                        <td><input type="checkbox" checked="checked" readonly="readonly" disabled="disabled"/></td>
                                    </tr>
                                    <tr class="addDealerStaffAppointmentUsercode">
                                         <th><fmt:message key="appointment.ldap.userid"/></th>
                                        <td class="addDealerStaffAppointmentUsercodeValue"><c:out value="${appointment.usercode}"/></td>
                                    </tr>
                                    <nc:ifAccessAllowed name="appointment.dealerPortalUser">
                                        <tr class="addDealerStaffAppointmentPortalUser">
                                               <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.dealerPortalUser"/></th>
                                                <td class="addDealerStaffAppointmentPortalUserValue">
                                                    <stripes:checkbox name="appointment.dripInfo.user" disabled="disabled" checked="${appointment.dripInfo.user}"/>
                                                </td>
                                        </tr>
                                    </nc:ifAccessAllowed>
                                    <nc:ifAccessAllowed name="appointment.dripInfo.emailOptIn">
                                        <tr class="addDealerStaffAppointmentEmailOptIn">
                                            <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.dripInfo.emailOptIn"/></th>
                                            <td class="addDealerStaffAppointmentEmailOptInValue"><stripes:checkbox name="appointment.dripInfo.emailOptIn" disabled="disabled" checked="${appointment.dripInfo.emailOptIn}"/></td>
                                        </tr>
                                    </nc:ifAccessAllowed>
                                    <nc:ifAccessAllowed name="appointment.dripInfo.smsOptIn">
                                        <tr class="addDealerStaffAppointmentSmsOptIn">
                                            <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.dripInfo.smsOptIn"/></th>
                                            <td class="addDealerStaffAppointmentSmsOptInValue"><stripes:checkbox name="appointment.dripInfo.smsOptIn" disabled="disabled" checked="${appointment.dripInfo.smsOptIn}"/></td>
                                        </tr>
                                    </nc:ifAccessAllowed>
                                    <nc:ifAccessAllowed name="appointment.dripInfo.smsNumber">
                                        <tr class="addDealerStaffAppointmentSmsNumber">
                                            <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.dripInfo.smsNumber"/></th>
                                            <td class="addDealerStaffAppointmentSmsNumberValue"><c:out value="${appointment.dripInfo.smsNumber}"/></td>
                                        </tr>
                                    </nc:ifAccessAllowed>
                                    <nc:ifAccessAllowed name="appointment.sapInfo.username">
                                        <tr class="addDealerStaffAppointmentSapUsername">
                                            <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.sapInfo.username"/></th>
                                            <td class="addDealerStaffAppointmentSapUsernameUsername"><c:out value="${appointment.sapInfo.username}"/></td>
                                        </tr>
                                    </nc:ifAccessAllowed>
                                    <nc:ifAccessAllowed name="appointment.sapInfo.sapUsernameActive">
                                       <tr>
                                            <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.sapInfo.validated"/></th>
                                           <td>
                                                  <span class="addDealerStaffAppointmentSapUsernameValidationStatus">
                                                    <c:choose>
                                                        <c:when test="${appointment.sapInfo.sapUsernameActive}">
                                                            <fmt:message key="dealerstaffsearch.sap.username.status.verified"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:message key="dealerstaffsearch.sap.username.status.notverified"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                           </td>
                                       </tr>
                                    </nc:ifAccessAllowed>
                                    <nc:ifAccessAllowed name="appointment.salesIndicator">
                                        <tr class="addDealerStaffAppointmentSalesIndicator">
                                            <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.salesIndicator"/></th>
                                            <td class="addDealerStaffAppointmentSalesIndicatorValue"><stripes:checkbox name="appointment.salesIndicator" disabled="disabled" checked="${appointment.salesIndicator}"/></td>
                                        </tr>
                                    </nc:ifAccessAllowed>
                            </tbody>
                        </table>
                    </li>

                    <li>
                        <table class="form appointmentDetailsTable">
                            <caption><fmt:message key="appointment.otherPositionDetails"/></caption>
                            <tbody>
                                   <nc:ifAccessAllowed name="appointment.twrsChampionFlag">
                                        <tr class="addDealerStaffAppointmentTwrsChampion">
                                            <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.twrsChampionFlag"/>:</th>
                                            <td class="addDealerStaffAppointmentTwrsChampionValue"><stripes:checkbox name="appointment.twrsChampionFlag" disabled="disabled" checked="${appointment.twrsChampionFlag}"/></td>
                                        </tr>
                                    </nc:ifAccessAllowed>
                                    <nc:ifAccessAllowed name="appointment.privacyOfficerFlag">
                                        <tr class="addDealerStaffAppointmentPrivacyOfficer">
                                            <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.privacyOfficerFlag"/>:</th>
                                            <td class="addDealerStaffAppointmentPrivacyOfficerValue"><stripes:checkbox name="appointment.privacyOfficerFlag" disabled="disabled" checked="${appointment.privacyOfficerFlag}"/></td>
                                        </tr>
                                    </nc:ifAccessAllowed>
                                    <nc:ifAccessAllowed name="appointment.trainingOfficerFlag">
                                        <tr class="addDealerStaffAppointmentTrainingOfficer">
                                            <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.trainingOfficerFlag"/>:</th>
                                            <td class="addDealerStaffAppointmentTrainingOfficerValue"><stripes:checkbox name="appointment.trainingOfficerFlag" disabled="disabled" checked="${appointment.trainingOfficerFlag}"/></td>
                                        </tr>
                                    </nc:ifAccessAllowed>
                                    <nc:ifAccessAllowed name="appointment.authorisedTrainingApproverFlag">
                                        <tr class="addDealerStaffAppointmentTrainingOfficer">
                                            <th><fmt:message key="/staff/dealerstaff/DealerStaffPosition.action.appointment.authorisedTrainingApproverFlag"/>:</th>
                                            <td class="addDealerStaffAppointmentAuthorisedTrainingApproverValue"><stripes:checkbox name="appointment.authorisedTrainingApproverFlag" disabled="disabled" checked="${appointment.authorisedTrainingApproverFlag}"/></td>
                                        </tr>
                                    </nc:ifAccessAllowed>                                    
                            </tbody>
                        </table>
                    </li>
                </ul>
            <div class="clear"></div>

                <c:if test="${readOnly == false}">
                <ul class="menu_simple_vertical">
                    <nc:ifWriteAccessAllowed name="dealerStaff.positions.copy">
                        <li>
                            <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffPositionActionBean"
                                          event="copy"
                                          class="copyAppointmentLink">
                                <stripes:param name="appointment.appointmentId" value="${appointment.appointmentId}"/>
                                <stripes:param name="appointment.person.personId" value="${appointment.person.personId}"/>
                                <fmt:message key="dealerstaffsearch.appointment.copy"/>
                            </stripes:link>
                        </li>
                    </nc:ifWriteAccessAllowed>

                <c:set var="displayManageLinks" value="true"/>
                <nc:evalAccess>
                    <c:if test="${! fn:contains(eligibleDealerships, appointment.dealer)}">
                        <c:set var="displayManageLinks" value="false"/>
                    </c:if>
                </nc:evalAccess>

                <c:if test="${displayManageLinks == 'true'}">
                    <c:if test="${myDetailsSourceActionType eq sourceActionType}">
                        <c:if test="${appointment.sapInfo.sapUsernameActive}">
                        <li>
                            <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.staff.mydetails.MyDetailsActionBean"
                                          event="generateSapPassword"
                                          class="generateSapPasswordLink"
                                          title="Generate SAP Password">
                                <stripes:param name="appointmentId" value="${appointment.appointmentId}"/>
                                <fmt:message key="mydetails.link.password.generate.sap"/>
                            </stripes:link>
                        </li>
                        </c:if>
                    </c:if>
                    <%-- if user can edit position --%>
                        <nc:ifWriteAccessAllowed name="dealerStaff.positions.edit">
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffPositionActionBean"
                                              class="editAppointmentLink"
                                              event="edit" id="editAppointmentLink-${appointment.appointmentId}">
                                    <stripes:param name="appointment.appointmentId" value="${appointment.appointmentId}"/>
                                    <stripes:param name="sourceActionType" value="${sourceActionType}"/>
                                    <fmt:message key="dealerstaffsearch.appointment.edit"/>
                                </stripes:link>
                            </li>
                        </nc:ifWriteAccessAllowed>

                    <%-- if user can discontinue position --%>
                        <nc:ifWriteAccessAllowed name="dealerStaff.positions.discontinue">
                            <li>
                                <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffPositionActionBean"
                                              event="discontinue"
                                              class="discontinueAppointmentLink"
                                              onclick="return confirmDiscontinueAppointment('${appointment.position.description}', '${appointment.person.fullName}');"
                                              id="discontinueAppointmentLink-${appointment.appointmentId}">
                                    <stripes:param name="appointment.appointmentId" value="${appointment.appointmentId}"/>
                                    <stripes:param name="appointment.person.personId" value="${appointment.person.personId}"/>
                                    <stripes:param name="sourceActionType" value="${sourceActionType}"/>
                                    <fmt:message key="dealerstaffsearch.appointment.discontinue"/>
                                </stripes:link>
                            </li>
                        </nc:ifWriteAccessAllowed>
                </c:if>
                </ul>
            </c:if>
            <div class="clear"></div>
            <c:if test="${!actionBean.footerDisplayable}"> 
	            <div align="center">
	            	<c:out value="Last Modified by ${lastMaintainedAppointmentsUserNameListFromLDAP[appointmentCount]} on ${appointment.maintenanceDateAsString}"  />
	            </div>	
			</c:if>
        </div>
        <div class="clear"></div>
    </div>
</stripes:layout-definition>
