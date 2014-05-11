$(document).ready(function() {
  var charts = [
    new ChartByCompanies(),
    new ChartByPositions()
  ];

  charts.forEach(function(chart) {
    chart.draw();
  });

  var links = $(".chart-group-link");

  links.click(function(event) {
    event.preventDefault();
    links.removeClass("active");
    links.each(function() { $("#" + $(this).data("chart-id")).hide(); });
    $(this).addClass("active");
    $("#" + $(this).data("chart-id")).show();
  });

  links.first().click();
});
