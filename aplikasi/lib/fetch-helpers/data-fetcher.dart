import 'package:travelling_app/fetch-helpers/http-helpers.dart';

class DataFetcher{
  static void getTravellingPlaces(String query) async {
    final response = await HttpHelpers.fetchTravellingPlacesList(query);
    print(response);
  }
}