// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .


$(document).ready (function() {
  $(".alert").fadeTo(2000, 500).slideUp(500);

  setupToggleSearchSelector();
});

function setupToggleSearchSelector() {
  $("#search-selector li").on("click", function() {
    var selected_string = $(this).find("a").html();
    if (__user_id && selected_string == "my bookshelf") {
      $("#search-form").attr("action", "/users/"+ __user_id + "/search");
    }
    else {
      $("#search-form").attr("action", "/search");
    }
      $("#search-selector-btn").html(selected_string);
    $("#search-field").prop("placeholder", "search in " + selected_string );
  });
}
