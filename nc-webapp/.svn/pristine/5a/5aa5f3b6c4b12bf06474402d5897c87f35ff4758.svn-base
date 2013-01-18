<%@ page import="au.com.toyota.nc.common.utils.NCConstants" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.staff.AddStaffAgreementActionBean" %>
<%--<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean" %>--%>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<script type="text/javascript">
    function openAgreementDialog(eventName)
    {
        <%--url = '<stripes:url beanclass="au.com.toyota.nc.webapp.stripes.staff.AddStaffAgreementActionBean" event=""/>' + "?" + eventName;--%>
//        postAjaxForm('checkAgreementForm', url, 'agreementDialogBody');
//        YAHOO.au.com.toyota.widget.AgreementDialog.
//        YAHOO.util.get(document.getElementById("Me"));
        YAHOO.au.com.toyota.widget.agreementDialog.show();
    }

    function checkAgreementDialog(eventName)
    {
        url = '<stripes:url beanclass="au.com.toyota.nc.webapp.stripes.staff.AddStaffAgreementActionBean" event=""/>' + "?" + eventName;
        postAjaxForm('checkAgreementForm', url, 'agreementDialogBody');
        YAHOO.au.com.toyota.widget.AgreementDialog.show();
    }

    <%--function overwriteAgreementDialog(eventName)--%>
    <%--{--%>
        <%--url = '<stripes:url beanclass="au.com.toyota.nc.webapp.stripes.staff.AddStaffAgreementActionBean" event=""/>' + "?" + eventName;--%>
        <%--postAjaxForm('checkAgreementForm', url, 'agreementDialogBody');--%>
        <%--YAHOO.au.com.toyota.widget.AgreementDialog.show();--%>
    <%--}--%>

    function hideAgreementDialog()
    {
        YAHOO.au.com.toyota.widget.AgreementDialog.hide();
    }

    var agreementDialog = {
           onOk: function()
           {
               hideAgreementDialog();
           },
           initDialog : function(){
               <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp" okButtonText="Close"
                       dialogName="agreementDialog" dialogId="agreementDialog" okHandler="agreementDialog.onOk"/>
           }
       }

    dialogs.add(agreementDialog);
</script>


