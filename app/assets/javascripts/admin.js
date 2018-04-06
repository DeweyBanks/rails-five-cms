//= require app.js
//= require rails-ujs
//= require ckeditor/init
//= require ckeditor/config
//= require datetimepicker


$(document).ready(function(){
  $(document).foundation();

  $('#check_all').on("click", function(){
    var cbxs = $('input[type="checkbox"]');
    cbxs.prop("checked", !cbxs.prop("checked"));
  });

  $('#bulkActions').on('click', function() {
    $('#edit_posts').submit(function(e){
       e.preventDefault();
      var ck_box = $('input[type="checkbox"]:checked').length;
      if(ck_box > 0){
        this.submit();
      }
    });
  });


  var change_visibility;
  change_visibility = function(status) {
    console.log("status::  ", status);
    if (status === "scheduled") {
      return $('.published_at').datetimepicker({
                    dateFormat: 'yy-mm-dd ',
                    timeFormat: 'hh:mm:ss ',
                    step: 5,
                    ampm: true,
                    inline:true,
                    lang:'en'
                  });
    } else {
      $('.published-field').hide();
      return $('.published-field').datetimepicker('hide');
    }
  };

  change_visibility($("#post_status :selected").text());

  $('.published_at').datetimepicker({
                    dateFormat: 'yy-mm-dd ',
                    timeFormat: 'hh:mm:ss ',
                    step: 5,
                    ampm: true,
                    inline:true,
                    lang:'en'
                  });

  $("#post_status").on("change", function(e) {
    console.log("Status changed::  ", $(this).find(":selected").text())
    return change_visibility($(this).find(":selected").text());
  });



  $('#setFeatured')
  .bind('ajax:success', function(evt, data, status, xhr) {
    //function called on status: 200 (for ex.)
    $('#setFeatured')[0].reset();
  })
  .bind("ajax:error", function(evt, xhr, status, error) {
    //function called on status: 401 or 500 (for ex.)
    console.log(xhr.responseText);
  });

  $("#locked").on("click", function(e){
    if ($('#locked').is(":checked"))
    {
      console.log("LOCKED:::");
    }

  })



});
