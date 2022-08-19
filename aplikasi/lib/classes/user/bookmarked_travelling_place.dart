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
}