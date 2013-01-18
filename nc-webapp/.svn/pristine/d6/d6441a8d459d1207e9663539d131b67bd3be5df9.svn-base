<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<script type="text/javascript">
    function openMailingLabelDialog()
    {
        url = '<stripes:url beanclass="${param['mailingLabelBeanClass']}" event="withNoAddress"/>';
        postAjaxForm('mailingLabelForm', url, 'mailingLabelDialogBody');
        YAHOO.au.com.toyota.widget.MailingLabelDialog.show();
    }

    var mailingLabelDialog = {
           onOk: function()
           {
               YAHOO.au.com.toyota.widget.MailingLabelDialog.hide();
           },
           initDialog : function(){
               <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp" okButtonText="Close"
                       dialogName="MailingLabelDialog" dialogId="mailingLabelDialog" okHandler="mailingLabelDialog.onOk"/>
           }
       }

    dialogs.add(mailingLabelDialog);
    
</script>