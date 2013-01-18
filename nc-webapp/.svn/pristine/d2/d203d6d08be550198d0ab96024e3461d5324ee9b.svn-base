<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<%--
    Initiates an AJAX request and pulls the HTML response straight into the popup box. There should be a DIV
    with the id ${dialogId} and a content div inside with the id ${dialogId}Content. The HTML response will be
    chucked straight into the ${dialogId}Content div layer, and the overall ${dialogId} element displayed.

    The URL that is hit is the url of the stripes link element

    Parameters:
        dialogId - div id of the popup dialog

    e.g.:
        <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.dealerchangeover.ProcessDealerChangeoverActionBean"
                      event="newChangeover"
                      onclick="ajaxPopupBoxFor_newDealerPopup(this);return false;">

                      ...

        <div id="newDealerPopup">
            <div id="newDealerPopupContent" />
        </div>

                      ...
                      
        <stripes:layout-render name="/WEB-INF/jsp/layout/_ajaxPopupBox.jsp" dialogId="newDealerPopup"/>
--%>
<stripes:layout-definition>

    YAHOO.au.com.toyota.widget.${dialogId}AjaxDialog = new YAHOO.widget.Dialog("${dialogId}",
    {
        fixedcenter:true,visible:false,constraintoviewport : true,
        buttons : []
    });
    YAHOO.au.com.toyota.widget.${dialogId}AjaxDialog.render(document.body);

        var htmlTextResponseHandler = {
            handleSuccess: function(transport)
            {
                try
                {
                    document.getElementById("${dialogId}Content").innerHTML = transport.responseText;
                }
                catch(e)
                {
                    alert("An error has occurred while interpreting data from server " + e);
                }
            },
            handleFailure: function(transport)
            {
                alert("Failed to load data from server!");
            }
        };

        function ajaxPopupBoxFor_${dialogId}(linkElement)
        {
            YAHOO.util.Connect.asyncRequest('GET', linkElement.href,
            {
                success: htmlTextResponseHandler.handleSuccess,
                failure: htmlTextResponseHandler.handleFailure
            });
            YAHOO.au.com.toyota.widget.${dialogId}AjaxDialog.show();
        }

</stripes:layout-definition>

