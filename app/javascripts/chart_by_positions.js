var positions = [
  "Rails Developer",
  "Django Developer",
  "C++ Developer",
  "C# Developer",
];

var dataset = [1 + 4 + 4 + 17, 5 + 9, 4, 5],
    chartWidth = 600,
    chartHeight = 125,
    labelWidth = 138,
    barMargin = 5,
    barWidth = (chartWidth - labelWidth) / Math.max.apply(null, dataset),
    barHeight = (chartHeight - barMargin * (dataset.length - 1)) / dataset.length,
    svg = d3.select(".chart-area")
            .append("svg")
            .attr("id", "chart-by-positions")
            .attr("width", chartWidth)
            .attr("height", chartHeight);

svg.selectAll("rect")
   .data(dataset)
   .enter()
   .append("rect")
   .attr("class", "bar")
   .attr("x", 0)
   .attr("y", function(d, i) { return i * (barHeight + barMargin) })
   .attr("width", function(d, i) { return d * barWidth + labelWidth })
   .attr("height", function(d, i) { return barHeight });

svg.selectAll(".label")
   .data(dataset)
   .enter()
   .append("rect")
   .attr("class", "label")
   .attr("x", 0)
   .attr("y", function(d, i) { return i * (barHeight + barMargin) })
   .attr("width", labelWidth)
   .attr("height", barHeight);

svg.selectAll(".months")
   .data(dataset)
   .enter()
   .append("text")
   .attr("class", "months")
   .text(function(d, i) { return d })
   .attr("x", function(d, i) { return d * barWidth + labelWidth - 10 })
   .attr("y", function(d, i) { return i * (barHeight + barMargin) + barHeight / 2 });

svg.selectAll(".company")
   .data(companies)
   .enter()
   .append("text")
   .attr("class", "company")
   .text(function(d, i) { return positions[i] })
   .attr("x", function(d, i) { return 10 })
   .attr("y", function(d, i) { return i * (barHeight + barMargin) + barHeight / 2 });
