<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<nc:pageName pageName="Appointments-Manage"/>
<stripes:layout-definition>
    <script type="text/javascript">
        function showTrainingManagersForSelectedDealer(selectElement)
        {
            <c:choose>
	            <c:when test="${not empty isDpGmrFlag}">
	        		var dpGmrFlag = 1;
	            </c:when>
	            <c:otherwise>
	    			var dpGmrFlag = 0;
	            </c:otherwise>
    		</c:choose> 
        	
            var selectedDealerId = selectElement.value;
            if(selectedDealerId != '')
            {
                var getUrl = '<stripes:url beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffPositionActionBean" event="${showTrainingManagersEvent}"/>&selectedDealerId=' + selectedDealerId+'&dpGmrFlag='+dpGmrFlag;
                getAjaxUpdate(getUrl, 'addTrainingManagers');
            }
            else
            {
                document.getElementById('addTrainingManagers').innerHTML = '';
            }
            
        }
    </script>    
    <span id="addTrainingManagers">
        <c:if test="${actionBean.selectedDealerId != null or (actionBean.appointment != null and actionBean.appointment.appointmentId != null)}">
            <stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_eligibleTrainingManagers.jsp" eligibleTrainingManagers="${actionBean.trainingManagers}"/>
        </c:if>
    </span>
</stripes:layout-definition>