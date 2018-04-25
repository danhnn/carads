// Import the page's CSS. Webpack will know what to do with it.
import "../stylesheets/app.css";
import $ from "jquery";

window.Supplier = {
  start: function() {
    var self = this;
    console.log("Supplier start!")
  },

  fetch: async function() {
    const result = await $.ajax('https://api.github.com/users/defunkt');
    console.log(result)
  },

  setSupplierStatus: function(message) {
    var status = document.getElementById("status");
    status.innerHTML = message + "!!!!";
  },
};

