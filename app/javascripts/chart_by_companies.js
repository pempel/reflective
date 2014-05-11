function ChartByCompanies() {
  Chart.call(this, "chart-by-companies", "jobs");
}

ChartByCompanies.prototype = Object.create(Chart.prototype, {
  constructor: {
    configurable: true,
    enumerable: true,
    value: ChartByCompanies,
    writable: true
  }
});

ChartByCompanies.prototype.labels = function() {
  return [
    "Leader Telecom",
    "Intellect Design",
    "Crowd Systems",
    "Business Car",
    "Yandex",
    "Business Car",
    "CQG",
    "Informicus"
  ];
};

ChartByCompanies.prototype.values = function() {
  return [1, 4, 4, 17, 5, 9, 4, 5];
};
