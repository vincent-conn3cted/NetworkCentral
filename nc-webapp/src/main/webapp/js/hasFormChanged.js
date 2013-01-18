var formChanged = false;

$(document).ready(function() {

     $('input, textarea').each(function (i) {
          $(this).data('initial_value', $(this).val());
     });

     $('input, textarea').keyup(function() {
          if ($(this).val() != $(this).data('initial_value')) {
               handleFormChanged();
          }
     });

     $('input, textarea').bind('change', function() {
          if ($(this).val() != $(this).data('initial_value')) {
               handleFormChanged();
          }
     });

     $('form').bind('change paste', function() {
          handleFormChanged();
     });

     $('form').bind('change paste', function() {
          handleFormChanged();
     });

     $('a').bind("click", function () {
          return confirmNavigation();
     });

         $('form').bind("submit", function () {
          return confirmNavigation();
     });

         $('#saveButton').bind("click", function() {
                                        formChanged = false;
        });

         $('#saveLocationButton').bind("click", function() {
                                        formChanged = false;
        });


         $('#addOperatingEntityButton,#removeGroupButton').bind("click", function() {
                                        handleFormChanged();
        });

         $('a.addItemToTableLink, a.addTMCARepLink,button.calendarTriggerBtn,a.editLink,a.deleteLink,#fileTable.a').bind("click", function() {
                                        handleFormChanged();
        });
});

function handleFormChanged() {
     formChanged = true;
}

function confirmNavigation() {
     if (formChanged) {
          return confirm('You have changed one or more fields on the screen without saving them. Do you wish to nativate away from this screen? (Click Ok to proceed, Cancel to stay on page)');
     } else {
          return true;
     }
}
