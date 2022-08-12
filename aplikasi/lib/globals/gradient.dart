import 'package:flutter/cupertino.dart';
import 'package:travelling_app/globals/colors.dart';

class CustomGradient{
  static LinearGradient getLightBlueToDarkGreen({
    Alignment beginAlignment = Alignment.topCenter,
    Alignment endAlignment = Alignment.bottomCenter
  }){
    return LinearGradient(
      begin: beginAlignment,
      end: endAlignment,
      colors: [
        Color(colors['light_blue'] as int),
        Color(colors['dark_green'] as int),
      ],
    );
  }
}