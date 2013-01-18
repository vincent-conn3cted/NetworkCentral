<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<script type="text/javascript">
	initiateDialogVariable();
	
	function openSaveConfirmationDialog() {
		YAHOO.au.com.toyota.widget.saveConfirmationDialog.show();
	}
	
	function closeSaveDialog() {
		 YAHOO.au.com.toyota.widget.saveConfirmationDialog.hide();
	}
	
	function initiateDialogVariable(){
		var saveConfirmationDialog = {
				initDialog : function(){
				   <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp" dialogName="saveConfirmationDialog" dialogId="saveConfirmationDialog" noButtons="true" />
				}
		};
		
		dialogs.add(saveConfirmationDialog);	
	}
</script>

<div id="saveConfirmationDialog" name="saveConfirmationDialog" class="dialog dialogWithDefaultCloseButton">
	<div class="hd">Warning</div>
	<div class="bd">
		<p>
			You have changed one or more fields on this screen. <br/>
			Please confirm that you want to save the changes.
		</p>
		<stripes:submit name="${param['saveEvent']}" class="btn btn_ok" value="saveButtonInConfirmaitonDialog" />
	<input type="button" class="btn btn_cancel" onclick="closeSaveDialog();" />
	</div>
</div>


<stripes:button class="btn btn_save" name="saveButtonInConfirmationSaveDialog" value="saveButtonInConfirmationSaveDialog" onclick="openSaveConfirmationDialog()">Save</stripes:button>

