class TimeSeries{
  DateTime date;
  double value;

  TimeSeries({
    required this.date,
    required this.value,
  });

  double getDateInDouble(){
    return this.date.millisecondsSinceEpoch.toDouble();
  }

  factory TimeSeries.setFromJSON(dynamic jsonDatum){
    return TimeSeries(
      date: DateTime.parse(jsonDatum["date"]),
      value: jsonDatum["value"]
    );
  }
}