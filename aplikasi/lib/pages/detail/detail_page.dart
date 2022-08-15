import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/classes/travelling_place.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/templates/backable_app_bar.dart';
import 'package:travelling_app/templates/card_template.dart';
import 'package:travelling_app/utils/context.dart';

class DetailPage extends StatelessWidget{
  late TravellingPlace travellingPlace;

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
          SizedBox(
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

  Widget _getSummarizedDescription(){
    return CardTemplate(
        title: "Deskripsi Tempat",
        contentWidget: Text(
          travellingPlace.getSummarizedDescription(),
        ),
        height: 120);
  }
  Widget _getNewsRelatedToTravellingPlace(){
    
  }
  @override
  Widget build(BuildContext context) {
    var arguments = ContextUtils.getArguments(context);
    travellingPlace = arguments as TravellingPlace;

    return Scaffold(
      appBar: DetailAppBar(
        appBarTitle: "Travelling Place Detail",
      ).getInstance(context),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          _getJumbotronWidget(),
          _getMainPoints(),
          _getSummarizedDescription()
        ],
      ),
    );
  }
}