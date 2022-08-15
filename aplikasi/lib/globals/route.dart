import 'package:travelling_app/pages/detail/detail_page.dart';
import 'package:travelling_app/pages/home/home_page.dart';
import 'package:travelling_app/pages/splash_screen_page.dart';

const initialRouteName = "/";
const splashScreenRouteName = "/splash-screen";
const homeRouteName = "/home";
const detailRouteName = "/detail";

var routes = {
  splashScreenRouteName: (context) => const SplashScreenPage(),
  homeRouteName: (context) => HomePage(),
  detailRouteName: (context) => DetailPage(),
};