import json
import os
import numpy as np
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

    def get_trend(self, prediction_result_df, order = 1):
        x = np.arange(prediction_result_df.shape[0])
        y = np.array(prediction_result_df["value"])

        z = np.polyfit(x, y, order)

        gradient = z[0] # Mendapatkan gradien/ kemiringan dari suatu garis time series.

        return gradient

    def get_trend_detail(self, trend, caption):
        if (trend < -400):
            return f"Tren pada {caption} turun drastis. Nilai kemiringan: ({trend})"
        elif (trend < -100):
            return f"Tren pada {caption} cenderung turun. Nilai kemiringan: ({trend})"
        elif (trend < -10):
            return f"Tren pada {caption} cenderung sedikit menurun. Nilai kemiringan: ({trend})"
        elif (trend > -10 and trend < 10):
            return f"Tren pada {caption} cenderung stabil. Nilai kemiringan: ({trend})"
        elif (trend > 10):
            return f"Tren pada {caption} cenderung sedikit naik. Nilai kemiringan: ({trend})"
        elif (trend > 100):
            return f"Tren pada {caption} cenderung naik. Nilai kemiringan: ({trend})"
        elif (trend > 400):
            return f"Tren pada {caption} cenderung naik drastis. Nilai kemiringan: ({trend})"

    def get_time_series_json_data(self, trend, caption, prediction_json):

        json_data = json.dumps({
            'trend': self.get_trend_detail(trend, caption),
            'result': prediction_json,
        })

        return str(json_data)