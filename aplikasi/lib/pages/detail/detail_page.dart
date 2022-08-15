import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/classes/travelling_place.dart';
import 'package:travelling_app/templates/backable_app_bar.dart';
import 'package:travelling_app/utils/context.dart';

class DetailPage extends StatelessWidget{
  late TravellingPlace travellingPlace;

  DetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arguments = ContextUtils.getArguments(context);
    TravellingPlace travellingPlace = arguments as TravellingPlace;
    print(travellingPlace.placeName);

    return Scaffold(
      appBar: DetailAppBar(
        appBarTitle: "Travelling Place Detail",
      ).getInstance(context),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
              travellingPlace.placeName
          ),
        ],
      ),
    );
  }
}