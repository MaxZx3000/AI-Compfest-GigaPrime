import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/globals/asset.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/globals/route.dart';
import 'package:travelling_app/pages/home/timeseries_countries_list_page.dart';
import 'package:travelling_app/pages/home/travelling_place_home_page.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePage();

}

class _HomePage extends State<HomePage>{

  late Widget currentPage;

  Widget _getListTileDrawer(
      Function onTap,
      String title,
      IconData iconData,
    ){
    return ListTile(
      onTap: (){
        onTap();
      },
      title: Text(title),
      leading: Icon(
        iconData,
        color: Color(colors["dark_green"] as int),
        size: 30,
      ),
    );
  }

  Widget _getHeaderTextDrawer(
    String headerText,
  ){
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 18.0,
        right: 18.0,
      ),
      child: Text(
        headerText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Drawer _getDrawerWidget(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'TrAIvel',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          _getHeaderTextDrawer(
            "Fitur Utama"
          ),
          _getListTileDrawer(
            (){
              setState(() {
                currentPage = TravellingPlaceHomePage();
              });
            },
            "Tempat Wisata",
            Icons.travel_explore
          ),
          _getListTileDrawer(
            (){
              setState(() {
                currentPage = const TimeSeriesCountriesPage();
              });
            },
            "Time Series",
            Icons.timeline
          ),
          const Divider(),
          _getHeaderTextDrawer(
            "Lainnya"
          ),
          _getListTileDrawer(
            (){
              Navigator.pushNamed(
                context,
                bookmarkRouteName
              );
            },
            "Tempat Wisata yang dirating",
            Icons.star
          ),
          _getListTileDrawer(
            (){
              Navigator.pushNamed(
                context,
                aboutRouteName
              );
            },
            "Tentang Aplikasi Ini",
            Icons.info_outline
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    currentPage = TravellingPlaceHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _getDrawerWidget(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assets["app_logo"] as String,
              height: 40,
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
      body: currentPage,
    );
  }
}