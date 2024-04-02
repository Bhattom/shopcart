document.addEventListener("DOMContentLoaded", function() {
    var activateButton = document.getElementById("activateButton");
  
    if (activateButton) {
      activateButton.addEventListener("click", function() {
        console.log("Button clicked! Activate functionality here.");
        activateButton.classList.toggle("active");
    });
   }
});
