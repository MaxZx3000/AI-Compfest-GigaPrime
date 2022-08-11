import json
from django.http import HttpResponse
from rest_framework import status
from rest_framework.views import APIView
from .models import TravellingPlaces, TravellingPlacesRating
from sklearn.neighbors import NearestNeighbors
from sklearn.feature_extraction.text import CountVectorizer, TfidfVectorizer
from nlp_id.tokenizer import Tokenizer
from nlp_id.lemmatizer import Lemmatizer
from nltk.corpus import stopwords
import pandas as pd

# Create your views here.
# News API
class PreprocessingTemplate():
    @staticmethod
    def convert_queryset_data_to_df(queryset_data):
        query_values = queryset_data.values()
        return pd.DataFrame.from_records(query_values)

    @staticmethod
    def lemmatize_texts(data_df, fields):
        tokenized_descriptions = []
        indo_lemmatizer = Lemmatizer()
        for index, row in data_df.iterrows():
            description = row[fields]
            tokenized_sentence = indo_lemmatizer.lemmatize(description)
            tokenized_descriptions.append(tokenized_sentence)

        return tokenized_descriptions

class NewsFetchLinksAPI(APIView):
    def get(self, request):
        data = request.data
        pass

class NewsFetchDetailsAPI(APIView):
    def get(self, request):
        data = request.data

class NewsKeywordExtractionAPI(APIView):
    def get(self, request):
        data = request.data
        pass

# Content Based Filtering
class ContentBasedRecommendationAPI(APIView):
    def _get_descriptions(self, data_df, sample_description):        
        indonesian_stopwords = stopwords.words("indonesian")
        tf_idf_vectorizer = TfidfVectorizer(stop_words = indonesian_stopwords)
        vector_components = tf_idf_vectorizer.fit_transform(data_df)
        sample_description_vector_component = tf_idf_vectorizer.transform([sample_description])
        index_to_word_mapping = tf_idf_vectorizer.get_feature_names()
        
        return vector_components, sample_description_vector_component, index_to_word_mapping
    
    def _recommend_travelling_places_using_knn(self, vector_components, sample_description_vector_component):
        nearest_neighbors = NearestNeighbors(n_neighbors = 10)
        nearest_neighbors.fit(vector_components)
        k_nearest_neighbors_scores = nearest_neighbors.kneighbors(sample_description_vector_component)

        return k_nearest_neighbors_scores

    def _get_top_n_recommendations_based_on_similarity_scores(self, df, top_n_indexes):
        top_n_df = df.iloc[top_n_indexes]
        return top_n_df

    def get(self, request):
        print("Processing...")
        data = request.data
        query_result = data["query"]
        travelling_places_query_set = TravellingPlaces.objects.all()

        description_field = "description"

        data_df = PreprocessingTemplate.convert_queryset_data_to_df(travelling_places_query_set)
        lemmatized_texts = PreprocessingTemplate.lemmatize_texts(data_df, description_field)
        data_df[description_field] = lemmatized_texts
        
        vector_components, sample_description_vector_components, index_to_word_mapping = self._get_descriptions(data_df[description_field], query_result)

        top_n_distances, top_n_indexes_ranking = self._recommend_travelling_places_using_knn(vector_components, sample_description_vector_components)
        
        top_n_df = self._get_top_n_recommendations_based_on_similarity_scores(data_df, top_n_indexes_ranking.flatten())

        json_result = top_n_df.to_json(orient = "records")
        return HttpResponse(json_result, content_type = "application/json", status = status.HTTP_200_OK)

# Colab Based Filtering
class ColabBasedRecommedationAPI(APIView):
    def get(self, request):
        data = request.data
        pass