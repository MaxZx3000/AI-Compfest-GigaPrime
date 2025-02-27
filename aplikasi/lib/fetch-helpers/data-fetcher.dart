import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travelling_app/classes/news.dart';
import 'package:travelling_app/classes/news_detail.dart';
import 'package:travelling_app/classes/time_series.dart';
import 'package:travelling_app/classes/time_series_header.dart';
import 'package:travelling_app/classes/travelling_place.dart';
import 'package:travelling_app/classes/travelling_place_query.dart';
import 'package:travelling_app/classes/user/bookmarked_travelling_place.dart';
import 'package:travelling_app/fetch-helpers/http-helpers.dart';

class DataFetcher{
  static Future<List<TravellingPlaceQuery>> getTravellingPlacesByQuery(
      String query,) async {
    final response = await HttpHelpers.fetchTravellingPlacesUserQueryList(
      query,
    );
    dynamic jsonDecoded = jsonDecode(response.body);
    List<TravellingPlaceQuery> travellingPlacesQuery = [];
    jsonDecoded.forEach((element) {
      TravellingPlaceQuery travellingPlaceQuery = TravellingPlaceQuery.setFromJSON(element);
      travellingPlacesQuery.add(travellingPlaceQuery);
    });
    return travellingPlacesQuery;
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

  static Future<List<TravellingPlace>> getTravellingPlaceByBudget(
      String categories,
      String cities,
      int ticketPrice,
  ) async{
    final response = await HttpHelpers.fetchTravellingPlacesUserBudgetList(
        categories,
        cities,
        ticketPrice,
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
    String newsQuery = "$query Berita";
    final response = await HttpHelpers.fetchNewsList(newsQuery);
    dynamic jsonDecoded = jsonDecode(response.body)["info"];

    List<News> news = [];
    jsonDecoded.forEach((element){
      News oneNews = News.setFromJSON(element);
      news.add(oneNews);
    });

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
  static Future<TimeSeriesHeader> fetchTimeSeriesData(
      String timeSeriesURL
  ) async{
    final response = await HttpHelpers.fetchTimeSeriesData(timeSeriesURL);

    dynamic jsonDecoded = jsonDecode(response.body);

    TimeSeriesHeader timeSeriesHeader = TimeSeriesHeader.setFromJSON(
      jsonDecoded
    );
    return timeSeriesHeader;
  }
}