import pickle
import json
import os
from django.http import HttpResponse
from .templates.colab_based_filtering import ColabBasedFiltering
from .templates.pretty_print import PrettyPrint
from .templates.keyword_extraction import KeywordExtraction
from rest_framework import status
from rest_framework.views import APIView
from .models import TravellingPlaces, TravellingPlacesRating
from sklearn.neighbors import NearestNeighbors
from sklearn.feature_extraction.text import CountVectorizer, TfidfVectorizer
from nlp_id.tokenizer import Tokenizer
from nlp_id.lemmatizer import Lemmatizer
from nltk.corpus import stopwords
from nltk.tokenize import sent_tokenize
from .ml_models.text_rank import TextRank
from .templates.google_link_fetch import GoogleLinkFetch
from .templates.web_scrapper import WebScraper
import pandas as pd
from string import digits


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
        try:
            data = request.data
            query = data["title"]
            print(f"Query Result 1: {query}")
        except:
            query = request.GET.get('title', '')
            print(f"Query Result News 2: {query}")

        news_query = f"{query} Berita"
        NEWS_CX_KEY = "b513cee2778d74c33"

        google_link_fetch = GoogleLinkFetch()
        json_response = google_link_fetch.fetch_json_from_search_api(news_query, NEWS_CX_KEY)
        header_news_infos = google_link_fetch.get_header_info(json_response, LIMIT_LINK_NUMBER = 10)
        print("Header News Infos:")
        # print(header_news_infos)
        
        header_news_json = json.dumps({
            'info': header_news_infos
        })

        print(header_news_infos)

        return HttpResponse(header_news_json, content_type = "application/json", status = status.HTTP_200_OK)

class NewsFetchDetailsAPI(APIView):
    def _preprocess_text(self, sentences, word_length_threshold = 15):
        sentence_dot_tokenized = []
        for sentence in sentences:
            sentence_dot_tokenized += sent_tokenize(sentence)

        table_digits = str.maketrans('', '', digits)

        sentence_filtered_tokenized = [sentence for sentence in sentence_dot_tokenized if len(sentence) >= word_length_threshold]
        sentence_filtered_tokenized = [word.translate(table_digits) for word in sentence_filtered_tokenized]
        return sentence_filtered_tokenized
    
    def _get_summarized_news(self, relevant_paragraphs):
        text_rank = TextRank()
        summarized_paragraph_text = text_rank.summarize_text(relevant_paragraphs)
        return summarized_paragraph_text

    def _get_keywords(self, sentences):
        keywords_extraction = KeywordExtraction()
        lda_model_path = os.path.join(os.path.dirname(__file__), "ml_models/lda.pkl")
        count_vectorizer_lda_path = os.path.join(os.path.dirname(__file__), "ml_models/count_vectorizer_lda.pkl")
        
        lda = pickle.load(open(lda_model_path, 'rb'))
        count_vectorizer_lda = pickle.load(open(count_vectorizer_lda_path, 'rb'))
        # count_vectorizer = CountVectorizer()
        preprocessed_sentence = self._preprocess_text([sentences])
        pretty_printer = PrettyPrint()
        pretty_print_text = pretty_printer.pretty_print_tokenized_document(preprocessed_sentence)

        print(f"Preprocessed sentence: {pretty_print_text}")

        top_words = keywords_extraction.perform_keyword_extraction(lda, count_vectorizer_lda, [pretty_print_text])
        

        # indonesian_stopwords = set(stopwords.words("indonesian"))
        # indonesian_stopwords.union({
        #     "republika", "photo", "wib", "indonesia", "bandung", 
        #     "peserta", "co", "peserta", "baca", "kota", 
        #     "peristiwa", "rakyat", "jalan", "balai", 
        #     "januari", "februari", "maret", "april", "mei",
        #     "juni", "juli", "agustus", "september", "oktober", 
        #     "november", "desember", "berita", "dapat", "warga",
        #     "pulau", "kota"
        # })
    
        return top_words

    def _get_news_data(self, url_link):
        web_scraper = WebScraper()
        web_content = web_scraper.retrieve_content_from_scraper_api(url_link)
        relevant_paragraphs = web_scraper.get_relevant_paragraphs_only(web_content)
        return relevant_paragraphs

    def get(self, request):
        try:
            data = request.data
            url_link = data["url_link"]
        except:
            url_link = request.GET.get('url_link', '')       
        
        relevant_paragraphs = self._get_news_data(url_link)
        preprocessed_relevant_paragraphs = self._preprocess_text(relevant_paragraphs)
        summarized_news = self._get_summarized_news(preprocessed_relevant_paragraphs)
        pretty_print = PrettyPrint()
        
        pretty_printed_relevant_paragraphs = pretty_print.pretty_print_tokenized_document(relevant_paragraphs)
        pretty_printed_summarized_news = pretty_print.pretty_print_tokenized_document(summarized_news)
        top_words = self._get_keywords(pretty_printed_relevant_paragraphs)

        summarized_text_json = json.dumps({
            "summarized_text": pretty_printed_summarized_news,
            "top_words": top_words
        })
        
        return HttpResponse(summarized_text_json, content_type = "application/json", status = status.HTTP_200_OK)

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
        try:
            data = request.data
            query_result = data["query"]
            print(f"Query Result 1: {query_result}")
        except:
            query_result = request.GET.get('query', '')
            print(f"Query Result 2: {query_result}")
        
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

    def _load_rating_df(self, query_result):
        request_json_rating_query = json.loads(query_result)
        request_rating_df = pd.DataFrame(request_json_rating_query)
        print(request_rating_df)

        rating_queryset = TravellingPlacesRating.objects.all()
        rating_df = PreprocessingTemplate.convert_queryset_data_to_df(rating_queryset)
        rating_df = rating_df[["user_id", "place_id", "place_rating"]]
        rating_with_request_rating_df = pd.concat([rating_df, request_rating_df])
        rating_with_request_rating_df.reset_index(inplace = True)
        rating_with_request_rating_df.drop("index", axis = 1, inplace = True)
        rating_with_request_rating_df = rating_with_request_rating_df.rename(columns = {
            "user_id": "user", 
            "place_id": "item",
            "place_rating": "rating" 
        })

        print(rating_with_request_rating_df)
        return rating_with_request_rating_df

    def get(self, request):
        try:
            data = request.data
            query_result = data["data"]
            print(f"Query Result 1: {query_result}")
        except:
            query_result = request.GET.get('data', '')
            print(f"Query Result 2: {query_result}")

        rating_with_request_rating_df = self._load_rating_df(query_result)

        colab_based_filtering = ColabBasedFiltering()
        top_n_predictions = colab_based_filtering.perform_actual_collaborative_filtering(
            rating_with_request_rating_df,
        )

        travelling_places_queryset = TravellingPlaces.objects.all()

        travelling_places_df = PreprocessingTemplate.convert_queryset_data_to_df(travelling_places_queryset)

        top_n_predictions_df = colab_based_filtering.get_top_n_results_from_df(
            travelling_places_df, 
            top_n_predictions[200001], 
            "place_id",
        )

        top_n_predictions_json = top_n_predictions_df.to_json(orient = "records")
 
        return HttpResponse(top_n_predictions_json, content_type = "application/json", status = status.HTTP_200_OK)