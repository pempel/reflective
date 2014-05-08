$(document).ready(function() {
  var animating = false;
  var links = $("nav .section-links").find(".section-link");
  var headers = links.map(function() {
    var header = $($(this).find("a").attr("href"));
    if (header.length) { return header }
  });

  window.links = links
  window.headers = headers

  links.click(function(event) {
    event.preventDefault();
    var header = $($(this).find("a").attr("href"));
    var headerTop = header.offset().top - header.height();
    links
      .removeClass("active");
    links
      .find("a")
      .filter("[href=#" + header.attr("id") + "]")
      .closest(".section-link")
      .addClass("active");
    headers.each(function() { return $(this).find("i").css({"visibility": "hidden"}) });
    header.find("i").css({"visibility": "visible"});
    animating = true;
    setTimeout(function() { animating = false }, 1000);
    $("body").animate({scrollTop: headerTop + "px"}, 500);
  });

  $(window).scroll(function() {
    var fromTop = $(this).scrollTop();

    if (fromTop >= $("aside").offset().top) {
      $("nav").css({"position": "fixed", "top": "0"});
    } else {
      $("nav").css({"position": "relative", "top": "auto"});
    }

    if (animating === false) {
      links.removeClass("active");
      headers.each(function() { return $(this).find("i").css({"visibility": "hidden"}) });
    }
  });
});
