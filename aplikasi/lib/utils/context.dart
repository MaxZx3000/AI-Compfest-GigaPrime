import 'package:flutter/cupertino.dart';

class ContextUtils{
  static double getScreenWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  static Object? getArguments(BuildContext context){
    return ModalRoute.of(context)!.settings.arguments;
  }
}