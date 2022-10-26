import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:travelling_app/classes/user/bookmarked_travelling_place.dart';
import 'package:travelling_app/fetch-helpers/api-endpoint.dart';

class HttpHelpers{
  static Map <String, String> getUrlHeader(){
    return {
      HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
    };
  }
  static Future<http.Response> fetchTravellingPlacesUserQueryList(
      String query,
    ){
    print("Query on Future: ${query}");
    var jsonRequestBody = {
      "query": query,
    };

    Uri uri = Uri.http(
        ApiEndpoint.getBaseAPIUrl(),
        ApiEndpoint.getTravellingPlacesUserQueryLink(),
        jsonRequestBody
    );

    return http.get(
      uri,
      headers: getUrlHeader(),
    );
  }


  static Future<http.Response> fetchTravellingPlacesUserLocationList(
      String categories,
      String cities,
      double latitude,
      double longitude,
  ){
    var jsonRequestBody = {
      "latitude": latitude.toString(),
      "longitude": longitude.toString(),
      "categories": categories,
      "cities": cities,
    };

    Uri uri = Uri.http(
      ApiEndpoint.getBaseAPIUrl(),
      ApiEndpoint.getTravellingPlacesUserLocationLink(),
      jsonRequestBody
    );

    return http.get(
      uri,
      headers: getUrlHeader(),
    );
  }

  static Future<http.Response> fetchTravellingPlacesUserBudgetList(
      String categories,
      String cities,
      int ticketPrice
      ){
    var jsonRequestBody = {
      "ticket_price": ticketPrice.toString(),
      "categories": categories,
      "cities": cities,
    };

    Uri uri = Uri.http(
        ApiEndpoint.getBaseAPIUrl(),
        ApiEndpoint.getTravellingPlacesUserBudgetLink(),
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

    Uri uri = Uri.http(
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
    var jsonRequestBody = {
      "url_link": newsURL,
    };

    Uri uri = Uri.http(
      ApiEndpoint.getBaseAPIUrl(),
      ApiEndpoint.getNewsDetailsLink(),
      jsonRequestBody,
    );

    return http.get(
      uri,
      headers: getUrlHeader(),
    );
  }

  static Future<http.Response> fetchTimeSeriesData(String timeSeriesURL){
    Uri uri = Uri.http(
        ApiEndpoint.getBaseAPIUrl(),
        timeSeriesURL,
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

    Uri uri = Uri.http(
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