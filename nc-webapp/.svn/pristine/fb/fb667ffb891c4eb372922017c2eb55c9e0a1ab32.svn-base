<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<script type="text/javascript">
	function changeStatusPopup()
	{
		if("${param['status']}" == "Active"){
			openChangeStatusConfirmationDialog();
		}
		else {
			submitChangeStatusForm();
		}
	}

	function openChangeStatusConfirmationDialog() {
		YAHOO.au.com.toyota.widget.ChangeStatusConfirmationDialog.show();
    }
		
	function submitChangeStatusForm()
	{
		$('#changeStatus').submit();
	}
	
	function closeChangeStatusDialog() {
		 YAHOO.au.com.toyota.widget.ChangeStatusConfirmationDialog.hide();
	}


   	var ChangeStatusConfirmationDialog = {
           initDialog : function(){
              <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp" dialogName="ChangeStatusConfirmationDialog" dialogId="ChangeStatusConfirmationDialog" noButtons="true" />
              
           }
   	};
        
   	dialogs.add(ChangeStatusConfirmationDialog);
</script>

<div id="ChangeStatusConfirmationDialog" class="dialog dialogWithDefaultCloseButton">
	<div class="hd">Warning</div>
	<div class="bd">
		<p style="color: #232B33">Are you sure you want to change status from Active to Inactive?</p>
		<input type="button" class="btn btn_ok" onclick="submitChangeStatusForm()" />
		<input type="button" id="myCloseButton" class="btn btn_cancel" onclick="closeChangeStatusDialog();" />
	</div>
</div>


<c:if test="${param['idValue'] != null && param['idValue'] != ''}">
   <stripes:form beanclass="${param['beanclass']}" name="changeStatus" id="changeStatus" method="post">
     <stripes:hidden name="_eventName" value="${param['eventName']}" />
     <div id="entityStatusSection">
            <div class="right">
            	${param['status']}
                <a id="changeStatusLink" onclick="changeStatusPopup()">
                    <span id="changeStatusImage"></span>
                </a>
                <input type="hidden" name="${param['idName']}" value="${param['idValue']}" />
            </div>
     </div>

</stripes:form>
</c:if>
<div class="clear"></div>

