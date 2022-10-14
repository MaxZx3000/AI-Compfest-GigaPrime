import 'package:travelling_app/classes/city.dart';
import 'package:travelling_app/classes/city_time_series.dart';

class TimeSeriesDataProvider{
  static List<City> getTimeSeriesCountries(){
    return [
      City(
        name: "Jakarta",
        logoURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Coat_of_arms_of_Jakarta.svg/1200px-Coat_of_arms_of_Jakarta.svg.png",
        cityKey: CityKey.JAKARTA,
      ),
    ];
  }
  static List<CountryTimeSeries> _getTimeSeriesJakartaCountry(){
    return [
      CountryTimeSeries(
        timeSeriesTitle: "Jumlah Wisatawan Mancanegara",
        timeSeriesDescription: "Data ini Berisi Mengenai Data Kunjungan Wisatawan Mancanegara ke Jakart",
        timeSeriesURL: "time_series_jumlah_kunjungan_wisatawan_mancanegara"
      ),
    ];
  }

  static List<CountryTimeSeries> getTimeSeriesBasedOnCity(CityKey cityKey){
    if (cityKey == CityKey.JAKARTA){
      return _getTimeSeriesJakartaCountry();
    }
    else{
      return [];
    }
  }
}