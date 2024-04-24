$(document).ready(function() {
    var page = 2;
    var loading = true; 
    
    function loadProducts() {
      if (!loading) {
        loading = true;
        $.ajax({
          url: '/products/products',
          data: { page: page },
          dataType: 'json',
          success: function(data) {
            if (data.length > 0) {
              data.forEach(function(product) {
                $('#product-list').append('<li>' + product.name + '</li>');
              });
              page++;
            } else {
              page = 1;
            }
            loading = false; 
          },
          error: function() {
            loading = false;
          }
        });
      }
    }
    
    // Call loadProducts initially
    loadProducts();
  
    // Scroll event listener
    $(window).scroll(function() {
      if ($(window).scrollTop() + $(window).height() >= $(document).height() - 100) {
        loadProducts(); // Load more products when user scrolls to bottom
      }
    });
  });
  