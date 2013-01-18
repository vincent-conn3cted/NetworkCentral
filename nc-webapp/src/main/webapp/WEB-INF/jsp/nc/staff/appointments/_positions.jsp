<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<%--<nc:pageName pageName="Appointments-Manage"/>--%>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${readOnly}"/>
<stripes:layout-definition>
    <script type="text/javascript">
        function changePosition(selectElement)
        {
        	toggleAddToSapCheckbox(selectElement);
			sendAjaxRequest(selectElement);		        	
        }
    
    	function toggleAddToSapCheckbox(selectElement)
        {
            var selectedValue = selectElement.value;
            var isSalesIndicator = (document.getElementById('eligiblePositionSalesStatus-' + selectedValue).innerHTML == 'true');
            var addToSapDivElement = document.getElementById('addToSapDiv');
            var addToSapSubmittableElement = document.getElementById('appointment.salesIndicator');
            addToSapSubmittableElement.checked = false;
            if(isSalesIndicator)
            {
                addToSapDivElement.style.display = 'block';
            }
            else
            {
                addToSapDivElement.style.display = 'none';
            }
        }
    	
    	function sendAjaxRequest(selectElement)
    	{
            if(selectElement.value != '')
            {
                <stripes:url var="url" beanclass="au.com.toyota.nc.webapp.stripes.staff.dealerstaff.DealerStaffPositionActionBean" event="getPositionDefinitionsAsPerSelectedPosition"/>
                var getUrl = "${url}&appointment.appointmentId=${actionBean.appointment.appointmentId}&selectedPositionId="+selectElement.value;
                getAjaxUpdate(getUrl, 'showPositionDefinition');
            }
            else
            {
                document.getElementById('showPositionDefinition').innerHTML = '';
            }
    	}
    	
    	$(document).ready(function() {
    		    
         	  var selectedPositionDefinitionId = $("#selectedPositionDefinitionId").val();
               
         	  if (isEmpty(selectedPositionDefinitionId))
    		       changePosition(document.getElementById('selectedPositionId'));
    	});
    	
    	function isEmpty(val){
    	    return (val === undefined || val == null || val.length <= 0) ? true : false;
    	}
    	

    </script>
    <span style="display:none;" id="eligiblePositionSalesStatus-">false</span>
    <c:forEach items="${eligiblePositions}" var="eligiblePosition">
        <span style="display:none;" id="eligiblePositionSalesStatus-<c:out value="${eligiblePosition.positionId}"/>"><c:out value="${eligiblePosition.sales}"/></span>
    </c:forEach>
    <span id="addPositionPositions">
        <nc:ifWriteAccessAllowed name="appointment.position.positionId">
            <stripes:label for="appointment.position.positionId" class="mandatory"/>
            <stripes:select name="selectedPositionId" id="selectedPositionId" onchange="changePosition(this);">
                <stripes:option value=""/>
                <stripes:options-collection collection="${eligiblePositions}" label="description" value="positionId"/>
            </stripes:select><br/>
	        <div id="showPositionDefinition">
	           <c:if test="${not empty actionBean.positionDefinitions}">
					<stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_eligiblePositionDefinition.jsp" pageName="${pageName}" readOnly="${readOnly}"/>
	           </c:if>
	        </div>
        </nc:ifWriteAccessAllowed>  

        <nc:ifReadOnlyAccess name="appointment.position.positionId">
            <stripes:hidden name="selectedPositionId"/>
            <stripes:label for="appointment.position.positionId"/>
            <span class="formValue"><c:out value="${actionBean.appointment.position.description}"/></span><br/>

           <c:if test="${not empty actionBean.positionDefinitions}">
				<stripes:layout-render name="/WEB-INF/jsp/nc/staff/appointments/_eligiblePositionDefinition.jsp" pageName="${pageName}" readOnly="${readOnly}"/>
           </c:if>
        </nc:ifReadOnlyAccess>
        
    </span>
</stripes:layout-definition>