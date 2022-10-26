import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/globals/gradient.dart';
import 'package:travelling_app/templates/circular_loading_element.dart';
import 'package:travelling_app/utils/context.dart';
import 'package:travelling_app/utils/geolocation_helpers.dart';

class TravellingPlaceFetchLocationOptionsWidget extends StatefulWidget{

  TravellingPlaceFetchLocationOptionsWidget({
    super.key,
    required this.onSearchClick, }
  );

  // final checkboxesCitiesValue = {
  //   "Jakarta": false,
  //   "Yogyakarta": false,
  //   "Bandung": false,
  //   "Semarang": false,
  //   "Surabaya": false,
  // };
  //
  // final checkboxesCategoriesValue = {
  //   'Budaya': false,
  //   'Taman Hiburan': false,
  //   'Cagar Alam': false,
  //   'Bahari': false,
  //   'Pusat Perbelanjaan': false,
  //   'Tempat Ibadah': false,
  // };

  String categoryValue = "Budaya";
  String cityValue = "Jakarta";

  double? latitude;
  double? longitude;

  final Function onSearchClick;

  @override
  State<StatefulWidget> createState() => _TravellingPlaceFetchLocationOptionsWidgetState();

}

class _TravellingPlaceFetchLocationOptionsWidgetState extends State<TravellingPlaceFetchLocationOptionsWidget>{

  final List<String> cityNames = [
    "Jakarta",
    "Yogyakarta",
    "Bandung",
    "Semarang",
    "Surabaya",
  ];

  final List<String> categoryNames = [
    'Budaya',
    'Taman Hiburan',
    'Cagar Alam',
    'Bahari',
    'Pusat Perbelanjaan',
    'Tempat Ibadah',
  ];

  void refresh(){
    setState(() {});
  }

  Widget _getCollapsedWidget(){
    return Container(
      alignment: Alignment.center,
      width: ContextUtils.getScreenWidth(context),
      padding: const EdgeInsets.all(10.0),
      color: Color(colors["orange"] as int),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Penelusuran berdasarkan lokasi Anda",
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

  List<RadioListTile> _getAllCitiesCheckboxes(){
    // List<String> checkboxKeys = widget.checkboxesCitiesValue.keys.toList();
    // List<bool> checkboxValues = widget.checkboxesCitiesValue.values.toList();
    List<RadioListTile> radioCityElements = List.generate(cityNames.length, (index) {
      return RadioListTile(
        title: Text(cityNames[index]),
        value: cityNames[index],
        onChanged: (String? cityName){
          setState(() {
            widget.cityValue = cityName!;
          });
        },
        groupValue: widget.cityValue,
        controlAffinity: ListTileControlAffinity.trailing,
      );
    }
    ).toList();
    return radioCityElements;
  }

  List<RadioListTile> _getAllCategoriesCheckboxes(){
    // List<String> checkboxKeys = widget.checkboxesCategoriesValue.keys.toList();
    // List<bool> checkboxValues = widget.checkboxesCategoriesValue.values.toList();
    List<RadioListTile> radioButtonElements = List.generate(categoryNames.length, (index) {
      return RadioListTile(
        title: Text(categoryNames[index]),
        value: categoryNames[index],
        onChanged: (String? value){
          setState(() {
            widget.categoryValue = value!;
          });
        },
        groupValue: widget.categoryValue,
        controlAffinity: ListTileControlAffinity.trailing,
      );
    }
    ).toList();
    return radioButtonElements;
  }

  Widget _getHeadingWidget(String title, IconData iconData){
    return Container(
      decoration: BoxDecoration(
        gradient: CustomGradient.getOrangeToDarkOrange(
            beginAlignment: Alignment.centerLeft,
            endAlignment: Alignment.centerRight
        ),
      ),
      padding: const EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
        left: 15.0,
        right: 15.0,
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white
            ),
            textAlign: TextAlign.start,
          )
        ],
      ),
    );
  }

  TableCell tableCellText({
    double paddingLeft = 0,
    double paddingRight = 0,
    String text = "",
    TextAlign textAlign = TextAlign.left,
    verticalAlignment = TableCellVerticalAlignment.middle,
  }) {
    return TableCell(
      verticalAlignment: verticalAlignment,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 8.0,
          top: 8.0,
          left: paddingLeft,
          right: paddingRight,
        ),
        child: Text(
          text,
          textAlign: textAlign,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  TableCell tableCellWithWidget(
      double paddingLeft,
      double paddingRight,
      Widget widget,
    ) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.top,
      child: Padding(
        padding: EdgeInsets.only(
          top: 0,
          bottom: 0,
          left: paddingLeft,
          right: paddingRight,
        ),
        child: widget,
      ),
    );
  }

  Widget _requestPermissionWidget(){
    widget.latitude = null;
    widget.longitude = null;
    return Column(
      children: [
        const Text(
          "Mohon bukakan akses untuk izin lokasi, agar bisa memberikan rekomendasi tempat wisata berdasarkan lokasi terdekat Anda.",
        ),
        ElevatedButton(
          onPressed: () async{
            String permissionResult = await GeolocationHelpers.checkLocationPermission();
            Fluttertoast.showToast(
                msg: permissionResult
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          child: const Text(
            "Izinkan Fitur GPS"
          ),
        )
      ],
    );
  }

  Widget _getChildWidget(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          _getHeadingWidget(
            "Categories",
            Icons.category,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: _getAllCategoriesCheckboxes(),
          ),
          _getHeadingWidget(
            "Kota",
            Icons.location_city,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: _getAllCitiesCheckboxes(),
          ),
          _getHeadingWidget(
            "Lokasi Anda",
            Icons.place
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
              bottom: 15.0,
              right: 25.0,
              left: 15.0
            ),
            child: FutureBuilder(
              future: GeolocationHelpers.getLocation(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done){
                  return _getLoadingWidget();
                }
                if (snapshot.hasData){
                  return getLocationWidget(snapshot.data as Position);
                }
                if (snapshot.error.toString() == "User denied permissions to access the device's location."){
                  return _requestPermissionWidget();
                }
                print("Current Error: ${snapshot.error.toString()}");
                return const Text(
                  "Unknown Error Occured!"
                );
              },
            ),
          ),
          ElevatedButton(
              onPressed: (){
                widget.onSearchClick(
                  widget.cityValue,
                  widget.categoryValue,
                  widget.longitude,
                  widget.latitude,
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: const Text(
                "Lakukan Pencarian!"
              ),
          ),
          const SizedBox(
            height: 50,
          ),
        ]
      ),
    );
  }

  Table getLocationWidget(Position position) {
    widget.latitude = position.latitude;
    widget.longitude = position.longitude;
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            tableCellText(
              text: "Diambil dari GPS"
            ),
            tableCellWithWidget(
              0.0,
              0.0,
              ElevatedButton(
                onPressed: () async{
                  setState((){});
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: const Text(
                  "Muat Ulang"
                ),
              )
            ),
          ]
        ),
        TableRow(
          children: [
            tableCellText(
              text: "Latitude",
            ),
            tableCellText(
              text: position.latitude.toString(),
              textAlign: TextAlign.end,
            ),
          ]
        ),
        TableRow(
          children: [
            tableCellText(
              text: "Longitude",
            ),
            tableCellText(
              text: position.longitude.toString(),
              textAlign: TextAlign.end,
            ),
          ]
        ),
      ],
    );
  }

  Widget _getLoadingWidget(){
    return const CircularLoadingElement(
      message: "Sedang Menentukan Lokasi Anda...",
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      backdropEnabled: true,
      minHeight: 40,
      maxHeight: 300,
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