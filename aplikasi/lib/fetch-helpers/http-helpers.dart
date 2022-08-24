import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:travelling_app/classes/user/bookmarked_travelling_place.dart';
import 'package:travelling_app/fetch-helpers/api-endpoint.dart';

class HttpHelpers{
  static Map <String, String> getUrlHeader(){
    return {
      HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
    };
  }
  static Future<http.Response> fetchTravellingPlacesList(
      String query
  ){
    var jsonRequestBody = {
      "query": query
    };

    Uri uri = Uri.https(
      ApiEndpoint.getBaseAPIUrl(),
      ApiEndpoint.getTravellingPlacesListLink(),
      jsonRequestBody
    );

    return http.get(
      uri,
      headers: getUrlHeader(),
    );
  }
  static Future<http.Response> fetchNewsList(String query){

    var jsonRequestBody = {
      "title": query
    };

    Uri uri = Uri.https(
      ApiEndpoint.getBaseAPIUrl(),
      ApiEndpoint.getNewsListLink(),
      jsonRequestBody,
    );

    return http.get(
      uri,
      headers: getUrlHeader(),
    );
  }
  static Future<http.Response> fetchNewsDetails(String newsURL){
    print("Fetch News Detaiis...");
    var jsonRequestBody = {
      "url_link": newsURL,
    };

    Uri uri = Uri.https(
      ApiEndpoint.getBaseAPIUrl(),
      ApiEndpoint.getNewsDetailsLink(),
      jsonRequestBody,
    );

    return http.get(
      uri,
      headers: getUrlHeader(),
    );
  }
  static Future<http.Response> fetchColabTravellingPlaces(
    List<BookmarkedTravellingPlace> bookmarkedTravellingPlaces
  ) async {

    List<dynamic> userRatingJSON = [];
    userRatingJSON = bookmarkedTravellingPlaces.map(
            (bookmarkedTravellingPlace) => bookmarkedTravellingPlace.convertForColabJSON()
    ).toList();

    var jsonRequestBody = {
      "data": jsonEncode(userRatingJSON),
    };

    print("Current: $jsonRequestBody");

    Uri uri = Uri.https(
      ApiEndpoint.getBaseAPIUrl(),
      ApiEndpoint.getColabTravellingPlacesLink(),
      jsonRequestBody,
    );

    print("User Rating JSON: $jsonRequestBody");

    return http.get(
      uri,
      headers: getUrlHeader(),
    );
  }
}