function showExpandLink(rowName)
{
    if(document.getElementById(rowName + "CollapseLink") != null)
    {
        document.getElementById(rowName + "CollapseLink").style.display = 'none';
        document.getElementById(rowName + "ExpandLink").style.display = 'inline';
    }
}

function hideExpandLink(rowName)
{
    if(document.getElementById(rowName + "CollapseLink") != null)
    {
        document.getElementById(rowName + "ExpandLink").style.display = 'none';
        document.getElementById(rowName + "CollapseLink").style.display = 'inline';
    }
}

function expandRow(rowName)
{
    $("tr[parent='" + rowName + "']").show();
    hideExpandLink(rowName);
    return false;
}

function collapseRow(rowName)
{
    $("tr[parent='" + rowName + "']").hide();
    showExpandLink(rowName);
    $.each($("tr[parent='" + rowName + "']"), function(index, obj)
    {
        collapseRow(obj.getAttribute("id"));
    });
    return false;
}



