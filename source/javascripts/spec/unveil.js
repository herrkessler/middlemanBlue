$(document).ready(function() {
  $(".lazy").unveil(200, function() {
    $(this).load(function() {
      $(this).addClass('loaded');
    });
  });
});