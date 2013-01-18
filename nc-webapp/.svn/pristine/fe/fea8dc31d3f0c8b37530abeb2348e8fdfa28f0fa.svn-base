<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<script type="text/javascript">
    function openChangeLocationTypeDialog(locationId)
    {
        <stripes:url beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ChangeLocationTypeActionBean" event="show" var="showChangeLocationTypeUrl">
            <stripes:param name="showAsReadOnly" value="${actionBean.showAsReadOnly}"/>
            <stripes:param name="lastTabShown" value="${actionBean.lastTabShown}"/>
        </stripes:url>
        url = "<c:out value="${showChangeLocationTypeUrl}" escapeXml="false"/>" + "&locationId=" + locationId;
        getAjaxUpdate(url, 'changeLocationTypeDialogBody');
        YAHOO.au.com.toyota.widget.ChangeLocationTypeDialog.show();
    }

    var changeLocationTypeDialog = {
           onOk: function()
           {
               YAHOO.au.com.toyota.widget.ChangeLocationTypeDialog.hide();
           },
           initDialog : function(){
               <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp" okButtonText="Close"
                       dialogName="ChangeLocationTypeDialog" dialogId="changeLocationTypeDialog" okHandler="changeLocationTypeDialog.onOk"/>
           }
       };

</script>
