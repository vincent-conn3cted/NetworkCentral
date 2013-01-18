<%@ page import="au.com.toyota.nc.webapp.stripes.staff.AppointmentSourceActionType" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${readOnly}"/>
    <nc:ifAccessAllowed name="dealerStaff.languages">
        <div id="dealerStaffLanguages">
            <div>
                <div>
                    <label><fmt:message key="dealerstaffsearch.language.addLink.label"/></label>                    
                </div>
                <div>
                    <nc:ifWriteAccessAllowed name="dealerStaff.languages">
                        <a id="addLocationLink" href="#" onclick="openAddLanguageBox();return false;"><fmt:message key="dealerstaffsearch.language.addLink"/></a>
                    </nc:ifWriteAccessAllowed>
                </div>
            </div>
            <!-- show languages -->
            <ul id="selectedDealerStaffLanguages">
                <c:forEach items="${actionBean.selectedLanguages}" var="language" varStatus="languageStatus">
                    <li>
                        <span class="selectedDealerStaffLanguagesValue" style="margin-right:1em;"><c:out value="${language.value}"/>
                            <input type="hidden" name="selectedLanguages[${languageStatus.index}].commonValueId" value="<c:out value="${language.commonValueId}"/>"/>
                            <input type="hidden" name="selectedLanguages[${languageStatus.index}].value" value="<c:out value="${language.value}"/>"/>
                            &nbsp;
                        </span>
                        <nc:ifWriteAccessAllowed name="dealerStaff.languages">
                            <span class="selectedDealerStaffLanguagesRemoveLink"><a href="#" onclick="removeLanguage(this);">Remove</a></span>
                        </nc:ifWriteAccessAllowed>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </nc:ifAccessAllowed><div class="clear"></div>
</stripes:layout-definition>
