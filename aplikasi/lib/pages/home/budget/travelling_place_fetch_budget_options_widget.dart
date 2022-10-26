import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/globals/gradient.dart';
import 'package:travelling_app/templates/circular_loading_element.dart';
import 'package:travelling_app/utils/context.dart';
import 'package:travelling_app/utils/geolocation_helpers.dart';

class TravellingPlaceFetchBudgetOptionsWidget extends StatefulWidget{

  TravellingPlaceFetchBudgetOptionsWidget({
    super.key,
    required this.onSearchClick, }
  );

  String categoryValue = "Budaya";
  String cityValue = "Jakarta";

  int ticketPrice = 0;
  late Widget slideUpPanelWidget;

  final Function onSearchClick;

  @override
  State<StatefulWidget> createState() => _TravellingPlaceFetchBudgetOptionsWidgetState();

}

class _TravellingPlaceFetchBudgetOptionsWidgetState extends State<TravellingPlaceFetchBudgetOptionsWidget>{

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

  final PanelController _pc = PanelController();

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
            "Penelusuran berdasarkan harga tiket",
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

  Table _getTicketPriceWidget() {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            tableCellText(
              text: "Silahkan input disini: ",
              paddingLeft: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 32.0,
              ),
              child: TextFormField(
                controller: TextEditingController(
                  text: widget.ticketPrice.toString(),
                ),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "0",
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                onChanged: (String value){
                  if (value.isNotEmpty){
                    widget.ticketPrice = int.parse(value);
                  }
                  else{
                    widget.ticketPrice = 0;
                  }
                },
              ),
            ),
          ]
        ),
      ]
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
            "Harga Tiket",
            Icons.money
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _getTicketPriceWidget()
            ]
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: (){
              widget.onSearchClick(
                  widget.cityValue,
                  widget.categoryValue,
                  widget.ticketPrice
              );
              _pc.close();
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
      controller: _pc,
      slideDirection: SlideDirection.DOWN,
      onPanelClosed: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}