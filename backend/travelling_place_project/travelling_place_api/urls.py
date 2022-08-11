from django.contrib import admin
from .views import ContentBasedRecommendationAPI, NewsFetchLinksAPI
from rest_framework import routers
from django.urls import path, include

urlpatterns = [
    path(r'travelling_places_list', ContentBasedRecommendationAPI.as_view(), name = "list_of_travelling_places"),
    path(r'news_list', NewsFetchLinksAPI, name = "news_list"),
]