import 'dart:convert';

import 'package:travelling_app/classes/travelling_place.dart';
import 'package:travelling_app/fetch-helpers/http-helpers.dart';

class DataFetcher{
  static void getTravellingPlaces(String query) async {
    final response = await HttpHelpers.fetchTravellingPlacesList(query);
    dynamic jsonDecoded = jsonDecode(response.body);
    List<TravellingPlace> travellingPlaces = [];
    jsonDecoded.forEach((element) {
      TravellingPlace travellingPlace = TravellingPlace.setFromJSON(element);
      travellingPlaces.add(travellingPlace);
    });
    print(travellingPlaces);
  }
}