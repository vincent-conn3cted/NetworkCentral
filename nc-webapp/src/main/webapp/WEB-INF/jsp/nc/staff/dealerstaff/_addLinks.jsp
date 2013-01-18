<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${readOnly}"/>
    <ul class="table-item-control-nav">
        <div id="dealerStaffAddPositionLinks">
            <c:if test="${!actionBean.readOnly}">
                <nc:ifAccessAllowed name="dealerStaff.positions.add.nonDpGmr">
                    <c:if test="${actionBean.dealerStaff.personId != null}">
                        <li>
                            <stripes:link id="addPositionForStaffLink"
                                          beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffPositionActionBean"
                                          event="add">
                                <stripes:param name="appointment.person.personId"
                                               value="${actionBean.dealerStaff.personId}"/>
                                <fmt:message key="dealerstaffsearch.action.addPosition"/>
                            </stripes:link>
                        </li>
                    </c:if>
                </nc:ifAccessAllowed>
            </c:if>
            <c:if test="${readOnly != true}">
                <nc:ifAccessAllowed name="dealerStaff.positions.add.dpGmr">
                    <c:if test="${actionBean.dealerStaff.personId != null}">
                        <li>
                            <stripes:link id="addDpGmrPositionForStaffLink"
                                          beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffPositionActionBean"
                                          event="addDpGmr">
                                <stripes:param name="appointment.person.personId"
                                               value="${actionBean.dealerStaff.personId}"/>
                                <fmt:message key="dealerstaffsearch.action.addDpGmrPosition"/>
                            </stripes:link>
                        </li>
                    </c:if>
                </nc:ifAccessAllowed>
            </c:if>
        </div>
    </ul>
</stripes:layout-definition>
