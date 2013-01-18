<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<nc:pageName pageName="Appointments-Manage"/>
<stripes:layout-definition>
        <nc:ifWriteAccessAllowed name="appointment.dealer.dealerId">
            <stripes:label for="appointment.dealer.dealerId"  class="mandatory"/>
            <stripes:select name="appointment.dealer.dealerId" id="appointment.dealer.dealerId" onchange="showLocationsForSelectedDealer(this);showTrainingManagersForSelectedDealer(this);">
                <stripes:option value=""/>
                <stripes:options-collection collection="${actionBean.eligibleDealerships}" label="generalInfo.dealerName" value="dealerId"/>
            </stripes:select><br/>            
        </nc:ifWriteAccessAllowed>
</stripes:layout-definition>
