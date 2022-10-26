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
      City(
        name: "Aceh",
        logoURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Coat_of_arms_of_Aceh.svg/1200px-Coat_of_arms_of_Aceh.svg.png",
        cityKey: CityKey.ACEH,
      ),
    ];
  }
  static List<CountryTimeSeries> _getTimeSeriesJakartaCountry(){
    return [
      CountryTimeSeries(
        timeSeriesTitle: "Jumlah Wisatawan Mancanegara",
        timeSeriesDescription: "Data ini berupa data kunjungan wisatawan mancanegara di Jakarta dengan menggunakan prediksi ARIMA.",
        timeSeriesURL: "time_series_jumlah_kunjungan_wisatawan_mancanegara_jakarta"
      ),
    ];
  }

  static List<CountryTimeSeries> _getTimeSeriesAcehCountry(){
    return [
      CountryTimeSeries(
          timeSeriesTitle: "Jumlah Wisatawan Nusantara",
          timeSeriesDescription: "Data ini berupa data kunjungan wisatawan nusantara di Aceh dengan menggunakan prediksi ARIMA.",
          timeSeriesURL: "time_series_jumlah_kunjungan_wisatawan_nusantara_aceh"
      ),
      CountryTimeSeries(
          timeSeriesTitle: "Jumlah Wisatawan Mancanegara",
          timeSeriesDescription: "Data ini berupa data kunjungan wisatawan mancanegara di Aceh dengan menggunakan prediksi ARIMA.",
          timeSeriesURL: "time_series_jumlah_kunjungan_wisatawan_mancanegara_aceh"
      ),
    ];
  }

  static List<CountryTimeSeries> getTimeSeriesBasedOnCity(CityKey cityKey){
    if (cityKey == CityKey.JAKARTA){
      return _getTimeSeriesJakartaCountry();
    }
    else if (cityKey == CityKey.ACEH){
      return _getTimeSeriesAcehCountry();
    }
    else{
      return [];
    }
  }
}