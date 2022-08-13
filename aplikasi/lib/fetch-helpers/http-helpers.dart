import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travelling_app/fetch-helpers/api-endpoint.dart';

class HttpHelpers{
  static Future<http.Response> fetchTravellingPlacesList(
      String query
  ){
    var jsonRequestBody = {
      "query": query
    };

    var body = json.encode(jsonRequestBody);
    Uri uri = Uri.parse(ApiEndpoint.getTravellingPlacesListLink());

    return http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        body: body
      },
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