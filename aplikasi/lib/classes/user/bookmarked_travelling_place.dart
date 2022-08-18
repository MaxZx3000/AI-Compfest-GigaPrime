import 'package:hive/hive.dart';
import 'package:travelling_app/classes/travelling_place.dart';

class BookmarkedTravellingPlace extends HiveObject{
  @HiveField(0)
  int rating;

  @HiveField(1)
  TravellingPlace travellingPlace;

  BookmarkedTravellingPlace({
    required this.rating,
    required this.travellingPlace,
  });
}