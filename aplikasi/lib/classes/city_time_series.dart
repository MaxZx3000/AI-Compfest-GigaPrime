import 'package:travelling_app/classes/city.dart';
import 'package:travelling_app/fetch-helpers/api-endpoint.dart';

class CountryTimeSeries{
  final String timeSeriesTitle;
  final String timeSeriesDescription;
  final String timeSeriesURL;

  CountryTimeSeries({
    required this.timeSeriesTitle,
    required this.timeSeriesDescription,
    required this.timeSeriesURL,
  });

  String getFullLinkTimeSeriesURL(){
    return "/travelling_api/$timeSeriesURL";
  }

}