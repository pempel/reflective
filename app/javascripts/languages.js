function setCurrentLanguage(language) {
  if (typeof language === "undefined") {
    if (typeof $.cookie(language) === "undefined") {
      language = "en";
    } else {
      language = $.cookie("language");
    }
  }
  $.cookie("language", /ru/.test(language) ? "ru" : "en");
  $(document).attr("title", $(".details h1[lang=" + $.cookie("language") + "]").text());
  $("body").attr("class", $.cookie("language"));
  $("#language-links a").removeClass("active");
  $("#language-links a[href=" + $.cookie("language") + "]").addClass("active");
}

$(document).ready(function() {
  setCurrentLanguage();
  $("#language-links a").click(function(event) {
    event.preventDefault();
    setCurrentLanguage($(event.target).attr("href"));
  });
});
