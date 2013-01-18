<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${readOnly}"/>
    <script type="text/javascript">
        function togglePortalUserFields()
        {
            var portalUserFieldsDiv = document.getElementById('appointmentDealerPortalUserFields');
            if ( portalUserFieldsDiv.style.display != 'none' )
            {
                hidePortalUserFields(portalUserFieldsDiv);
            }
            else
            {
                portalUserFieldsDiv.style.display = '';
            }
        }

        function hidePortalUserFields(portalUserFieldsDiv)
        {
            portalUserFieldsDiv.style.display = 'none';
            document.getElementById('appointment.dripInfo.smsNumber').value = '';
            document.getElementById('appointment.dripInfo.smsOptIn').checked = false;
            document.getElementById('appointment.dripInfo.emailOptIn').checked = false;
        }
    </script>
        <fieldset>
            <legend class="legend"><fmt:message key="positions.section.systeminformation"/></legend>
                    <stripes:label name="appointment.activeForToyotaSystems" for="appointment.activeForToyotaSystems"/>
                    <input type="checkbox" readonly="readonly" checked="checked" disabled="disabled" id="appointment.activeForToyotaSystems"/><br/>

                    <nc:ifWriteAccessAllowed name="appointment.dealerPortalUser">
                        <stripes:label name="appointment.dealerPortalUser" for="appointment.dealerPortalUser"/>
                        <stripes:checkbox name="appointment.dripInfo.user" id="appointment.dealerPortalUser" onclick="togglePortalUserFields();"/><br/>
                    </nc:ifWriteAccessAllowed>
            
                    <c:set var="dripStyle" value=""/>
                    <c:if test="${not actionBean.appointment.dripInfo.user}">
                        <c:set var="dripStyle" value="display:none;"/>
                    </c:if>
                    <span  id="appointmentDealerPortalUserFields" style="<c:out value="${dripStyle}"/>">
                            <nc:label name="appointment.dripInfo.emailOptIn" for="appointment.dripInfo.emailOptIn"/>
                            <nc:checkbox name="appointment.dripInfo.emailOptIn" id="appointment.dripInfo.emailOptIn"/><br/>

                            <nc:label name="appointment.dripInfo.smsOptIn" for="appointment.dripInfo.smsOptIn"/>
                            <nc:checkbox name="appointment.dripInfo.smsOptIn" id="appointment.dripInfo.smsOptIn"/><br/>

                            <nc:label name="appointment.dripInfo.smsNumber" for="appointment.dripInfo.smsNumber"/>
                            <nc:text name="appointment.dripInfo.smsNumber" id="appointment.dripInfo.smsNumber"/><br/>
                    </span>

                    <nc:label name="appointment.sapInfo.username" for="appointment.sapInfo.username"/>
                    <nc:text name="appointment.sapInfo.username" id="appointment.sapInfo.username"/><br/>
                    <c:choose>
                        <c:when test="${actionBean.appointment.sapInfo.sapUsernameActive}">
                            <c:set var="currentSapUsernameStatus" value="Validated"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="currentSapUsernameStatus" value="Not Validated"/>
                        </c:otherwise>
                    </c:choose>

                    <nc:label name="appointment.sapInfo.sapUsernameActive" for="appointment.sapInfo.sapUsernameActive"/>
                    <nc:select name="appointment.sapInfo.sapUsernameActive" id="sapUsernameActiveSelectionList" readOnlyValue="${currentSapUsernameStatus}">
                        <stripes:option label="Not Validated" value="false"/>
                        <stripes:option label="Validated" value="true"/>
                    </nc:select><br/>
        </fieldset>    
</stripes:layout-definition>
