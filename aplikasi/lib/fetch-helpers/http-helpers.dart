import 'package:http/http.dart' as http;
import 'package:travelling_app/fetch-helpers/api-endpoint.dart';

class HttpHelpers{
  static Future<http.Response> fetchTravellingPlacesList(){
    return http.get(ApiEndpoint.getTravellingPlacesListLink());
  }
  static Future<http.Response> fetchNewsList(){
    return http.get(ApiEndpoint.getNewsListLink());
  }
  static Future<http.Response> fetchNewsDetails(){
    return http.get(ApiEndpoint.getNewsDetailsLink());
  }
}