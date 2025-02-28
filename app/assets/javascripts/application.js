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
//= require jquery3
//= require popper
//= require bootstrap
//= require rails-ujs
//= require_tree .
//= require bootstrap-datepicker

ready = function() {
  $('.submit-button').on('ajax:success', addStudent);

  function addStudent(event, data) {
    console.log("in addStudent")
  }

  canvas = document.getElementById('canvas');

  // Set canvas dimensions
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
};

$(document).ready(ready);
$(document).on('page:load', ready);
