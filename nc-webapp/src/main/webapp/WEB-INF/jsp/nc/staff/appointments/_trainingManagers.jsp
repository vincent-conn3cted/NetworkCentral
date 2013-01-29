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
            	
            var personId = $("[name='appointment.person.personId']").val();
            if(selectedDealerId != '')
            {
                var getUrl = '<stripes:url beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffPositionActionBean" event="${showTrainingManagersEvent}"/>&selectedDealerId=' + selectedDealerId+'&dpGmrFlag='+dpGmrFlag+'&personId='+personId;
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
    
 
        <c:if test="${not empty requestScope.INVALID_TRAINING_APPROVAL_MANAGER}">
     			<script type="text/javascript">
      			$(document).ready(function(){
      				if($('select[name=appointment.trainingManager.appointmentId]').length > 0){
      					$('select[name=appointment.trainingManager.appointmentId]').css('background-color', '#ff8080');
      				}	
      				
      				$('select[name=appointment.trainingManager.appointmentId]').live('click', function(e) {
          				if($('select[name=appointment.trainingManager.appointmentId]').val() == '${requestScope.INVALID_TRAINING_APPROVAL_MANAGER}'){
          					$('select[name=appointment.trainingManager.appointmentId]').css('background-color', '#ff8080');
          				}else{
          					$('select[name=appointment.trainingManager.appointmentId]').css('background-color', '#ffffff');
          				}	
      				});
      			});	
     			</script>
		</c:if>  
    
    
</stripes:layout-definition>