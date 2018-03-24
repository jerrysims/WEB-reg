var ready;

// defines the function that will run when the DOM loads
ready = function() {

  // ...your javascript goes here...
  $("#load_tuition_preference_form").on('click', function(e){
    e.preventDefault();
    $("#tuition-preference-form-link").hide();
    $("#tuition-preference-actual-form").show();
  })

  $("#invoice_line_item_quantity_other").on('click', function(e){
    $("#invoice_line_item_other_quantity").focus()
  })

  $("input[number='true'][type='radio']").on('click', function(e){
    $("#invoice_line_item_other_quantity").val("")
  })


  var dropCourseDialog = "Are you sure you want to drop this course?"
  var addCourseDialog = "Are you sure you want to add this course?"
  var cancelButton = document.getElementById('cancel');
  var cancelButtons = document.getElementsByClassName('cancel');
  var submitButtons  = document.getElementsByClassName('submit');
  var reviewScheduleButtons = document.getElementsByClassName('review-schedule-button')

  // Clicking on course that is already selected opens a modal dialog
  var bindCourses = function(){
    var selectedCourse = document.getElementsByClassName('register-grid-class-card');
    for (var i = 0 ; i < selectedCourse.length; i++) {
      selectedCourse[i].addEventListener('click', function() {
        dialog = $(this).hasClass("registered") ? dropCourseDialog : addCourseDialog
        action = $(this).hasClass("registered") ? "drop_class" : "choose_class"
        course_id = $(this).data("course");
        student_id = $(this).data("student");
        newLocation = get_href(course_id, student_id, dialog, action)
        if (window.confirm(dialog)) {
          $.ajax({
            url: newLocation
          });
        }
      });
    }
  }

  bindCourses();

  var get_href = function(course_id, student_id, dialog, action) {
    href = "registrations/" + action + "?course_id=" + course_id + "&student_id=" + student_id
    return href
  }
};

$(document).ready(ready);
$(document).on('page:load', ready);
