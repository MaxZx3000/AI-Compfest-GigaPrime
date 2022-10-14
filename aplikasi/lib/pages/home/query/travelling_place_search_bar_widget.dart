import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/templates/search_bar.dart';
import 'package:travelling_app/utils/context.dart';

class TravellingPlaceSearchBarWidget extends StatefulWidget{

  final Function onSearchClick;

  TravellingPlaceSearchBarWidget({
    Key? key,
    required this.onSearchClick
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TravellingPlaceSearchBarWidgetState();
  }
}

class _TravellingPlaceSearchBarWidgetState extends State<TravellingPlaceSearchBarWidget>{

  Widget _getCollapsedWidget(){
    return Container(
      alignment: Alignment.topCenter,
      width: ContextUtils.getScreenWidth(context),
      padding: const EdgeInsets.all(10.0),
      color: Color(colors["orange"] as int),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Penelusuran berdasarkan query Anda",
            style: TextStyle(
                color: Colors.white
            ),
          ),
          Icon(
            Icons.arrow_drop_down_sharp,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _getChildWidget(){
    return Column(
      children: [
        const Text(
          "Silahkan masukkan query Anda disini:",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SearchBar(
          onSearchClick: (query){
            String queryString = query.toString();
            if (queryString.trim() == ""){
              Fluttertoast.showToast(
                msg: "Silahkan masukkan query pada search bar terlebih dahulu.",
              );
              return;
            }

            print("Query in String: $queryString.");
            widget.onSearchClick(query);
          },
          maxWidth: 250,
          searchBarShadow: const BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 0),
            blurRadius: 10.0,
            spreadRadius: 0.0,
          ),
          alignment: Alignment.topCenter,
          offsetValue: 100,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      backdropEnabled: true,
      minHeight: 40,
      maxHeight: 140,
      header: _getCollapsedWidget(),
      // collapsed: _getCollapsedWidget(),
      boxShadow: const [
        BoxShadow(
          spreadRadius: 0.0,
          blurRadius: 5.0,
          color: Colors.black12,
          offset: Offset(0, 5),
        ),
      ],
      panel: _getChildWidget(),
      slideDirection: SlideDirection.DOWN,
    );
  }

}

