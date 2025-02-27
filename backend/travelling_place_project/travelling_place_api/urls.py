from django.contrib import admin
from .views import ColabBasedRecommedationAPI, ContentBasedRecommendationUserQueryAPI, ContentBasedRecommendationUserLocationAPI, ContentBasedRecommendationUserBudgetAPI, NewsFetchDetailsAPI, NewsFetchLinksAPI, TimeSeriesWisatawanMancanegaraAcehAPI, TimeSeriesWisatawanMancanegaraJakartaAPI, TimeSeriesWisatawanNusantaraAcehAPI
from rest_framework import routers
from django.urls import path, include

urlpatterns = [
    path(r'travelling_places_user_query_list', ContentBasedRecommendationUserQueryAPI.as_view(), name = "list_of_travelling_places_by_query"),
    path(r'travelling_places_user_location_list', ContentBasedRecommendationUserLocationAPI.as_view(), name = "list_of_travelling_places_by_location"),
    path(r'travelling_places_user_budget_list', ContentBasedRecommendationUserBudgetAPI.as_view(), name = "list_of_travelling_places_by_budget"),
    path(r'news_list', NewsFetchLinksAPI.as_view(), name = "news_list"),
    path(r'news_details', NewsFetchDetailsAPI.as_view(), name = "news_details"),
    path(r'colab_filtering_travelling_places', ColabBasedRecommedationAPI.as_view(), name = "colab_filtering_travelling_places"),
    path(r'time_series_jumlah_kunjungan_wisatawan_mancanegara_jakarta', TimeSeriesWisatawanMancanegaraJakartaAPI.as_view(), name = "time_series_jumlah_kunjungan_wisatawan_mancanegara_jakarta"),
    path(r'time_series_jumlah_kunjungan_wisatawan_mancanegara_aceh', TimeSeriesWisatawanMancanegaraAcehAPI.as_view(), name = "time_series_jumlah_kunjungan_wisatawan_mancanegara_aceh"),
    path(r'time_series_jumlah_kunjungan_wisatawan_nusantara_aceh', TimeSeriesWisatawanNusantaraAcehAPI.as_view(), name = "time_series_jumlah_kunjungan_wisatawan_nusantara_aceh")
]