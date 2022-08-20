import 'package:flutter/cupertino.dart';
import 'package:travelling_app/database/travelling_place_bookmark_db.dart';

class BookmarkPage extends StatefulWidget{
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookmarkState();

}

class _BookmarkState extends State<BookmarkPage>{
  late TravellingPlaceBookmarkDB travellingPlaceBookmarkDB;

  @override
  void initState() {
    super.initState();
    travellingPlaceBookmarkDB = TravellingPlaceBookmarkDB();
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   builder: (context, snapshot) {
    //
    //   },
    // );
    return Column(

    );
  }
}