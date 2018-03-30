//= require jquery
//= require rails-ujs
//= require ckeditor/init
//= require ckeditor/config

$(document).ready(function(){

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

});
