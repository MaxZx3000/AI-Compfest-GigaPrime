class ApiEndpoint{

  static String getBaseAPIUrl(){
    return "10.0.2.2:8000";
  }

  static String getTravellingPlacesListLink(){
    return "/travelling_api/travelling_places_list";
  }
  static String getNewsListLink(){
    return "/travelling_api/news_list";
  }
  static String getNewsDetailsLink(){
    return "/travelling_api/news_details";
  }
  static String getColabTravellingPlacesLink(){
    return "/travelling_api/colab_filtering_travelling_places";
  }
}