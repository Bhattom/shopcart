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