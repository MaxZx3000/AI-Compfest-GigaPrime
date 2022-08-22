import 'package:travelling_app/pages/about/about_page.dart';
import 'package:travelling_app/pages/bookmark/bookmark_page.dart';
import 'package:travelling_app/pages/detail/detail_page.dart';
import 'package:travelling_app/pages/home/home_page.dart';
import 'package:travelling_app/pages/news/news_page.dart';
import 'package:travelling_app/pages/splash_screen_page.dart';

const initialRouteName = "/";
const splashScreenRouteName = "/splash-screen";
const homeRouteName = "/home";
const detailRouteName = "/detail";
const newsRouteName = "/news";
const bookmarkRouteName = "/bookmark";
const aboutRouteName = "/about";

var routes = {
  splashScreenRouteName: (context) => const SplashScreenPage(),
  homeRouteName: (context) => HomePage(),
  detailRouteName: (context) => DetailPage(),
  newsRouteName: (context) => const NewsPage(),
  bookmarkRouteName: (context) => const BookmarkPage(),
  aboutRouteName: (context) => const AboutPage(),
};