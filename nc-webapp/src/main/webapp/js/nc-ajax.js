function postAjaxForm(formId, postUrl, updateElementId)
{
    var ajaxFormFunctions = {
        success: function updateElement(o)
        {
            document.getElementById(updateElementId).innerHTML = o.responseText;
        }
    };

    YAHOO.util.Connect.setForm(document.getElementById(formId));
    YAHOO.util.Connect.asyncRequest('POST', postUrl, ajaxFormFunctions);
}

function getAjaxUpdate(getUrl, updateElementId)
{
    var ajaxGetFunctions = {
        cache:false,                   // this option is needed. Firefox doesnt cache HTTP GET, but IE does.
        success: function updateElement(o)
        {
            document.getElementById(updateElementId).innerHTML = o.responseText;
        }
    };

    YAHOO.util.Connect.asyncRequest('GET', getUrl, ajaxGetFunctions);
}
