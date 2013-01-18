<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<nc:pageName pageName="Appointments-Manage"/>
<stripes:layout-definition>
    <script type="text/javascript">
        function showLocationsForSelectedDealer(selectElement)
        {
            var selectedDealerId = selectElement.value;
            if(selectedDealerId != '')
            {
                var getUrl = '<stripes:url beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffPositionActionBean" event="${showLocationsEvent}"/>&selectedDealerId=' + selectedDealerId;
                getAjaxUpdate(getUrl, 'addPositionLocations');
            }
            else
            {
                document.getElementById('addPositionLocations').innerHTML = '';
            }
        }
    </script>    
    <span id="addPositionLocations">
        <c:if test="${actionBean.selectedDealerId != null}">
            <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_eligibleLocations.jsp" eligibleLocations="${actionBean.eligibleLocations}"/>
        </c:if>
    </span>
</stripes:layout-definition>