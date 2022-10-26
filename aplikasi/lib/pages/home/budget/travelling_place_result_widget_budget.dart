import 'package:flutter/material.dart';
import 'package:travelling_app/classes/travelling_place.dart';
import 'package:travelling_app/fetch-helpers/data-fetcher.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/globals/route.dart';
import 'package:travelling_app/templates/circular_loading_element.dart';
import 'package:travelling_app/templates/top_image_horizontal_item_view.dart';
import 'package:travelling_app/templates/information_widget.dart';
import 'package:travelling_app/templates/rating_widget.dart';

class TravellingPlacesWidgetBudget extends StatefulWidget{

  late _TravellingPlaceBudgetState state;

  int ticketPrice = 0;
  String cities = "";
  String categories = "";

  void performSearch(
      int ticketPrice,
      String cities,
      String categories,
    ){
    state.performSearch(
      ticketPrice,
      categories,
      cities
    );
  }

  @override
  State<StatefulWidget> createState() {
    state = _TravellingPlaceBudgetState();
    return state;
  }

}

class _TravellingPlaceBudgetState extends State<TravellingPlacesWidgetBudget>{

  late Future<List<TravellingPlace>> futureTravellingPlaces;

  void performSearch(
      int ticketPrice,
      String categories,
      String cities,){
    setState(() {
      widget.ticketPrice = ticketPrice;
      widget.categories = categories;
      widget.cities = cities;
    });
  }

  Widget _getCircularProgressLoading(){
    return const SizedBox(
      height: 100,
      child: CircularLoadingElement(
        message: "Sedang memuat...",
      ),
    );
  }

  Widget _getTravellingPlacesList(List<TravellingPlace> travellingPlaces){
    // return Text("Loaded!");
    // double childAspectRatio = 0;
    // if (ContextUtils.getScreenWidth(context) > 500){
    //   childAspectRatio = 2.5;
    // }
    // else{
    //   childAspectRatio = 3;
    // }
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 600,
          mainAxisExtent: 405,
        ),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: travellingPlaces.length,
        itemBuilder: (BuildContext ctx, index){
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: TopImageHorizontalItemWidget(
              imageURL: travellingPlaces[index].imageURL,
              titleText: travellingPlaces[index].placeName,
              subtitleText: travellingPlaces[index].city,
              additionalWidget: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RatingWidget(
                      rating: travellingPlaces[index].getRating(),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1.0,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          bottom: 5.0,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                                Icons.category
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                                travellingPlaces[index].category
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0
                        ),
                        child: Row(
                          children: [
                            const Icon(
                                Icons.money
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              travellingPlaces[index].getPrice()
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              height: 125,
              onClickCard: (){
                Navigator.pushNamed(
                  context,
                  detailRouteName,
                  arguments: travellingPlaces[index]
                );
              },
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty ||
        widget.cities.isEmpty){
      return const InformationWidget(
        iconData: Icons.search,
        widgetWidth: 300,
        information: "Tempat Wisata apa yang Anda cari?",
      );
    }
    else{
      return FutureBuilder(
          future: DataFetcher.getTravellingPlaceByBudget(
            widget.categories,
            widget.cities,
            widget.ticketPrice,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done){
              return _getCircularProgressLoading();
            }
            if (snapshot.hasData){
              return _getTravellingPlacesList(snapshot.data as List<TravellingPlace>);
            }
            print("Error: ${snapshot.error.toString()}");
            return const Text(
                "Unknown Error Occured!"
            );
          }
      );
    }
  }
}