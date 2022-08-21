from collections import defaultdict
import os
import pickle
from surprise import Dataset, Reader

class ColabBasedFiltering():
    def _get_filtered_testset_by_user_id(self, testset, user_id):
        testset_data = []
        for uid, item_id, rating in testset:
            if user_id == uid:
                testset_data.append((uid, item_id, rating))

        return testset_data

    def _load_model(self, file_name = "pickle.pkl"):
        pickled_model = pickle.load(open(file_name, 'rb'))
        return pickled_model

    def _get_top_n_from_specific_user_id(self, 
                                        predictions, 
                                        number_of_items,
                                        user_id,
                                        except_array=[]):
        top_n = defaultdict(list)

        for uid, iid, true_r, est, _ in predictions:
            if user_id == uid and iid not in except_array:
                top_n[uid].append((iid, est))

        for uid, user_ratings in top_n.items():
            user_ratings.sort(key=lambda x: x[1], reverse=True)
            top_n[uid] = user_ratings[:number_of_items]

        return top_n

    def _load_dataset_into_surprise(self, rating_data_df, rating_scale = (1, 5)):
        reader = Reader(rating_scale = rating_scale)
        rating_surprise_data = Dataset.load_from_df(rating_data_df, reader = reader)
        full_trainset = rating_surprise_data.build_full_trainset()
        full_anti_testset = full_trainset.build_anti_testset()
        full_testset = full_trainset.build_testset()
        return full_trainset, full_anti_testset, full_testset
            
    def perform_actual_collaborative_filtering(self, 
                                            rating_data_df,
                                            test_user_id = 200001,
                                            user_id_field = "user_id",
                                            rating_scale = (1, 5)):

        train_full_trainset, train_full_anti_testset, train_full_testset = self._load_dataset_into_surprise(
            rating_data_df = rating_data_df,
            rating_scale = rating_scale
        )

        svdpp_path = os.path.join(os.path.dirname(__file__), "../ml_models/svdpp.pkl")

        model = self._load_model(svdpp_path)

        filtered_user_id_anti_testset = self._get_filtered_testset_by_user_id(
            train_full_anti_testset,
            test_user_id
        )

        predictions = model.test(filtered_user_id_anti_testset)

        top_n_predictions = self._get_top_n_from_specific_user_id(predictions,
                                                            number_of_items = 10,
                                                            user_id = test_user_id)

        return top_n_predictions

    def get_top_n_results_from_df(self, data_df, top_n_predictions, item_id_field):
        recommended_ids = []

        for i, recommended_item in enumerate(top_n_predictions):
            # Convert to integer, since place id is represented as string here.
            recommended_id = int(recommended_item[0])

            recommended_ids.append(recommended_id)

        recommended_items_df = data_df[data_df[item_id_field].isin(recommended_ids)]
        return recommended_items_df