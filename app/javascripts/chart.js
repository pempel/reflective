function Chart(uid, gid) {
  this.uid = uid;
  this.gid = gid;
}

Chart.prototype = {
  constructor: Chart,

  labels: function() {
    return [];
  },

  values: function() {
    return [];
  },

  width: function() {
    return 550;
  },

  height: function() {
    return (this.barHeight() + this.barYOffset()) * this.values().length;
  },

  barXOffset: function() {
    var labels = this.labels().sort(function(a, b) { return b.length - a.length; });
    return labels[0].length * 8;
  },

  barYOffset: function() {
    return 5;
  },

  barWidth: function() {
    var value = Math.max.apply(null, this.values());
    return (this.width() - this.barXOffset()) / value;
  },

  barHeight: function() {
    return 27;
  },

  draw: function() {
    var barXOffset = this.barXOffset();
    var barYOffset = this.barYOffset();

    var barWidth = this.barWidth();
    var barHeight = this.barHeight();

    var values = this.values();
    var labels = this.labels();

    var svg = d3.select("[data-chart-group-id=" + this.gid + "] .chart")
                .append("svg")
                  .attr("id", this.uid)
                  .attr("width", this.width())
                  .attr("height", this.height());

    svg.selectAll(".bar")
       .data(values)
       .enter()
       .append("rect")
         .attr("class", "bar")
         .attr("width", function(d, i) { return d * barWidth; })
         .attr("height", barHeight)
         .attr("x", barXOffset)
         .attr("y", function(d, i) { return i * (barHeight + barYOffset); });

    svg.selectAll(".bar-text")
       .data(values)
       .enter()
       .append("text")
         .text(function(d, i) { return d })
         .attr("class", "bar-text")
         .attr("x", function(d, i) { return d * barWidth + barXOffset - 8; })
         .attr("y", function(d, i) {
           return i * (barHeight + barYOffset) + barHeight / 2;
         });

    svg.selectAll(".label")
       .data(labels)
       .enter()
       .append("rect")
         .attr("class", "label")
         .attr("width", barXOffset)
         .attr("height", barHeight)
         .attr("x", 0)
         .attr("y", function(d, i) { return i * (barHeight + barYOffset); });

    svg.selectAll(".label-text")
       .data(labels)
       .enter()
       .append("text")
         .text(function(d, i) { return d })
         .attr("class", "label-text")
         .attr("x", 10)
         .attr("y", function(d, i) {
           return i * (barHeight + barYOffset) + barHeight / 2;
         });
  }
};
