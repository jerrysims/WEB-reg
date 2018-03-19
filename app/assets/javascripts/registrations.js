var ready;

// defines the function that will run when the DOM loads
ready = function() {

  // ...your javascript goes here...
  $("#load_tuition_preference_form").on('click', function(e){
    e.preventDefault();
    $("#tuition-preference-form-link").hide();
    $("#tuition-preference-actual-form").show();

  })

    var selectedCourse = document.getElementsByClassName('register-grid-class-card');
    var dropCourseDialog = document.getElementById('drop-course-dialog');
    var addCourseDialog = document.getElementById('add-course-dialog');
    var cancelButton = document.getElementById('cancel');
    var cancelButtons = document.getElementsByClassName('cancel');
    var submitButtons  = document.getElementsByClassName('submit');
    var reviewScheduleButtons = document.getElementsByClassName('review-schedule-button')

    // Clicking on course that is already selected opens a modal dialog
    for (var i = 0 ; i < selectedCourse.length; i++) {
      if ($(selectedCourse[i]).hasClass("registered")) {
        selectedCourse[i].addEventListener('click', function() {
          course_id = $(this).data("course");
          student_id = $(this).data("student");
          href = $(dropCourseDialog.querySelector("a.drop-course")).attr("href")
          if (!href.indexOf('?') == -1)
            href = href.substr(0, href.indexOf('?'));
          new_href = href + "?course_id=" + course_id + "&student_id=" + student_id
          $(dropCourseDialog.querySelector("a.drop-course")).attr("href", new_href)
          dropCourseDialog.showModal();
        });
      } else {
        selectedCourse[i].addEventListener('click', function() {
          course_id = $(this).data("course");
          student_id = $(this).data("student");
          href = $(addCourseDialog.querySelector("a.add-course")).attr("href")
          if (!href.indexOf('?') == -1)
            href = href.substr(0, href.indexOf('?'));
          new_href = href + "?course_id=" + course_id + "&student_id=" + student_id
          $(addCourseDialog.querySelector("a.add-course")).attr("href", new_href)
          addCourseDialog.showModal();
        });
      }
    }

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
};

$(document).ready(ready);
$(document).on('page:load', ready);
