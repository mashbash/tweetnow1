$(document).ready(function(){
  $('.tweetform').submit(function(e){
    e.preventDefault();
    $('#load-image').show();
    var $form = $(this);
    $form.find('input[type="submit"]').attr('disabled', 'disabled');
    $.ajax({
      type: this.method,
      url: this.action,
      data: $(this).serialize(),
      dataType: "html"
    }).success(function(response){
      $('.container').append(response);
      $form.find('input[type="submit"]').removeAttr('disabled');
      $('#load-image').hide();
    });
  });
});







  // var username = window.location.href.substring(window.location.href.lastIndexOf('/')+1);
  // $.post('/' + username)
  // .done(function(serverData){
  //   $('img').hide();
  //   $('body').append(serverData);
  // });
