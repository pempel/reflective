$(document).ready(function() {
  var links = $(".chart-link");

  links.click(function(event) {
    event.preventDefault();
    links.removeClass("active");
    links.each(function() { $($(this).data("chart-id")).hide(); });
    $(this).addClass("active");
    $($(this).data("chart-id")).show();
  });

  links.first().click();

  function dataset(subject, language) {
    var chart = $("[data-chart-name=" + subject + "]");
    var json = $.parseJSON(chart.find("script:lang(" + language + ")").text());
    console.log(json);
  }

  window.DS = dataset;
});
