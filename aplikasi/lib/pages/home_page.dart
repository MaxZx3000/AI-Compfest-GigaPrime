import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/pages/search_bar.dart';

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
        body: Stack(
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
            )
          ],
        )
    );
  }
}