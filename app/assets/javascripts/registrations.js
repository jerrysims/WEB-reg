var ready;
ready = function() {

  // ...your javascript goes here...

  $("#load_tuition_preference_form").on('click', function(e){
    e.preventDefault();
    $("#tuition-preference-form-link").hide();
    $("#tuition-preference-actual-form").show();

  })

};

$(document).ready(ready);
$(document).on('page:load', ready);
