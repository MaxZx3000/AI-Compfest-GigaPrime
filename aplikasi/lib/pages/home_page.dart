import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/classes/travelling_place.dart';
import 'package:travelling_app/fetch-helpers/data-fetcher.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/globals/gradient.dart';
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

  // Widget _getResultRegion(){
    // return const TravellingPlacesWidget(
    //   query: ""
    // );
  // }

  @override
  Widget build(BuildContext context) {
    DataFetcher.getTravellingPlaces("Monumen Nasional");
    return Scaffold(
        body: Column(
          children: [
            _getSearchBarRegion(),
            // _getResultRegion(),
          ],
      )
    );
  }

}
//
// class TravellingPlacesWidget extends StatefulWidget{
//   const TravellingPlacesWidget({
//     Key? key,
//     required this.query
//   }) : super(key: key);
//
//   final String query;
//
//   @override
//   State<StatefulWidget> createState() => _HomeState();
//
// }
//
// class _HomeState extends State<TravellingPlacesWidget>{
//
//   late Future<List<TravellingPlace>> futureTravellingPlaces;
//
//   Widget _getResultsRegion(){
//     return Container(
//       padding: const EdgeInsets.only(
//           left: 30.0,
//           right: 30.0,
//           bottom: 0.0,
//           top: 20.0
//       ),
//       child: const HorizontalItemWidget(
//         titleText: "Sample Title",
//         subtitleText: "Sample Subtitle Text",
//         rating: 2.0,
//       ),
//     );
//   }
//
//   Widget _getCircularProgressLoading(){
//     return const CircularLoadingElement(
//       message: "Sedang memuat...",
//     );
//   }
//
//   Widget _getWelcomeWidget(){
//      return Column(
//        children: [
//          Container(
//            decoration: BoxDecoration(
//              gradient: CustomGradient.getOrangeToDarkOrange(
//                beginAlignment: Alignment.topCenter,
//                endAlignment: Alignment.bottomCenter,
//              ),
//            ),
//            child: const Icon(
//              Icons.search,
//              size: 10,
//              color: Colors.white,
//            ),
//          ),
//        ],
//      );
//   }
//
//   Widget _getErrorWidget(String error){
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             gradient: CustomGradient.getOrangeToDarkOrange(
//               beginAlignment: Alignment.topCenter,
//               endAlignment: Alignment.bottomCenter
//             )
//           ),
//         ),
//         Text(
//           error
//         ),
//       ],
//     );
//   }
//
//   Widget _getTravellingPlacesList(List<TravellingPlace> travellingPlaces){
//       return Column(
//
//       );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     print("Reached here.");
//     DataFetcher.getTravellingPlaces("Monumen Nasional");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // body: FutureBuilder(
//         //   future: futureTravellingPlaces,
//         //   builder: (context, snapshot) {
//         //     if (widget.query.isEmpty){
//         //       return _getWelcomeWidget();
//         //     }
//         //     if (snapshot.connectionState != ConnectionState.done){
//         //       return
//         //     }
//         //     if (snapshot.hasData){
//         //       return _getTravellingPlacesList(
//         //         snapshot.data
//         //       );
//         //     }
//         //     return _getWelcomeWidget();
//         //   },
//         // ),
//         body: Column(
//
//         ),
//     );
//   }
// }