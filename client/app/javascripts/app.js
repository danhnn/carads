// Import the page's CSS. Webpack will know what to do with it.
import "../stylesheets/app.css";
import $ from "jquery";

window.App = {
  start: function() {
    console.log("App start");
    var self = this;
  },

  setStatus: function(message) {
    var status = document.getElementById("status");
    status.innerHTML = message;
  },

  fetch: async function() {
    const result = await $.ajax('https://api.github.com/users/defunkt');
    console.log(result)
  },

  navigate: function(page) {
    if (page == "driver") {
      window.location.href = "/driver.html";
    }
    if (page == "supplier") {
      window.location.href = "/supplier.html";
    }
  }
};

window.addEventListener('load', function() {
  App.start();
});
