function ChartByPositions() {
  Chart.call(this, "chart-by-positions", "jobs");
}

ChartByPositions.prototype = Object.create(Chart.prototype, {
  constructor: {
    configurable: true,
    enumerable: true,
    value: ChartByPositions,
    writable: true
  }
});

ChartByPositions.prototype.labels = function() {
  return [
    "Ruby on Rails Developer",
    "Django Developer",
    "C++ Developer",
    "C# Developer"
  ];
};

ChartByPositions.prototype.values = function() {
  return [1 + 4 + 4 + 17, 5 + 9, 4, 5];
};
