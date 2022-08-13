class ApiEndpoint{
  static final String _baseApiURL = "http://127.0.0.1:8000/travelling_api";

  static String getTravellingPlacesListLink(){
    return "$_baseApiURL/travelling_places_list";
  }
  static String getNewsListLink(){
    return "$_baseApiURL/news_list";
  }
  static String getNewsDetailsLink(){
    return "$_baseApiURL/news_details";
  }
}