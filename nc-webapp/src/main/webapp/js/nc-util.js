/**
 * Update the index of the given element (at the 'name' attribute) with the supplied new index
 *
 * @param elem the element - jQuery object
 * @param newIndex - the new index to be used
 */
function updateElementIndex(elem, newIndex) {
    var currentName = elem.attr("name");
    var newName = currentName.replace(/\[\d+\]/, "[" + newIndex + "]");
    elem.attr("name", newName);
}

/**
 * Add row to a table, taking care of any input/textarea inside the row, updating the index as well
 *
 * @param tableId the HTML ID of the table where we want to add the new row
 * @param size the number of new rows to be added to the table
 */
function addRow(tableId, size) {
    for (var i = 0; i < size; i++) {
        // need to capture the new row index prior to adding new row
        var newRowIndex = $("#" + tableId + "  tbody:first  tr").length;

        // we clone the last row of the table, then iterate through each column of the row
        var clonedRow = $("#" + tableId + "  tbody:first  tr:last-child").clone();
        clonedRow.find("td").each(function() {
            // iterate through each input, and update the index, and empty out the value
            $(this).find("input,textarea").each(function() {
                updateElementIndex($(this), newRowIndex);
                $(this).val("");
            });

            // Finally, if the column contain element with "deleteLink" class, then we attach the delete behaviour.
            $(this).find(".deleteLink").each(function(){
                attachDeleteBehaviourWithFlagField($(this));
            });
        });
        $("#" + tableId).append(clonedRow);
    }
}


/**
 * Given a jQuery object, find the nearest row (<tr>) element, and delete from the corresponding <tbody> element.
 * Also update the index of each input/textarea element of the table.
 *
 * @param the jQuery object from which the event propagates. i.e. this jQuery object must sit inside the <td> element
 * of the table which contains the row to be deleted.
 */
function attachDeleteBehaviour(element) {
    element.click(function(event) {
        // First we need handler to the tbody
        var tbody = $(this).closest("tbody");

        // Find the row to delete, and remove it
        var rowToDelete = $(this).closest("tr");
        rowToDelete.remove();

        // Traverse through the rows of the tbody, and update each input/textarea with the new index
        tbody.find("input,textarea").each(function() {
            var closestRow = $(this).closest("tr").get(0);
            var index = closestRow.rowIndex;
            updateElementIndex($(this), index);
        });

        // Stop propagation
        event.preventDefault();
    });
}

/**
 * Given a jQuery object, find the nearest row, and then find all hidden input with class 'fkField', and nullify them
 *
 * @param element the jQuery object from which the event propagates. i.e. this jQuery object must sit inside the <td> element
 * of the table which contains the row with hidden fkField input element.
 */
function attachDeleteBehaviourWithFK(element){
    element.click(function(event) {
        // Find the row to delete, and hide it
        var rowToDelete = $(this).closest("tr");
        rowToDelete.hide();

        rowToDelete.find("input.fkField").each(function(){
            $(this).val("");
        });

        // Stop propagation
        event.preventDefault();
    });
}

/**
 * Attach delete behaviour to the given element. It will look at the closest row parent,
 * then find input with class 'removeFlagField', and set the value as 'true'.
 * It is expected that the backend will use this value to trigger deletion of this item.
 *
 * Additionally, if 'rowCallback' is supplied, it will be called with the row that will be deleted.
 *
 * @param element
 * @param rowCallback
 */
function attachDeleteBehaviourWithFlagField(element, rowCallback){
    element.click(function(event) {
        // Find the row to delete, and hide it
        var rowToDelete = $(this).closest("tr");
        rowToDelete.hide();

        rowToDelete.find("input.removeFlagField").each(function(){
            $(this).val("true");
        });

        if (rowCallback!=null){
            rowCallback(rowToDelete);
        }

        // Stop propagation
        event.preventDefault();
    });
}

function attachTableColumnEditBehaviour(element, functionName){
    element.click(function(event){
        functionName($(this).closest("tr"),event);
        YAHOO.util.Event.preventDefault(event);
    });
}


function getNewRowIndex(tableId){
    return $("table#"+tableId +" tbody tr").length;
}


/**
 *  Make checkboxes with class 'readonly' to be readonly - return false on click
 */
function disableReadOnlyCheckboxes(){
    $("input[type=checkbox].readonly").click(function(){
        return false;
    });
}


/**
 *Truncate the given value to the specified length
 */
function truncate(value,length){
    if (value.length < length)
        return value;
    return value.substring(0,length) + "...";
}


menu_status = new Array();

function showHide(theid){
    if (document.getElementById) {
    	var switch_id = document.getElementById(theid);

        if(menu_status[theid] != 'show') {
           switch_id.className = 'show';
           menu_status[theid] = 'show';
        }else{
           switch_id.className = 'hide';
           menu_status[theid] = 'hide';
        }
    }
}
function hide(id) {
	//safe function to hide an element with a specified id
	if (document.getElementById) { // DOM3 = IE5, NS6
		document.getElementById(id).style.display = 'none';
	}
	else {
		if (document.layers) { // Netscape 4
			document.id.display = 'none';
		}
		else { // IE 4
			document.all.id.style.display = 'none';
		}
	}
}

function show(id) {
	//safe function to show an element with a specified id

	if (document.getElementById) { // DOM3 = IE5, NS6
		document.getElementById(id).style.display = 'block';
	}
	else {
		if (document.layers) { // Netscape 4
			document.id.display = 'block';
		}
		else { // IE 4
			document.all.id.style.display = 'block';
		}
	}
}
