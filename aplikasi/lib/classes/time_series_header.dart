import 'package:travelling_app/classes/time_series.dart';

class TimeSeriesHeader{
  String trend;
  List<TimeSeries> timeSeries;

  TimeSeriesHeader({
    required this.trend,
    required this.timeSeries,
  });

  factory TimeSeriesHeader.setFromJSON(dynamic jsonDatum){
    List<TimeSeries> timeSeries = [];

    jsonDatum["result"].forEach((element){
      timeSeries.add(TimeSeries.setFromJSON(element));
    });

    return TimeSeriesHeader(
      trend: jsonDatum["trend"],
      timeSeries: timeSeries,
    );
  }
}