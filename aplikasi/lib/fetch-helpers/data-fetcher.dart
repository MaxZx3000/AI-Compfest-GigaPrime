import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travelling_app/classes/news.dart';
import 'package:travelling_app/classes/news_detail.dart';
import 'package:travelling_app/classes/time_series.dart';
import 'package:travelling_app/classes/travelling_place.dart';
import 'package:travelling_app/classes/user/bookmarked_travelling_place.dart';
import 'package:travelling_app/fetch-helpers/http-helpers.dart';

class DataFetcher{
  static Future<List<TravellingPlace>> getTravellingPlacesByQuery(
      String query,) async {
    final response = await HttpHelpers.fetchTravellingPlacesUserQueryList(
      query,
    );
    dynamic jsonDecoded = jsonDecode(response.body);
    List<TravellingPlace> travellingPlaces = [];
    jsonDecoded.forEach((element) {
      // print(element);
      TravellingPlace travellingPlace = TravellingPlace.setFromJSON(element);
      travellingPlaces.add(travellingPlace);
    });
    return travellingPlaces;
  }

  static Future<List<TravellingPlace>> getTravellingPlacesByLocation(
    String categories,
    String cities,
    double latitude,
    double longitude,) async {
    final response = await HttpHelpers.fetchTravellingPlacesUserLocationList(
      categories,
      cities,
      latitude,
      longitude
    );
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

    dynamic jsonDecoded = jsonDecode(response.body);

    NewsDetail newsDetail = NewsDetail.setFromJSON(
      news,
      jsonDecoded,
    );

    print("News Detail: $newsDetail");

    return newsDetail;
  }

  static Future<List<TravellingPlace>> getColabTravellingPlaces(
    List<BookmarkedTravellingPlace> bookmarkedTravellingPlace,
  ) async{

    final response = await HttpHelpers.fetchColabTravellingPlaces(
      bookmarkedTravellingPlace,
    );

    dynamic jsonDecoded = jsonDecode(response.body);

    List<TravellingPlace> recommendedTravellingPlaces = [];

    jsonDecoded.forEach((element){
      TravellingPlace recommendedTravellingPlace = TravellingPlace.setFromJSON(element);
      recommendedTravellingPlaces.add(recommendedTravellingPlace);
    });

    return recommendedTravellingPlaces;
  }
  static Future<List<TimeSeries>> fetchTimeSeriesData(
      String timeSeriesURL
  ) async{
    final response = await HttpHelpers.fetchTimeSeriesData(timeSeriesURL);

    dynamic jsonDecoded = jsonDecode(response.body);
    List<TimeSeries> timeSeriesData = [];

    jsonDecoded.forEach((element){
      timeSeriesData.add(TimeSeries.setFromJSON(element));
    });
    return timeSeriesData;
  }
}