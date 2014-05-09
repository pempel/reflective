function setTime() {
  var currentDate = new Date();
  var currentTime = currentDate.getTime();
  var currentOffset = currentDate.getTimezoneOffset() * 60 * 1000;

  var moscowOffset = 4 * 3600 * 1000;
  var moscowTime = currentTime + currentOffset + moscowOffset;
  var moscowDate = new Date(moscowTime);

  var hours = moscowDate.getHours();
  if (hours < 10) { hours = "0" + hours; }

  var minutes = moscowDate.getMinutes();
  if (minutes < 10) { minutes = "0" + minutes; }

  document.getElementById("time").innerHTML = hours + ":" + minutes;

  setTimeout(setTime, 1000);
}

$(window).load(function() {
  setTime();
});
