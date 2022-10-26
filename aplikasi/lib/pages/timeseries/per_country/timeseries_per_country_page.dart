import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/classes/city.dart';
import 'package:travelling_app/classes/city_time_series.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/globals/route.dart';
import 'package:travelling_app/local_data_provider/timeseries_data_provider.dart';
import 'package:travelling_app/templates/backable_app_bar.dart';
import 'package:travelling_app/templates/horizontal_item_view.dart';
import 'package:travelling_app/templates/top_image_horizontal_item_view.dart';
import 'package:travelling_app/utils/context.dart';

class TimeSeriesPerCountryPage extends StatelessWidget{
  const TimeSeriesPerCountryPage({Key? key}) : super(key: key);

  Widget _getJumbotronImage(City city){
    return Stack(
      alignment: Alignment.bottomLeft,
      fit: StackFit.loose,
      children: [
        Image.network(
          city.logoURL,
          width: double.infinity,
          height: 300,
          fit: BoxFit.fitHeight,
        ),
        Container(
          margin: const EdgeInsets.only(
            bottom: 16.0,
          ),
          width: 150,
          padding: const EdgeInsets.all(
            16.0
          ),
          color: Color(secondaryColors["dark_translucent_gray"] as int).withOpacity(0.8),
          child: Text(
            city.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ],
    );
  }

  Widget _getContentWidget(City city){
    final List<CountryTimeSeries> countryTimeSeries = TimeSeriesDataProvider.getTimeSeriesBasedOnCity(
      city.cityKey,
    );
    return GridView.builder(
      padding: const EdgeInsets.all(12.0),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        mainAxisExtent: 120
      ),
      itemCount: countryTimeSeries.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: HorizontalItemWidget(
            titleText: countryTimeSeries[index].timeSeriesTitle,
            subtitleText: countryTimeSeries[index].timeSeriesDescription,
            height: 160,
            maxLines: 2,
            width: double.infinity,
            topRightWidget: null,
            onClickCard: (){
              Navigator.pushNamed(
                context,
                timeSeriesDetailRouteName,
                arguments: countryTimeSeries[index],
              );
            },
            additionalWidget: const SizedBox(
              height: 0,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final City city = ContextUtils.getArguments(context) as City;
    return Scaffold(
      appBar: BackableAppBar(
        rightMargin: 150,
        onBackIconPressed: (){
          Navigator.pop(context);
        },
        appBarTitle: "${city.name} Time Series",
      ).getInstance(context),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _getJumbotronImage(city),
            _getContentWidget(city),
          ]
        ),
      ),
    );
  }

}