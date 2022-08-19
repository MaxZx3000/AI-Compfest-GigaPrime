import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:travelling_app/classes/travelling_place.dart';
import 'package:travelling_app/database/travelling_place_bookmark_db.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/pages/detail/news_element.dart';
import 'package:travelling_app/templates/backable_app_bar.dart';
import 'package:travelling_app/templates/bookmark_widget.dart';
import 'package:travelling_app/templates/card_template.dart';
import 'package:travelling_app/utils/context.dart';

class DetailPage extends StatelessWidget{
  late TravellingPlace travellingPlace;
  late TravellingPlaceBookmarkDB travellingPlaceBookmarkDB;

  DetailPage({
    Key? key,
  }) : super(key: key);

  Widget _getJumbotronWidget(){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            travellingPlace.placeName,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            travellingPlace.city,
            style: const TextStyle(
              color: Colors.black45,
            ),
          )
        ],
      ),
    );
  }

  Widget _getMainPoints(){
    Widget _getItemMainPoint(
      IconData iconData,
      String data,
    ){
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color(colors["dark_orange"] as int),
            ),
            child: Icon(
              iconData,
              color: Colors.white,
              size: 35,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            data,
          ),
        ],
      );
    }

    Widget _getLineDivider(){
      return Padding(
        padding: const EdgeInsets.only(
          bottom: 30,
          left: 10,
          right: 10,
        ),
        child: Container(
          width: 2,
          height: 30,
          alignment: Alignment.center,
          color: Colors.grey,
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _getItemMainPoint(Icons.category, travellingPlace.category),
        _getLineDivider(),
        _getItemMainPoint(Icons.star, travellingPlace.getRating()),
        _getLineDivider(),
        _getItemMainPoint(Icons.money, travellingPlace.getPrice()),
      ],
    );
  }

  Widget _getRatingElement(){
    Widget _getLineDivider(){
      return Container(
        width: double.infinity,
        height: 2,
        decoration: BoxDecoration(
          color: Colors.black12,
        ),
      );
    }
    Widget _getSpacing(){
      return const SizedBox(
        height: 10,
      );
    }
    return Column(
      children: [
        _getSpacing(),
        _getLineDivider(),
        _getSpacing(),
        const Text(
          "Apa nilai yang Anda berikan untuk tempat ini?",
          textAlign: TextAlign.center,
        ),
        BookmarkWidget(
          score: 0,
          onBookmarkPressed: (rating) async{
            await travellingPlaceBookmarkDB.initBox();
            travellingPlaceBookmarkDB.putBookmark(
              rating, travellingPlace,
            );
          }
        ),
        _getLineDivider(),
      ],
    );
  }

  Widget _getSummarizedDescription(){
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: CardTemplate(
          title: "Rangkuman Deskripsi Tempat",
          contentWidget: SingleChildScrollView(
            primary: false,
            padding: const EdgeInsets.all(8.0),
            scrollDirection: Axis.vertical,
            child: Text(
              travellingPlace.getSummarizedDescription(),
              style: const TextStyle(
                height: 1.3
              ),
            ),
          ),
          height: 180),
    );
  }
  Widget _getNewsRelatedToTravellingPlace(){
    return NewsElement(
      query: travellingPlace.placeName,
    );
  }

  @override
  Widget build(BuildContext context){
    var arguments = ContextUtils.getArguments(context);
    travellingPlace = arguments as TravellingPlace;
    travellingPlaceBookmarkDB = TravellingPlaceBookmarkDB();
    return Scaffold(
      appBar: BackableAppBar(
        onBackIconPressed: (){
          Navigator.pop(context);
        },
        appBarTitle: "Travelling Place Detail",
      ).getInstance(context),
      body: SingleChildScrollView(
        primary: true,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            _getJumbotronWidget(),
            _getMainPoints(),
            _getRatingElement(),
            _getSummarizedDescription(),
            _getNewsRelatedToTravellingPlace(),
          ],
        ),
      ),
    );
  }
}