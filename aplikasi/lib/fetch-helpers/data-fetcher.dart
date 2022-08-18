import 'dart:convert';

import 'package:travelling_app/classes/news.dart';
import 'package:travelling_app/classes/news_detail.dart';
import 'package:travelling_app/classes/travelling_place.dart';
import 'package:travelling_app/fetch-helpers/http-helpers.dart';

class DataFetcher{
  static Future<List<TravellingPlace>> getTravellingPlaces(String query) async {
    final response = await HttpHelpers.fetchTravellingPlacesList(query);
    dynamic jsonDecoded = jsonDecode(response.body);
    List<TravellingPlace> travellingPlaces = [];
    jsonDecoded.forEach((element) {
      TravellingPlace travellingPlace = TravellingPlace.setFromJSON(element);
      travellingPlaces.add(travellingPlace);
    });
    return travellingPlaces;
  }
  static Future<List<News>> getNewsList(String query) async {
    String newsQuery = "Berita $query";
    final response = await HttpHelpers.fetchNewsList(newsQuery);
    dynamic jsonDecoded = jsonDecode(response.body)["info"];

    List<News> news = [];
    jsonDecoded.forEach((element){
      News oneNews = News.setFromJSON(element);
      news.add(oneNews);
    });

    print(news);

    return news;
  }
  static Future<NewsDetail> getNewsDetail(
      News news) async{
    final response = await HttpHelpers.fetchNewsDetails(
      news.link
    );

    print("Fetch News Detaiis Done...");

    dynamic jsonDecoded = jsonDecode(response.body);

    print(jsonDecoded);

    NewsDetail newsDetail = NewsDetail.setFromJSON(
      news,
      jsonDecoded,
    );

    print("News Detail: $newsDetail");

    return newsDetail;
  }
}