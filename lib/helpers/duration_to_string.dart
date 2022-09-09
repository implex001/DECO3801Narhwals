

String minSecDurationToString(Duration duration) {
  num microseconds = duration.inMicroseconds;

  microseconds = microseconds.remainder(Duration.microsecondsPerHour);

  if (microseconds < 0) microseconds = -microseconds;

  var minutes = microseconds ~/ Duration.microsecondsPerMinute;
  microseconds = microseconds.remainder(Duration.microsecondsPerMinute);

  var minutesPadding = minutes < 10 ? "0" : "";

  var seconds = microseconds ~/ Duration.microsecondsPerSecond;
  microseconds = microseconds.remainder(Duration.microsecondsPerSecond);

  var secondsPadding = seconds < 10 ? "0" : "";

  return "$minutesPadding$minutes:"
      "$secondsPadding$seconds";
}