import os
import pandas as pd
from ..models import TravellingPlaces, TravellingPlacesRating
import numpy as np

travelling_places_csv = os.path.join(os.path.dirname(__file__), "datasets/tourism_summarized.csv")
travelling_places_rating_csv = os.path.join(os.path.dirname(__file__), "datasets/tourism_rating.csv") 

def seed_travelling_places():
    travelling_places_df = pd.read_csv(travelling_places_csv, delimiter = ';')

    travelling_places_df = travelling_places_df.replace(np.NaN, "N/A")
    
    print("Inserting rows... ")
    TravellingPlaces.objects.all().delete()

    print("Seeding travelling place data...")
    for index, series in travelling_places_df.iterrows():
        print(f"Current Index: {index}")
        place_id = series["Place_Id"]
        place_name = series["Place_Name"]
        description = series["Description"]
        category = series["Category"]
        city = series["City"]
        summarized_description = series["Summarized_Description"]

        time_minutes = None

        if series["Time_Minutes"] != "N/A":
            time_minutes = series["Time_Minutes"]

        price = None

        if series["Price"] != "N/A":
            price = series["Price"]

        rating = None

        if series["Rating"] != "N/A":
            rating = series["Rating"]

        coordinate = series["Coordinate"]

        travelling_place = TravellingPlaces(
            place_id, place_name,
            description, category, city, price,
            rating, time_minutes, coordinate,
            summarized_description
        )
        travelling_place.save()
        
def seed_travelling_places_rating():
    travelling_places_rating_df = pd.read_csv(travelling_places_rating_csv, delimiter = ',')
    
    TravellingPlacesRating.objects.all().delete()

    print("Seeding Travelling Places Rating...")
    index = 0
    for label, series in travelling_places_rating_df.iterrows():
        print(index)
        index += 1
        user_id = series["User_Id"]
        place_id = series["Place_Id"]
        place_rating = series["Place_Ratings"]

        travelling_place_rating = TravellingPlacesRating(
            user_id = user_id, 
            place_id = place_id,
            place_rating = place_rating
        )

        travelling_place_rating.save()

def run():
    seed_travelling_places()
    seed_travelling_places_rating()

    