import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travelling_app/pages/home/query/travelling_place_result_widget_query.dart';
import 'package:travelling_app/pages/home/query/travelling_place_search_bar_widget.dart';
import 'package:travelling_app/templates/search_bar.dart';

class HomeQueryPage extends StatefulWidget{
  const HomeQueryPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeQueryPageState();
  }
}

class _HomeQueryPageState extends State<HomeQueryPage>{
  late TravellingPlacesWidgetQuery travellingPlacesQueryWidget;

  late TravellingPlaceSearchBarWidget travellingPlaceSearchBarWidget;

  String query = "";


  void refresh(){
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    travellingPlacesQueryWidget = TravellingPlacesWidgetQuery();
    travellingPlaceSearchBarWidget = TravellingPlaceSearchBarWidget(
        onSearchClick: (query){
          travellingPlacesQueryWidget.performSearch(
            query,
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.only(
                top: 50.0,
              ),
              child: Center(child: travellingPlacesQueryWidget)
          ),
          travellingPlaceSearchBarWidget,
        ],
      ),
    );
  }
}
