# Generated by Django 4.0.6 on 2022-08-10 08:59

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='TravellingPlaces',
            fields=[
                ('place_id', models.IntegerField(primary_key=True, serialize=False)),
                ('place_name', models.CharField(max_length=100)),
                ('description', models.CharField(max_length=100)),
                ('category', models.CharField(max_length=20)),
                ('city', models.CharField(max_length=100)),
                ('price', models.IntegerField()),
                ('rating', models.FloatField()),
                ('time_minutes', models.IntegerField(blank=True, default=None, null=True)),
                ('coordinate', models.JSONField(default=None, null=True)),
                ('summarized_description', models.JSONField(default=None, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='TravellingPlacesRating',
            fields=[
                ('rating_id', models.AutoField(primary_key=True, serialize=False)),
                ('user_id', models.IntegerField()),
                ('place_id', models.CharField(max_length=100)),
                ('place_rating', models.FloatField()),
            ],
        ),
    ]
