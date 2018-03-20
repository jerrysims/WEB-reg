var ready;

// defines the function that will run when the DOM loads
ready = function() {

  // ...your javascript goes here...
  $("#load_tuition_preference_form").on('click', function(e){
    e.preventDefault();
    $("#tuition-preference-form-link").hide();
    $("#tuition-preference-actual-form").show();

  })

  var dropCourseDialog = document.getElementById('drop-course-dialog');
  var addCourseDialog = document.getElementById('add-course-dialog');
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
        course_id = $(this).data("course");
        student_id = $(this).data("student");
        update_href(course_id, student_id, dialog)
        dialog.showModal();
      });
    }
  }

  bindCourses();

  for (var i = 0; i < cancelButtons.length; i++) {
    cancelButtons[i].addEventListener('click', function() {
      $(this).closest("dialog")[0].close()
    });
  }

  for (var i = 0; i < submitButtons.length; i++) {
    submitButtons[i].addEventListener('click', function() {
      $(this).closest("dialog")[0].close()
    });
  }

   // Form cancel button closes the dialog box
  cancelButton.addEventListener('click', function() {
    dropCourseDialog.close();
  });


  var update_href = function(course_id, student_id, dialog) {
    href = $(dialog.querySelector("a.course-action")).attr("href")
    if (!href.indexOf('?') == -1)
      href = href.substr(0, href.indexOf('?'));
    new_href = href + "?course_id=" + course_id + "&student_id=" + student_id
    $(dialog.querySelector("a.course-action")).attr("href", new_href)
  }
};

$(document).ready(ready);
$(document).on('page:load', ready);
