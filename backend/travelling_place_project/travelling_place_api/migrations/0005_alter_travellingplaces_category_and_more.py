# Generated by Django 4.0.6 on 2022-08-23 03:38

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('travelling_place_api', '0004_alter_travellingplaces_city_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='travellingplaces',
            name='category',
            field=models.CharField(max_length=10000),
        ),
        migrations.AlterField(
            model_name='travellingplaces',
            name='city',
            field=models.CharField(max_length=10000),
        ),
        migrations.AlterField(
            model_name='travellingplaces',
            name='description',
            field=models.CharField(max_length=10000),
        ),
        migrations.AlterField(
            model_name='travellingplaces',
            name='place_name',
            field=models.CharField(max_length=10000),
        ),
    ]
