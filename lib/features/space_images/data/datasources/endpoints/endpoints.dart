class NasaEndpoints {
  static String getSpaceMedia(String apiKey, String date) =>
      "https://api.nasa.gov/planetary/apod?hd=true&api_key=$apiKey&date=$date";
}
