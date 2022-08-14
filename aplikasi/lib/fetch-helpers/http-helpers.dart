import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:travelling_app/fetch-helpers/api-endpoint.dart';

class HttpHelpers{
  static Future<http.Response> fetchTravellingPlacesList(
      String query
  ){
    var jsonRequestBody = {
      "query": query
    };

    Uri uri = Uri.http(
      ApiEndpoint.getBaseAPIUrl(),
      ApiEndpoint.getTravellingPlacesListLink(),
      jsonRequestBody
    );

    final headers = {
      HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
    };

    return http.get(
      uri,
      headers: headers,
    );
  }
  static Future<http.Response> fetchNewsList(){
    Uri uri = Uri.parse(ApiEndpoint.getNewsListLink());
    return http.get(uri);
  }
  static Future<http.Response> fetchNewsDetails(){
    Uri uri = Uri.parse(ApiEndpoint.getNewsDetailsLink());
    return http.get(uri);
  }
}