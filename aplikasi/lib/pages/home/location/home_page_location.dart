import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travelling_app/pages/home/location/travelling_place_fetch_location_options_widget.dart';
import 'package:travelling_app/pages/home/location/travelling_place_result_widget_location.dart';
import 'package:travelling_app/utils/text-formatter.dart';

class HomeLocationPage extends StatefulWidget{

  const HomeLocationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeLocationPageState();
  }
}

class _HomeLocationPageState extends State<HomeLocationPage>{

  late TravellingPlaceFetchLocationOptionsWidget travellingPlaceFetchOptionsWidget;
  late TravellingPlacesWidgetLocation travellingPlacesWidgetLocation;

  @override
  void initState() {
    super.initState();
    travellingPlacesWidgetLocation = TravellingPlacesWidgetLocation();
    travellingPlaceFetchOptionsWidget = TravellingPlaceFetchLocationOptionsWidget(
        onSearchClick: (
            // Map<String, bool> checkboxesCitiesValue,
            // Map<String, bool> checkboxesCategoriesValue,
            String city,
            String category,
            double? latitude,
            double? longitude,
            ){

          double? latitude = travellingPlaceFetchOptionsWidget.latitude;
          double? longitude = travellingPlaceFetchOptionsWidget.longitude;
          String city = travellingPlaceFetchOptionsWidget.cityValue;
          String category = travellingPlaceFetchOptionsWidget.categoryValue;
          // Map<String, bool> placenameBooleanMap = travellingPlaceFetchOptionsWidget.checkboxesCitiesValue;
          // Map<String, bool> categoryBooleanMap = travellingPlaceFetchOptionsWidget.checkboxesCategoriesValue;

          // String cityQuery = TextFormatter.convertTrueValueToString(
          //   placenameBooleanMap,
          // );
          //
          // String categoriesQuery = TextFormatter.convertTrueValueToString(
          //   categoryBooleanMap,
          // );

          if (latitude == null){
            Fluttertoast.showToast(
              msg: "Anda belum memberikan izin GPS, sehingga longitude dan langitude masih belum ada nilai. Mohon izinkan terlebih dahulu.",
            );
            return;
          }
          // if (cityQuery.trim() == ""){
          //   cityQuery = "Jakarta Yogyakarta Bandung Semarang Surabaya";
          // }
          // if (categoriesQuery.trim() == ""){
          //   categoriesQuery = "Budaya Taman Hiburan Cagar Alam Bahari Pusat Perbelanjaan Tempat Ibadah";
          // }
          print("Position Parent Widget: $latitude, $longitude.");
          print("City Query: $city.");
          print("Category Query: $category");

          travellingPlacesWidgetLocation.performSearch(
              latitude,
              longitude,
              city,
              category
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 50.0,
            ),
            child: Center(
                child: travellingPlacesWidgetLocation
            ),
          ),
          travellingPlaceFetchOptionsWidget,
        ],
      ),
    );
  }
}