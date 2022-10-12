import 'package:flutter/material.dart';
import 'package:travelling_app/globals/asset.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/globals/route.dart';
import 'package:travelling_app/pages/home/location/home_page_location.dart';
import 'package:travelling_app/pages/home/location/travelling_place_result_widget_location.dart';
import 'package:travelling_app/pages/home/query/home_page_query.dart';
import 'package:travelling_app/pages/home/query/travelling_place_result_widget_query.dart';

class HomePage extends StatefulWidget{

  int selectedPageIndex = 0;

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>{

  late Widget currentPage;

  List<Widget> widgetTabPage = [
    const HomeQueryPage(),
    const HomeLocationPage(),
  ];

  List<Tooltip> _getTooltipWidget(BuildContext context){
    return [
      Tooltip(
        message: "Tentang Aplikasi Ini",
        child: TextButton(
          onPressed: (){
            Navigator.pushNamed(
                context,
                aboutRouteName
            );
          },
          child: Icon(
            Icons.info_outline,
            color: Color(colors["dark_green"] as int),
            size: 30,
          ),
        ),
      ),
      Tooltip(
        message: "Tempat wisata yang\ntelah dirating",
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              bookmarkRouteName,
            );
          },
          child: Icon(
            Icons.star_border,
            size: 30,
            color: Color(colors["dark_green"] as int),
          ),
        ),
      )
    ];
  }

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        actions: _getTooltipWidget(context),
        title: Row(
          children: [
            Image.asset(
              assets["app_logo"] as String,
              height: 40,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Tempat Wisata",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black
              ),
            ),
          ],
        ),
      ),
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