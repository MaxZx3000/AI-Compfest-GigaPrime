from django.db import models

# Create your models here.
class TravellingPlaces(models.Model):
    place_id = models.IntegerField(primary_key = True)
    place_name = models.CharField(max_length = 9000)
    description = models.CharField(max_length = 9000)
    category = models.CharField(max_length = 9000)
    city = models.CharField(max_length = 9000)
    price = models.IntegerField(null = True)
    rating = models.FloatField(null = True)
    time_minutes = models.IntegerField(null = True, blank = True, default = None)
    coordinate = models.JSONField(null = True, default = None)
    summarized_description = models.JSONField(null = True, default = None)

class TravellingPlacesRating(models.Model):
    rating_id = models.AutoField(primary_key = True)
    user_id = models.IntegerField()
    place_id = models.CharField(max_length = 100)
    place_rating = models.FloatField()
