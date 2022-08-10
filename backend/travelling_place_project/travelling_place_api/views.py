from django.shortcuts import render
from rest_framework.views import APIView

# Create your views here.
# News API

class NewsFetchLinksAPI():
    def get(self, request):
        data = request.data

        pass

class NewsFetchDetailsAPI(APIView):
    def get(self, request):
        data = request.data
        pass

class NewsKeywordExtractionAPI(APIView):
    def get(self, request):
        data = request.data
        pass

class TourismAPI(APIView):
    def get(self, request):
        data = request.data
        pass

# Content Based Filtering
class ContentBasedRecommendationAPI():
    def get(self, request):
        data = request.data
        pass

# Colab Based Filtering
class ColabBasedRecommedationAPI():
    def get(self, request):
        data = request.data
        pass