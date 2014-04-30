var companies = [
  "Leader Telecom",
  "Intellect Design",
  "Crowd Systems",
  "Business Car",
  "Yandex",
  "Business Car",
  "CQG",
  "Informicus",
]

var dataset = [ 1, 4, 4, 17, 5, 9, 4, 5 ],
    chartWidth = 600,
    chartHeight = 250,
    barMargin = 5,
    barWidth = (chartWidth - 125) / Math.max.apply(null, dataset),
    barHeight = (chartHeight - barMargin * (dataset.length - 1)) / dataset.length,
    svg = d3.select(".chart-area")
            .append("svg")
            .attr("id", "chart-by-companies")
            .attr("width", chartWidth)
            .attr("height", chartHeight);

svg.selectAll("rect")
   .data(dataset)
   .enter()
   .append("rect")
   .attr("class", "bar")
   .attr("x", 0)
   .attr("y", function(d, i) { return i * (barHeight + barMargin) })
   .attr("width", function(d, i) { return d * barWidth + 125 })
   .attr("height", function(d, i) { return barHeight });

svg.selectAll(".label")
   .data(dataset)
   .enter()
   .append("rect")
   .attr("class", "label")
   .attr("x", 0)
   .attr("y", function(d, i) { return i * (barHeight + barMargin) })
   .attr("width", 125)
   .attr("height", barHeight);

svg.selectAll(".months")
   .data(dataset)
   .enter()
   .append("text")
   .attr("class", "months")
   .text(function(d, i) { return d })
   .attr("x", function(d, i) { return d * barWidth + 125 - 10 })
   .attr("y", function(d, i) { return i * (barHeight + barMargin) + barHeight / 2 });

svg.selectAll(".company")
   .data(companies)
   .enter()
   .append("text")
   .attr("class", "company")
   .text(function(d, i) { return companies[i] })
   .attr("x", function(d, i) { return 10 })
   .attr("y", function(d, i) { return i * (barHeight + barMargin) + barHeight / 2 });
