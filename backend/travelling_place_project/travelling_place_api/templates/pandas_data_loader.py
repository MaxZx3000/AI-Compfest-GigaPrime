import pandas as pd
import os

class PandasDataLoader():
    def load_travelling_places_dataset(self):
        travelling_place_df_path = os.path.join(os.path.dirname(__file__), "../scripts/datasets/tourism_summarized.csv")
        travelling_place_df = pd.read_csv(travelling_place_df_path, delimiter = ';', decimal = ',')

        return travelling_place_df

    def load_travelling_places_rating_dataset(self):
        travelling_place_rating_df_path = os.path.join(os.path.dirname(__file__), "../scripts/datasets/tourism_rating.csv")
        travelling_place_rating_df = pd.read_csv(travelling_place_rating_df_path, delimiter = ',')
        travelling_place_rating_df.columns = ["user", "item", "rating"]
        return travelling_place_rating_df