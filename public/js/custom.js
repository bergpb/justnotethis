$(document).on('click', '.notification > button.delete', function() {
  $(this).parent().addClass('is-hidden');
  return false;
});

$(document).ready(function() {
  $(".navbar-burger").click(function() {
    $(".navbar-burger").toggleClass("is-active");
    $(".navbar-menu").toggleClass("is-active");
  });
});
