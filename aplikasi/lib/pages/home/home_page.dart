import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/classes/travelling_place.dart';
import 'package:travelling_app/fetch-helpers/data-fetcher.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/globals/gradient.dart';
import 'package:travelling_app/globals/route.dart';
import 'package:travelling_app/templates/search_bar.dart';
import 'package:travelling_app/templates/circular_loading_element.dart';
import 'package:travelling_app/templates/horizontal_item_view.dart';
import 'package:travelling_app/templates/information_widget.dart';
import 'package:travelling_app/utils/context.dart';

class HomePage extends StatelessWidget{
  final TravellingPlacesWidget travellingPlacesWidget = TravellingPlacesWidget();
  HomePage({Key? key}) : super(key: key);
  late SearchBar searchBar;

  String query = "";
  
  Widget _getSearchBarRegion(){
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(
                top: 40,
                bottom: 20
            ),
            child: searchBar
        ),
      ],
    );
  }

  Widget _getResultRegion(){
    return travellingPlacesWidget;
  }

  @override
  Widget build(BuildContext context) {
    searchBar = SearchBar(
        onSearchClick: (query){
          travellingPlacesWidget.state.performSearch(query);
        },
        maxWidth: 1000,
        searchBarShadow: const BoxShadow(
          color: Colors.black12,
          offset: Offset(0, 5),
          blurRadius: 10.0,
          spreadRadius: 0.0,
        )
    );
    return Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _getSearchBarRegion(),
            _getResultRegion(),
          ],
      )
    );
  }
}

class TravellingPlacesWidget extends StatefulWidget{

  late _TravellingPlaceState state;

  void performSearch(String query){
    state.performSearch(query);
  }

  @override
  State<StatefulWidget> createState() {
    state = _TravellingPlaceState(query: "");
    return state;
  }

}

class _TravellingPlaceState extends State<TravellingPlacesWidget>{

  String query;
  late Future<List<TravellingPlace>> futureTravellingPlaces;

  _TravellingPlaceState({
    required this.query,
  });

  void performSearch(String query){
    setState(() {
      this.query = query;
    });
  }

  Widget _getCircularProgressLoading(){
    return SizedBox(
      height: 100,
      child: CircularLoadingElement(
        message: "Sedang memuat...",
      ),
    );
  }

  Widget _getTravellingPlacesList(List<TravellingPlace> travellingPlaces){
      // return Text("Loaded!");
    double childAspectRatio = 0;
    if (ContextUtils.getScreenWidth(context) > 500){
      childAspectRatio = 1;
    }
    else{
      childAspectRatio = 3;
    }
    return Expanded(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 600,
              childAspectRatio: childAspectRatio,
            ),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: travellingPlaces.length,
            itemBuilder: (BuildContext ctx, index){
              return Padding(
                padding: EdgeInsets.all(5.0),
                child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(
                      context,
                      detailRouteName,
                      arguments: travellingPlaces[index]
                    );
                  },
                  child: HorizontalItemWidget(
                      titleText: travellingPlaces[index].placeName,
                      subtitleText: travellingPlaces[index].city,
                      rating: travellingPlaces[index].getRating(),
                  ),
                ),
              );
            }
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty){
      return const InformationWidget(
          iconData: Icons.search,
          information: "Tempat Wisata apa yang Anda cari?",
      );
    }
    else{
      return FutureBuilder(
        future: DataFetcher.getTravellingPlaces(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done){
            return _getCircularProgressLoading();
          }
          if (snapshot.hasData){
            return _getTravellingPlacesList(snapshot.data as List<TravellingPlace>);
          }
          return const Text(
            "Unknown Error Occured!"
          );
        }
      );
    }
  }
}