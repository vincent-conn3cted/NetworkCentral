<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<script type="text/javascript">
    function openSaveSearchDialog(eventName)
    {
        url = '<stripes:url beanclass="au.com.toyota.nc.webapp.stripes.savedsearch.SaveSearchActionBean" event=""/>' + "?" + eventName;
        postAjaxForm('saveSearchForm', url, 'saveSearchDialogBody');
        YAHOO.au.com.toyota.widget.SaveSearchDialog.show();
    }

    function saveSaveSearchDialog(eventName)
    {
        url = '<stripes:url beanclass="au.com.toyota.nc.webapp.stripes.savedsearch.SaveSearchActionBean" event=""/>' + "?" + eventName;
        postAjaxForm('saveSearchLabelForm', url, 'saveSearchDialogBody');
        YAHOO.au.com.toyota.widget.SaveSearchDialog.show();
    }

    function overwriteSaveSearchDialog(eventName)
    {
        url = '<stripes:url beanclass="au.com.toyota.nc.webapp.stripes.savedsearch.SaveSearchActionBean" event=""/>' + "?" + eventName;
        postAjaxForm('saveSearchOverwriteForm', url, 'saveSearchDialogBody');
        YAHOO.au.com.toyota.widget.SaveSearchDialog.show();
    }

    function hideSaveSearchDialog()
    {
        YAHOO.au.com.toyota.widget.SaveSearchDialog.hide();
    }

    var saveSearchDialog = {
           onOk: function()
           {
               hideSaveSearchDialog();
           },
           initDialog : function(){
               <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp" dialogName="SaveSearchDialog"
                       dialogId="saveSearchDialog" noButtons="true" />
           }
       }

    dialogs.add(saveSearchDialog);
</script>