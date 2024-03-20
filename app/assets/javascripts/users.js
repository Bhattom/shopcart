$(document).ready(function() {
    $('#new-product-link').click(function() {
      $('#new-product-popup').fadeIn();
    });
  
    $('#new-product-popup').on('ajax:success', function() {
      // Handle a successful form submission (e.g., close the popup)
      $(this).fadeOut();
    });
  
    // Add more JavaScript as needed for closing the popup on cancel, etc.
  });