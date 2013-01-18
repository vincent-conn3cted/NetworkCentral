<%@ page import="au.com.toyota.nc.common.utils.NCConstants" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <%-- ==========================================
    Secure page stuffs
    =============================================--%>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

        <nc:ifAccessAllowed name="dealer.generalInfo.appointmentDate">
            <stripes:label name="label.appointmentDate" for="dealer.generalInfo.appointmentDate"/>
            <c:choose>
                <c:when test="${actionBean.dealer.generalInfo.status.draft}">
                    <span id="dealer.generalInfo.appointmentDate" class="formValue">
                        <fmt:formatDate value="${actionBean.dealer.generalInfo.appointmentDate}" pattern="<%= NCConstants.FORMAT_DD_MM_YYYY_HH_mm%>"/>
                    </span>
                </c:when>
                <c:otherwise>
                    <nc:datetext buttonId="historicalAppointmentDateTrigger" name="dealer.generalInfo.appointmentDate"
                                 id="dealer.generalInfo.appointmentDate" showTime="true"/>
                </c:otherwise>
            </c:choose>
            <br/>
        </nc:ifAccessAllowed>

        <c:if test="${actionBean.dealer.allowViewingCessationFields}">
            <nc:ifAccessAllowed name="dealer.generalInfo.cessationDate">
                <stripes:label name="label.cessationDate" for="dealer.generalInfo.cessationDate"/>
                <c:choose>
                    <c:when test="${actionBean.dealer.generalInfo.status.active}">
                        <span id="dealer.generalInfo.cessationDate" class="formValue">
                            <fmt:formatDate value="${actionBean.dealer.generalInfo.cessationDate}" pattern="<%= NCConstants.FORMAT_DD_MM_YYYY_HH_mm%>"/>
                        </span>
                    </c:when>
                    <c:otherwise>
                        <nc:datetext buttonId="historicalCessationDateTrigger" name="dealer.generalInfo.cessationDate"
                                     id="dealer.generalInfo.cessationDate" showTime="true"/>
                    </c:otherwise>
                </c:choose>
                <br/>
            </nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealer.generalInfo.cessationReason">
                <stripes:label name="label.cessationReason" for="dealer.generalInfo.cessationReason"/>
                <c:choose>
                    <c:when test="${actionBean.dealer.generalInfo.status.active}">
                        <span id="dealer.generalInfo.cessationReason" class="formValue">
                            <c:out value="${actionBean.dealer.generalInfo.cessationReason}"/>
                        </span>
                    </c:when>
                    <c:otherwise>
                        <nc:textarea name="dealer.generalInfo.cessationReason" id="dealer.generalInfo.cessationReason"/>
                    </c:otherwise>
                </c:choose>
                <br/>
            </nc:ifAccessAllowed>
            <nc:ifAccessAllowed name="dealer.generalInfo.franchiseCodeEvent.commonValueId">
                <stripes:label name="label.franchiseCodeEvent" for="dealer.generalInfo.franchiseCodeEvent.commonValueId"/>
                <c:choose>
                    <c:when test="${actionBean.dealer.generalInfo.status.active}">
                        <span id="dealer.generalInfo.franchiseCodeEvent.commonValueId" class="formValue">
                            <c:out value="${actionBean.dealer.generalInfo.franchiseCodeEvent.value}"/>
                        </span>
                    </c:when>
                    <c:otherwise>
                        <nc:select-active-values selectedObject="${actionBean.dealer.generalInfo.franchiseCodeEvent}"
                                         valueAttribute="commonValueId"
                                         labelAttribute="value"
                                         collections="${actionBean.allFranchiseCodeEvent}"
                                         name="dealer.generalInfo.franchiseCodeEvent.commonValueId"
                                         id="dealer.generalInfo.franchiseCodeEvent.commonValueId">
                            <option value=""><fmt:message key="label.selectone"/></option>
                        </nc:select-active-values>
                    </c:otherwise>
                </c:choose>
                <br/>
            </nc:ifAccessAllowed>
        </c:if>

</stripes:layout-definition>