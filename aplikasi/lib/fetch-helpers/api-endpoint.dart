class ApiEndpoint{

  static String getBaseAPIUrl(){
    // return "travelling-app-backend.herokuapp.com"; // For Public API
    return "10.0.2.2:8000"; // For Testing
  }

  static String getTravellingPlacesUserQueryLink(){
    return "/travelling_api/travelling_places_user_query_list";
  }
  static String getTravellingPlacesUserLocationLink(){
    return "/travelling_api/travelling_places_user_location_list";
  }
  static String getTravellingPlacesUserBudgetLink(){
    return "/travelling_api/travelling_places_user_budget_list";
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