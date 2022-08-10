from django.shortcuts import render
from rest_framework.views import APIView

# Create your views here.
# News API
class NewsFetch(APIView):
    def get(self, request):
        pass

class NewsTopicModelling(APIView):
    def get(self, request):
        pass

class TourismDescription(APIView):
    def get(self, request):
        pass

# Content Based Filtering
class ContentBasedRecommendationTourismPlace():
    def get(self, request):
        pass

# Colab Based Filtering
class ColabBasedRecommedationTourismPlace():
    def get(self, request):
        pass