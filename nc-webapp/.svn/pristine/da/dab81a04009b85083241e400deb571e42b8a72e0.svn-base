<%@ page import="au.com.toyota.nc.webapp.stripes.staff.AppointmentSourceActionType" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<script type="text/javascript">
    function confirmDiscontinueAppointment(positionName, fullName)
    {
        return confirm('Are you sure you want to discontinue position ' + positionName + ' from ' + fullName + '?');
    }

    function removeLanguage(anchorElement)
    {
        listElement = anchorElement.parentNode.parentNode;
        listElement.innerHTML = '';
        listElement.style.display = 'none';
    }

    function openAddLanguageBox()
    {
        YAHOO.au.com.toyota.widget.LanguageDialog.show();
    }

    function updateLanguages()
    {
        var newIndex=$("ul#selectedDealerStaffLanguages li").length;
        var existingLanguageList = document.getElementById('selectedDealerStaffLanguages').innerHTML;
        var languageSelectionList = document.getElementById('addLanguageId');
        var selectedOption = languageSelectionList.options[languageSelectionList.selectedIndex];
        additionalHtml = "<li>";
        additionalHtml += '<span class="selectedDealerStaffLanguagesValue"  style="margin-right: 1em;">';
        additionalHtml += selectedOption.innerHTML;
        additionalHtml += "</span>";
        additionalHtml += '<input type="hidden" name="selectedLanguages['+newIndex+'].commonValueId" value="'+selectedOption.value+'"/>';
        additionalHtml += '<input type="hidden" name="selectedLanguages['+newIndex+'].value" value="'+selectedOption.innerHTML+'"/>';
        additionalHtml += '<span class="selectedDealerStaffLanguagesRemoveLink">';
        additionalHtml += '<a href="#" onclick="removeLanguage(this);">Remove</a>';
        additionalHtml += "</span>";
        additionalHtml += "</li>";
        document.getElementById('selectedDealerStaffLanguages').innerHTML = existingLanguageList + additionalHtml
        YAHOO.au.com.toyota.widget.LanguageDialog.hide();
    }

    var languageBox = {
           onOk: function()
           {
               YAHOO.au.com.toyota.widget.LanguageDialog.hide();
           },
           initDialog : function(){
               <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp" okButtonText="Close"
                       dialogName="LanguageDialog" dialogId="languageDialogBox" okHandler="languageBox.onOk"/>
           }
       }

    dialogs.add(languageBox);
    function yuiLoadComplete(){
        // Save search initialisation & handling
        YAHOO.util.Event.onDOMReady(function(){
            YAHOO.au.com.toyota.widget.LanguageDialog = new YAHOO.widget.Dialog("languageDialogBox",
            {
                width: "30em",
                fixedcenter:true,
                visible:false,
                constraintoviewport : true
            });
            YAHOO.au.com.toyota.widget.LanguageDialog.render();
            
            var flagElem = $('#showConfirmationDialogFlag');
			if (flagElem && flagElem.val() == 'true'){
				openDealerStaffConfirmationDialog();
			}
			
			var flagElemAdmin = $('#showNationalAdminDuplicateConfirmationFlag');
			if (flagElemAdmin && flagElemAdmin.val() == 'true'){
				openNationalAdminDuplicateStaffConfirmationDialog();
			}
        });
    }
</script>