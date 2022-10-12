import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:geolocator_android/geolocator_android.dart';
// import 'package:geolocator_android/geolocator_apple.dart';

class GeolocationHelpers{

  static Future<bool> isLocationServiceEnabled() async{
    return await Geolocator.isLocationServiceEnabled();
  }

  static Future<String> checkLocationPermission() async{
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return "Perizinan lokasi ditolak oleh user.";
      }
      else if(permission == LocationPermission.deniedForever){
        return "Perizinan Lokasi ditolak selamanya oleh user.";
      }
      else{
        return "Servis GPS telah diaktifkan oleh user.";
      }
    }
    else{
      return "Izin GPS masih disetujui oleh user.";
    }
  }

  static Future<Position> getLocation({
    LocationAccuracy locationAccuracy = LocationAccuracy.high
  }) async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

}