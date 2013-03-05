$(document).ready(function(){
  var username = window.location.href.substring(window.location.href.lastIndexOf('/')+1);
  $.post('/' + username)
  .done(function(serverData){
    $('img').hide();
    $('body').append(serverData);
  });
});
