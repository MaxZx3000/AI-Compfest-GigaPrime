import 'package:hive/hive.dart';
import 'package:travelling_app/classes/travelling_place.dart';
import '../classes/user/bookmarked_travelling_place.dart';

class TravellingPlaceBookmarkDB{

  late Box travellingPlaceBox;

  TravellingPlaceBookmarkDB(){
    travellingPlaceBox = Hive.box("travelling_place_bookmark");
  }

  void putBookmark(int rating, TravellingPlace travellingPlace) async{
    BookmarkedTravellingPlace bookmarkedTravellingPlace = BookmarkedTravellingPlace(
        rating: rating,
        travellingPlace: travellingPlace
    );

    bookmarkedTravellingPlace.save();
    String key = bookmarkedTravellingPlace.travellingPlace.placeId.toString();
    await travellingPlaceBox.put(key, bookmarkedTravellingPlace);
  }

  Future<BookmarkedTravellingPlace> getOneBookmarkByKey(String placeIdKey) async{
    BookmarkedTravellingPlace bookmarkedTravellingPlace = await travellingPlaceBox.get(
      placeIdKey,
    );
    return bookmarkedTravellingPlace;
  }

  List<BookmarkedTravellingPlace> getAllBookmarks(){
    return travellingPlaceBox.values.toList() as List<BookmarkedTravellingPlace>;
  }
  void deleteBookmark(String placeIdKey) async{
    await travellingPlaceBox.delete(placeIdKey);
  }
}