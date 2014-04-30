function setCurrentLocale(locale) {
  if (typeof locale === "undefined") {
    if (typeof $.cookie(locale) === "undefined") {
      locale = window.navigator.language;
    } else {
      locale = $.cookie("locale");
    }
  }
  $.cookie("locale", /ru/.test(locale) ? "ru" : "en");
  $(document).attr("title", $(".details h1[lang=" + $.cookie("locale") + "]").text());
  $("body").attr("class", $.cookie("locale"));
  $("#locale-links a").removeClass("active");
  $("#locale-links a[href=" + $.cookie("locale") + "]").addClass("active");
}

$(document).ready(function() {
  setCurrentLocale();
  $("#locale-links a").click(function(event) {
    setCurrentLocale($(event.target).attr("href"));
    event.preventDefault();
  });
});
