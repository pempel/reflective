function setLanguage(language) {
  if (typeof language === "undefined") {
    if (typeof $.cookie(language) === "undefined") {
      language = window.navigator.language;
    } else {
      language = $.cookie("language");
    }
  }
  $.cookie("language", /ru/.test(language) ? "ru" : "en");
  $("body").attr("class", $.cookie("language"));
  $("#" + $.cookie("language")).parent().children().removeClass("active");
  $("#" + $.cookie("language")).addClass("active");
}

$(document).ready(function() {
  setLanguage();
  $("#en, #ru").click(function(event) {
    setLanguage(event.target.id);
    event.preventDefault();
  });
});
