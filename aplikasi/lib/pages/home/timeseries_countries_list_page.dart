import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/classes/city.dart';
import 'package:travelling_app/globals/route.dart';
import 'package:travelling_app/local_data_provider/timeseries_data_provider.dart';
import 'package:travelling_app/templates/image_simple_item_view.dart';

class TimeSeriesCountriesPage extends StatelessWidget{
  const TimeSeriesCountriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  List<City> cities = TimeSeriesDataProvider.getTimeSeriesCountries();
    return Scaffold(
      body: Column(
        children: [
          GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: 80,
              maxCrossAxisExtent: 300,
            ),
            itemCount: cities.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index){
              return ImageSimpleItemView(
                title: cities[index].name,
                imageURL: cities[index].logoURL,
                onCardClick: (){
                  Navigator.pushNamed(
                    context,
                    timeSeriesPerCountryRouteName,
                    arguments: cities[index]
                  );
                },
                height: 80,
              );
            },
          ),
        ],
      ),
    );
  }
}