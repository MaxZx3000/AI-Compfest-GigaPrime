import 'package:travelling_app/pages/home_page.dart';
import 'package:travelling_app/pages/splash_screen_page.dart';

const initialRouteName = "/";
const splashScreenRouteName = "/splash-screen";
const homeRouteName = "/home";

var routes = {
  splashScreenRouteName: (context) => const SplashScreenPage(),
  homeRouteName: (context) => const HomePage()
};