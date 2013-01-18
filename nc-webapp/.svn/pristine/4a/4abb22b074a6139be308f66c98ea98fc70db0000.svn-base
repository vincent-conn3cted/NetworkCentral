<%@ page import="au.com.toyota.nc.common.utils.NCConstants" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    
    <ul class="column-style-fieldset oneCol">
        <li>
                <!--- =====     Start Dates Info =========================== -->
                <fieldset id="generalInfo-datesSection">
                    <legend class="legend">Dates</legend>
                    <nc:ifAccessAllowed name="location.appointmentDate">
                        <stripes:label name="label.appointmentDate" for="location.appointmentDate"/>
                        <c:choose>
                            <c:when test="${actionBean.location.status.draft}">
                                <span id="location.appointmentDate">
                                    <fmt:formatDate value="${actionBean.location.appointmentDate}" pattern="<%= NCConstants.FORMAT_DD_MM_YYYY_HH_mm%>"/>
                                </span>
                            </c:when>
                            <c:otherwise>
                                <nc:datetext name="location.appointmentDate" id="location.appointmentDate" class="dateField"
                                             buttonId="historicalAppointmentDateTrigger" showTime="true"/>
                            </c:otherwise>
                        </c:choose>
                        <br/>
                    </nc:ifAccessAllowed>

                    <c:if test="${actionBean.location.allowViewingCessationFields}">
                        <nc:ifAccessAllowed name="location.cessationDate">
                            <div>
                                <stripes:label name="label.cessationDate" for="location.cessationDate"/>
                            </div>
                            <c:choose>
                                <c:when test="${actionBean.location.status.active}">
                                    <span id="location.cessationDate">
                                        <fmt:formatDate value="${actionBean.location.cessationDate}" pattern="<%= NCConstants.FORMAT_DD_MM_YYYY_HH_mm%>"/>
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <nc:datetext name="location.cessationDate" id="location.cessationDate" class="dateField"
                                                 buttonId="historicalCessationDateTrigger" showTime="true"/>                                    
                                </c:otherwise>
                            </c:choose>
                            <br/>
                        </nc:ifAccessAllowed>
                        <nc:ifAccessAllowed name="location.cessationReason">
                            <stripes:label name="label.cessationReason" for="location.cessationReason"/>
                            <c:choose>
                                <c:when test="${actionBean.location.status.active}">
                                    <span id="location.cessationReason">
                                        <c:out value="${actionBean.location.cessationReason}"/>
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <nc:textarea name="location.cessationReason" id="location.cessationReason"/>
                                </c:otherwise>
                            </c:choose>
                            <br/>
                        </nc:ifAccessAllowed>
                        <nc:ifAccessAllowed name="location.franchiseCodeEvent.commonValueId">
                            <stripes:label name="label.franchiseCodeEvent" for="location.franchiseCodeEvent.commonValueId"/>
                            <c:choose>
                                <c:when test="${actionBean.location.status.active}">
                                    <span id="location.franchiseCodeEvent.commonValueId.readonly">
                                        <c:out value="${actionBean.location.franchiseCodeEvent.value}"/>
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <nc:select-active-values selectedObject="${actionBean.location.franchiseCodeEvent}"
                                                     valueAttribute="commonValueId"
                                                     labelAttribute="value"
                                                     collections="${actionBean.allFranchiseCodeEvent}"
                                                     name="location.franchiseCodeEvent.commonValueId"
                                                     id="location.franchiseCodeEvent.commonValueId">
                                        <option value=""><fmt:message key="label.selectone"/></option>
                                    </nc:select-active-values>                                    
                                </c:otherwise>
                            </c:choose>
                            <br/>
                        </nc:ifAccessAllowed>
                    </c:if>
                </fieldset>
             <!--- =====     End Dates Info  =========================== -->
        </li>
    </ul>


</stripes:layout-definition>