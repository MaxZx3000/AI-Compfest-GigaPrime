from django.contrib import admin
from .views import ContentBasedRecommendationAPI
from rest_framework import routers
from django.urls import path, include

urlpatterns = [
    path(r'travelling_places_list', ContentBasedRecommendationAPI.as_view(), name = "list_of_travelling_places"),
]