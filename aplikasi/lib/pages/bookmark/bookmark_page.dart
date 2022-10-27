import 'package:flutter/material.dart';
import 'package:travelling_app/classes/user/bookmarked_travelling_place.dart';
import 'package:travelling_app/database/travelling_place_bookmark_db.dart';
import 'package:travelling_app/fetch-helpers/data-fetcher.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/globals/route.dart';
import 'package:travelling_app/pages/bookmark/recommendations_colab_widget.dart';
import 'package:travelling_app/templates/backable_app_bar.dart';
import 'package:travelling_app/templates/top_image_horizontal_item_view.dart';
import 'package:travelling_app/templates/information_widget.dart';
import 'package:travelling_app/templates/rating_widget.dart';

import '../../utils/context.dart';

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

  void updateWidget(){
    setState(() {});
  }

  Widget _getJumbotronWidget(){
    return Container(
      padding: const EdgeInsets.all(
        16.0,
      ),
      width: double.infinity,
      color: Color(colors["dark_green"] as int),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Tempat Wisata yang dirating oleh Anda",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _getJumboIconWidget() {
    return Container(
      color: Color(colors["light_blue"] as int),
      height: 275,
      width: double.infinity,
      child: const Icon(
        Icons.star,
        color: Colors.white,
        size: 250,
      ),
    );
  }

  Widget _getBookmarkedItems(List<BookmarkedTravellingPlace> bookmarkedTravellingPlaces){
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: bookmarkedTravellingPlaces.length,
          itemBuilder: (BuildContext ctx, index){
            BookmarkedTravellingPlace bookmarkedTravellingPlace = bookmarkedTravellingPlaces[index];
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: TopImageHorizontalItemWidget(
                titleText: bookmarkedTravellingPlace.travellingPlace.placeName,
                subtitleText: bookmarkedTravellingPlace.travellingPlace.city,
                imageURL: bookmarkedTravellingPlace.travellingPlace.imageURL,
                maxTitleTextLine: 2,
                additionalWidget: Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 15.0,
                    bottom: 10.0,
                  ),
                  child: RatingWidget(
                    rating: bookmarkedTravellingPlace.rating.toString(),
                  ),
                ),
                height: 300,
                width: 300,
                onClickCard: (){
                  Navigator.pushNamed(
                      context,
                      detailRouteName,
                      arguments: bookmarkedTravellingPlace.travellingPlace
                  ).then((value) => {updateWidget()});
                },
                topRightWidget: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async{
                      await travellingPlaceBookmarkDB.deleteBookmark(
                        bookmarkedTravellingPlace.travellingPlace.placeId.toString(),
                      );
                      setState((){});
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: const Text("Hapus"),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }

  Widget _successResult(List<BookmarkedTravellingPlace> bookmarkedTravellingPlaces){
    return Column(
      children: [
        _getBookmarkedItems(bookmarkedTravellingPlaces),
        const SizedBox(
          height: 30,
        ),
        _getRecommendationTravellingPlaces(bookmarkedTravellingPlaces),
      ],
    );
  }

  Widget _getNoDataElement(){
    return const Center(
      child: InformationWidget(
        iconData: Icons.star,
        widgetWidth: 250,
        information: "Anda belum melakukan rating tempat wisata sama sekali!"
      ),
    );
  }

  Widget _getRecommendationTravellingPlaces(List<BookmarkedTravellingPlace> bookmarkedTravellingPlaces){
    return RecommendationColabWidget(
      bookmarkedTravellingPlaces: bookmarkedTravellingPlaces,
      parentFunction: updateWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackableAppBar(
        appBarTitle: "Rating Page",
        onBackIconPressed: (){
          Navigator.pop(context);
        },
        rightMargin: 100
      ).getInstance(context),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        primary: true,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _getJumboIconWidget(),
            _getJumbotronWidget(),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: travellingPlaceBookmarkDB.getAllBookmarks(),
              builder: (context, snapshot) {
                if (snapshot.hasError){
                  return Text(
                    snapshot.error.toString(),
                  );
                }
                if (snapshot.hasData == false){
                  return _getNoDataElement();
                }
                List<BookmarkedTravellingPlace> bookmarkTravellingPlaces = snapshot.data as List<BookmarkedTravellingPlace>;
                if (bookmarkTravellingPlaces.isEmpty){
                  return _getNoDataElement();
                }
                return _successResult(bookmarkTravellingPlaces);
              },
            ),
          ],
        ),
      ),
    );
  }
}