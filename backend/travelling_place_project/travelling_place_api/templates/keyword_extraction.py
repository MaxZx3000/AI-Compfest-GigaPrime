import numpy as np
from ..templates.pretty_print import PrettyPrint
from sklearn.feature_extraction.text import CountVectorizer

class KeywordExtraction:
    def _get_top_words_from_range_of_topics(self, model, feature_names, n_top_words = 8):
        top_features_per_document = []
        for topic_idx, topic in enumerate(model.components_):
            top_features_ind = topic.argsort()[: -n_top_words - 1 : -1]
            top_features = [feature_names[i] for i in top_features_ind]
            top_features_per_document.append(top_features)

        return top_features_per_document

    def _get_most_relevant_topic_from_sentences(self, model, x):
        topics_relevance_scores = model.transform(x)
        highest_relevant_topic_index = np.argmax(topics_relevance_scores)
        # print(topics_relevance_scores)
        # print(highest_relevant_topic_index)
        return highest_relevant_topic_index

    # def extract_keywords(self, sentences, stopwords = [], n_components = 10):
    #     tf_idf_vectorizer = TfidfVectorizer(stop_words = stopwords, norm = 'l1')
    #     x = tf_idf_vectorizer.fit_transform([sentences])
    #     feature_names = tf_idf_vectorizer.get_feature_names()

    #     nmf = NMF(
    #         n_components = n_components,
    #         max_iter = 600,
    #         random_state = 10,
    #         beta_loss = "kullback-leibler",
    #         solver = 'mu'
    #     )

    #     nmf.fit(x)
    #     top_topic_indexes = self._get_most_relevant_topic_from_sentences(nmf, x)
    #     top_words = self._get_top_words_from_range_of_topics(nmf, feature_names)
    #     return top_words[top_topic_indexes]

    def perform_keyword_extraction(self, ml_model, vectorizer_model, sample_text):
        x = vectorizer_model.transform(sample_text)
        feature_names = vectorizer_model.get_feature_names()
        ml_model.partial_fit(x)
        top_topic_index = self._get_most_relevant_topic_from_sentences(ml_model, x)
        top_words = self._get_top_words_from_range_of_topics(ml_model, feature_names)

        return top_words[top_topic_index]