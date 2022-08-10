from dataclasses import field
from django.shortcuts import render
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
    def convert_queryset_data_to_df(queryset_data, fields):
        query_values = queryset_data.values(fields)
        return pd.DataFrame.from_records(query_values)

    @staticmethod
    def lemmarize_texts(data_df, fields):
        tokenized_descriptions = []
        indo_lemmatizer = Lemmatizer()
        for index, row in data_df.iterrows():
            description = row[fields]
            tokenized_sentence = indo_lemmatizer.lemmatize(description)
            tokenized_descriptions.append(tokenized_sentence)
    

class NewsFetchLinksAPI():
    def get(self, request):
        data = request.data
        pass

class NewsFetchDetailsAPI(APIView):
    def get_descriptions(sample_description):
        descriptions = dataset[tokenized_description_field]
        
        indonesian_stopwords = stopwords.words("indonesian")
        tf_idf_vectorizer = TfidfVectorizer(stop_words = indonesian_stopwords)
        vector_components = tf_idf_vectorizer.fit_transform(descriptions)
        sample_description_vector_component = tf_idf_vectorizer.transform([sample_description])
        index_to_word_mapping = tf_idf_vectorizer.get_feature_names()
        
        return vector_components, sample_description_vector_component, index_to_word_mapping
    
    def _recommend_travelling_places_using_knn(data_df, sample_description):
        description_vector_components, sample_description_vector_component, index_to_word_mapping = get_descriptions(sample_description)

        nearest_neighbors = NearestNeighbors(n_neighbors = 10)
        nearest_neighbors.fit(description_vector_components)
        k_nearest_neighbors_scores = nearest_neighbors.kneighbors(sample_description_vector_component)
        
        return k_nearest_neighbors_scores

    def _get_top_n_recommendations_based_on_similarity_scores(df, top_n_indexes):
        top_n_df = df.iloc[top_n_indexes]
        return top_n_df

    def get(self, request):
        data = request.data
        travelling_place_id = data["tourism_place_id"]
        descriptions = self._get_descriptions()
        nearest_neighbors = NearestNeighbors(n_neighbors = 2)
        travelling_place nearest_neighbors.fit()
        # travelling_place_name = TravellingPlaces().objects.qu
        pass

class NewsKeywordExtractionAPI(APIView):
    def get(self, request):
        data = request.data
        pass

class TourismAPI(APIView):
    def get(self, request):
        data = request.data
        search_query = data["search_query"]
        results = TravellingPlaces.objects.all()
        NearestNeigh

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