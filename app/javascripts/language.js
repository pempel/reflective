$(document).ready(function() {
  $("#en, #ru").click(function(event) {
    event.preventDefault();
    $("body").attr("class", event.target.id);
    $(this).parent().children().removeClass("active");
    $(this).addClass("active");
  });
});
