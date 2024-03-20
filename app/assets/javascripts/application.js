//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require popper
//= require bootstrap
//= require bootstrap.bundle.min


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