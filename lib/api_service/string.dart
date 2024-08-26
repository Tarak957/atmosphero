const String apiKey = '4f6bf7e10d988d2dffe5ded002e2d135';

String apiUrl(double lat, double long) {
  String url =
      "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$long&apiid=$apiKey&units=metric&exclude=minutely";
  return url;
}
