import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/pages/search_bar.dart';
import 'package:travelling_app/templates/horizontal_item_view.dart';

class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);

  Function onSearchBarClick(){
    return (){
      print("On Search Clicked!!!");
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            SearchBar(
                onSearchClick: onSearchBarClick,
                maxWidth: 1000,
                searchBarShadow: const BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 5),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                )
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: const HorizontalItemWidget(
                titleText: "Sample Title",
                subtitleText: "Sample Subtitle Text",
                rating: 2.0,
              ),
            )
          ],
        )
    );
  }
}