import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travelling_app/pages/home/query/travelling_place_result_widget_query.dart';
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

  late SearchBar searchBar;

  String query = "";


  void refresh(){
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    travellingPlacesQueryWidget = TravellingPlacesWidgetQuery();
  }

  @override
  Widget build(BuildContext context) {
    searchBar = SearchBar(
      onSearchClick: (query){
        String queryString = query.toString();

        if (queryString.trim() == ""){
          Fluttertoast.showToast(
            msg: "Silahkan masukkan query pada search bar terlebih dahulu.",
          );
          return;
        }

        print("Query in String: $queryString.");
        travellingPlacesQueryWidget.performSearch(
          query,
        );
      },
      maxWidth: 250,
      searchBarShadow: const BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 0),
        blurRadius: 10.0,
        spreadRadius: 0.0,
      ),
      alignment: Alignment.center,
      offsetValue: 150,
    );
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 1.0,
            bottom: 1.0,
            left: 10.0,
            right: 10.0
          ),
          child: searchBar
        ),
        Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: Column(
              children: [
                Center(
                  child: travellingPlacesQueryWidget
                ),
              ],
            )
        ),
      ],
    );
  }
}
