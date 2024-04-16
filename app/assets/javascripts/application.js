//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require popper
//= require bootstrap
//= require bootstrap.bundle.min
//= require font-awesome


import "jquery"
import "jquery_ujs"
import "./jquery_ui"



$(document).ready(function() {
    $('.increase-quantity').click(function(event) {
      event.preventDefault();
    });
    $('.decrease-quantity').click(function(event) {
      event.preventDefault();
    });
});


$(document).ready(function() {
  var disabledIndices = [];
  $('.breadcrumb-item').click(function(event) {
    var clickedIndex = $(this).index();
    // Add clicked all previous indices to the disabledIndices array
    for (var i = 0; i <= clickedIndex; i++) {
      if (!disabledIndices.includes(i)) {
        disabledIndices.push(i);
      }
    }
    // Disable breadcrumb items based on disabledIndices array
    $('.breadcrumb-item').each(function(index) {
      if (disabledIndices.includes(index)) {
        $(this).addClass('disabled');
        $(this).removeAttr('href');
      }
    });
  });
});