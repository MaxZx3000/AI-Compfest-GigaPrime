import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:travelling_app/classes/city_time_series.dart';
import 'package:travelling_app/classes/time_series.dart';
import 'package:travelling_app/fetch-helpers/data-fetcher.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/templates/backable_app_bar.dart';
import 'package:travelling_app/templates/circular_loading_element.dart';
import 'package:travelling_app/utils/context.dart';

class TimeSeriesDetailPage extends StatefulWidget{
  const TimeSeriesDetailPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TimeSeriesDetailPageState();
  }
}

class _TimeSeriesDetailPageState extends State<TimeSeriesDetailPage>{

  @override
  Widget build(BuildContext context) {
    CountryTimeSeries countryTimeSeries = ContextUtils.getArguments(context) as CountryTimeSeries;
    return Scaffold(
      appBar: BackableAppBar(
        appBarTitle: "Time Series Detail",
        onBackIconPressed: (){
          Navigator.pop(context);
        },
        rightMargin: 100,
      ).getInstance(context),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _getJumboIconWidget(),
            _getJumbotronWidget(countryTimeSeries),
            FutureBuilder(
              future: DataFetcher.fetchTimeSeriesData(
                  countryTimeSeries.getFullLinkTimeSeriesURL()
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done){
                  return _getLoadingWidget();
                }
                if (snapshot.hasData){
                  return _getTimeSeriesWidget(snapshot.data as List<TimeSeries>);
                }
                print("Error: ${snapshot.error}");
                return const Text(
                    "Unknown Error Occured!"
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getLoadingWidget(){
    return const CircularLoadingElement(
      message: "Sedang mengambil data..."
    );
  }

  Widget _getTimeSeriesWidget(List<TimeSeries> timeSeriesData){
    final charts.Series<TimeSeries, DateTime> seriesList = charts.Series<TimeSeries, DateTime>(
      id: "TimeSeries",
      data: timeSeriesData,
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (TimeSeries timeSeries, _) => timeSeries.date,
      measureFn: (TimeSeries timeSeries, _) => timeSeries.value,
    );

    return Container(
      height: 300,
      margin: const EdgeInsets.all(8.0),
      child: charts.TimeSeriesChart(
        [seriesList],
        animate: true,
        dateTimeFactory: const charts.LocalDateTimeFactory(),
      ),
    );
  }

  Widget _getJumbotronWidget(CountryTimeSeries countryTimeSeries) {
    return Container(
      padding: const EdgeInsets.all(
        16.0,
      ),
      width: double.infinity,
      color: Color(colors["dark_green"] as int),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            countryTimeSeries.timeSeriesTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            countryTimeSeries.timeSeriesDescription,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Container _getJumboIconWidget() {
    return Container(
      color: Color(colors["light_blue"] as int),
      height: 250,
      width: double.infinity,
      child: const Icon(
        Icons.timeline,
        color: Colors.white,
        size: 300,
      ),
    );
  }
}