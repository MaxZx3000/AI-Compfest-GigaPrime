import 'dart:convert';

class TravellingPlace{
  int placeId;
  String placeName;
  String description;
  String category;
  String city;
  int? price;
  double? rating;
  double? timeMinutes;
  double? latitude;
  double? longitude;
  String? summarizedDescription;

  TravellingPlace({
    required this.placeId,
    required this.placeName,
    required this.description,
    required this.category,
    required this.city,
    this.price,
    this.rating,
    this.latitude,
    this.longitude,
    this.timeMinutes,
    this.summarizedDescription
  });

  String getRating(){
    if (rating == null){
      return "Unknown";
    }
    else{
      return rating.toString();
    }
  }

  String getPrice(){
    if (price == null){
      return "Unknown";
    }
    else if (price == 0){
      return "Gratis";
    }
    else{
      return price.toString();
    }
  }

  factory TravellingPlace.setFromJSON(Map<String, dynamic> jsonDatum){
    String coordinate = jsonDatum["coordinate"];
    coordinate = coordinate.replaceAll("'", '"');
    Map<String, dynamic> coordinateJSON = jsonDecode(coordinate);

    return TravellingPlace(
      placeId: jsonDatum["place_id"],
      placeName: jsonDatum["place_name"],
      description: jsonDatum["description"],
      category: jsonDatum["category"],
      city: jsonDatum["city"],
      rating: jsonDatum["rating"],
      price: jsonDatum["price"],
      latitude: coordinateJSON['lat'],
      longitude: coordinateJSON['lng'],
      timeMinutes: jsonDatum["time_minutes"],
      summarizedDescription: jsonDatum["summarized_description"]
    );
  }
}