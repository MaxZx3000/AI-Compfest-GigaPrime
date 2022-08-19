import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:travelling_app/classes/travelling_place.dart';
import 'package:travelling_app/classes/user/bookmarked_travelling_place.dart';

class TravellingPlaceBookmarkDB{

  late Box travellingPlaceBox;

  Future<void> initBox() async{
    String travellingPlaceBoxName = "travelling_place_bookmark";
    if (!kIsWeb && !Hive.isBoxOpen(travellingPlaceBoxName)) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }
    try{
      Hive.registerAdapter(BookmarkedTravellingPlaceAdapter());
    }
    on HiveError catch (_, error){
      print("BookmarkedTravellingPlaceAdapter Adapter has been registered!");
    }
    try{
      Hive.registerAdapter(TravellingPlaceAdapter());
    }
    on HiveError catch (_, error){
      print("TravellingPlaceAdapter Adapter has been registered!");
    }
    travellingPlaceBox = await Hive.openBox(travellingPlaceBoxName);
  }

  void putBookmark(int rating, TravellingPlace travellingPlace) async{
    BookmarkedTravellingPlace bookmarkedTravellingPlace = BookmarkedTravellingPlace(
        rating: rating,
        travellingPlace: travellingPlace
    );

    String key = bookmarkedTravellingPlace.travellingPlace.placeId.toString();
    print("Key: ${key}");
    await travellingPlaceBox.put(key, bookmarkedTravellingPlace);
    print("Your data has been saved!");
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