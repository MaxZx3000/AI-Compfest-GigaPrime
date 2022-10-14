import 'package:flutter/material.dart';
import 'package:travelling_app/globals/asset.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/globals/route.dart';
import 'package:travelling_app/pages/home/location/home_page_location.dart';
import 'package:travelling_app/pages/home/query/home_page_query.dart';

class TravellingPlaceHomePage extends StatefulWidget{

  int selectedPageIndex = 0;

  @override
  State<StatefulWidget> createState() {
    return _TravellingPlaceHomePageState();
  }
}

class _TravellingPlaceHomePageState extends State<TravellingPlaceHomePage>{

  late Widget currentPage;

  List<Widget> widgetTabPage = [
    const HomeQueryPage(),
    const HomeLocationPage(),
  ];

  @override
  void initState() {
    super.initState();
    currentPage = widgetTabPage[widget.selectedPageIndex];
  }

  void onItemTapped(int index){
    setState(() {
      widget.selectedPageIndex = index;
      currentPage = widgetTabPage[widget.selectedPageIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(width: 4, color: Color(colors["orange"] as int))),
          gradient: LinearGradient(
            colors: [
              Color(colors['light_blue'] as int),
              Color(colors['dark_green'] as int)
            ]
          )
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: 'Query',
              backgroundColor: Color(colors['dark_orange'] as int),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.location_on),
              label: 'Location',
              backgroundColor: Color(colors['dark_orange'] as int),
            ),
          ],
          currentIndex: widget.selectedPageIndex,
          selectedItemColor: Colors.white,
          onTap: onItemTapped,
        ),
      ),
    );
  }
}