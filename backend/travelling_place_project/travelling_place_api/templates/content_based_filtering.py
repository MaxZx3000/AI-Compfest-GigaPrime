import pickle

class ContentBasedFiltering():
    def transform_to_vector(self, preprocessing_vector_model_name, data):
        vectorizer = pickle.load(open(preprocessing_vector_model_name, 'rb'))
        vector_components = vectorizer.transform(data)
        return vector_components

    def recommend_travelling_places_using_knn(self, all_vector_components, model_name):
        k_nearest_neighbors = pickle.load(open(model_name, 'rb'))
        k_nearest_neighbors_scores = k_nearest_neighbors.kneighbors(all_vector_components)
        
        return k_nearest_neighbors_scores

    def get_top_n_recommendations_based_on_similarity_scores(self, df, top_n_indexes):
        top_n_df = df.iloc[top_n_indexes]
        return top_n_df