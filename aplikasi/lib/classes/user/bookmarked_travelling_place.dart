import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:travelling_app/classes/travelling_place.dart';

part "bookmarked_travelling_place.g.dart";

@HiveType(typeId: 0)
class BookmarkedTravellingPlace{
  @HiveField(0)
  int rating;

  @HiveField(1)
  TravellingPlace travellingPlace;

  BookmarkedTravellingPlace({
    required this.rating,
    required this.travellingPlace,
  });

  Map<String, dynamic> convertForColabJSON(){
    return {
      "user_id": 200001,
      "place_rating": rating,
      "place_id": travellingPlace.placeId,
    };
  }

  Map<String, dynamic> convertToJSON(){
    return {
      "user_rating": rating,
      "place_id": travellingPlace.placeId,
      "place_name": travellingPlace.placeName,
      "description": travellingPlace.description,
      "category": travellingPlace.category,
      "city": travellingPlace.city,
      "price": travellingPlace.price,
      "average_rating": travellingPlace.rating,
      "time_minutes": travellingPlace.timeMinutes,
      "latitude": travellingPlace.latitude,
      "longitude": travellingPlace.longitude,
      "summarized_description": travellingPlace.summarizedDescription,
    };
  }
}