import os
import statsmodels.api as sm

class TimeSeries():
    def load_model(self, model_name):
        model_path = os.path.join(os.path.dirname(__file__), f"../ml_models/time_series/{model_name}.pickle")
        arima_model_result = sm.load(model_path)
        return arima_model_result

    def get_forecast(self, 
                    arima_model_result, 
                    n_samples):

        columns = ["date", "value"]

        prediction_result_df = arima_model_result.get_forecast(n_samples)
        prediction_result_df = prediction_result_df.predicted_mean
        prediction_result_df = prediction_result_df.reset_index()
        
        prediction_result_df.columns = columns
        
        prediction_result_df["date"] = prediction_result_df["date"].astype(str)

        return prediction_result_df
