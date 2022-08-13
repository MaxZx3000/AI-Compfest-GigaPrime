import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/fetch-helpers/data-fetcher.dart';
import 'package:travelling_app/pages/search_bar.dart';
import 'package:travelling_app/templates/circular_loading_element.dart';
import 'package:travelling_app/templates/horizontal_item_view.dart';

class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);

  Function onSearchBarClick(){
    return (){
      print("On Search Clicked!!!");
    };
  }

  Widget _getSearchBarRegion(){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 40,
            bottom: 0
          ),
          child: SearchBar(
              onSearchClick: onSearchBarClick,
              maxWidth: 1000,
              searchBarShadow: const BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 5),
                blurRadius: 10.0,
                spreadRadius: 0.0,
              )
          )
        ),
      ],
    );
  }

  Widget _getResultsRegion(){
    return Container(
      padding: const EdgeInsets.only(
          left: 30.0,
          right: 30.0,
          bottom: 0.0,
          top: 20.0
      ),
      child: const HorizontalItemWidget(
        titleText: "Sample Title",
        subtitleText: "Sample Subtitle Text",
        rating: 2.0,
      ),
    );
  }

  Widget _getCircularProgressLoading(){
    return const CircularLoadingElement(
      message: "Sedang memuat...",
    );
  }

  @override
  Widget build(BuildContext context) {
    DataFetcher.getTravellingPlaces("Monumen Nasional");
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getSearchBarRegion(),
            _getResultsRegion(),
          ],
        )
    );
  }
}