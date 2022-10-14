import 'package:travelling_app/pages/about/about_page.dart';
import 'package:travelling_app/pages/bookmark/bookmark_page.dart';
import 'package:travelling_app/pages/detail/detail_page.dart';
import 'package:travelling_app/pages/home/home_page.dart';
import 'package:travelling_app/pages/home/travelling_place_home_page.dart';
import 'package:travelling_app/pages/news/news_page.dart';
import 'package:travelling_app/pages/splash_screen_page.dart';
import 'package:travelling_app/pages/home/timeseries_countries_list_page.dart';
import 'package:travelling_app/pages/timeseries/detail/timeseries_detail_page.dart';
import 'package:travelling_app/pages/timeseries/per_country/timeseries_per_country_page.dart';

const initialRouteName = "/";
const splashScreenRouteName = "/splash-screen";
const homeRouteName = "/home";
const detailRouteName = "/detail";
const newsRouteName = "/news";
const bookmarkRouteName = "/bookmark";
const aboutRouteName = "/about";
const timeSeriesPerCountryRouteName = "/time_series_per_country_name";
const timeSeriesDetailRouteName = "/time_series_detail_page";

var routes = {
  splashScreenRouteName: (context) => const SplashScreenPage(),
  homeRouteName: (context) => const HomePage(),
  detailRouteName: (context) => DetailPage(),
  newsRouteName: (context) => const NewsPage(),
  bookmarkRouteName: (context) => const BookmarkPage(),
  aboutRouteName: (context) => const AboutPage(),
  timeSeriesPerCountryRouteName: (context) => const TimeSeriesPerCountryPage(),
  timeSeriesDetailRouteName: (context) => const TimeSeriesDetailPage(),
};