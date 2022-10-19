import 'package:travelling_app/classes/travelling_place.dart';

class TravellingPlaceQuery{
  String relatedSentences;
  TravellingPlace travellingPlace;

  TravellingPlaceQuery({
    required this.relatedSentences,
    required this.travellingPlace
  });

  factory TravellingPlaceQuery.setFromJSON(dynamic jsonData){
    String relatedKeyword = jsonData["Related_Sentences"];
    TravellingPlace travellingPlace = TravellingPlace.setFromJSON(
      jsonData
    );

    return TravellingPlaceQuery(
      relatedSentences: relatedKeyword,
      travellingPlace: travellingPlace,
    );

  }
}