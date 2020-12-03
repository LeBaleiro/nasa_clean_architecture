class NasaEndpoints {
  static String getSpaceMediaFromDate(String apiKey, String date) =>
      "https://api.nasa.gov/planetary/apod?hd=true&api_key=$apiKey&date=$date";

  static String getSpaceMediaFromToday(String apiKey) =>
      "https://api.nasa.gov/planetary/apod?hd=true&api_key=$apiKey";
}
