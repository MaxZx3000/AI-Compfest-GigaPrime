class TravellingPlace{
  int placeId;
  String placeName;
  String description;
  String category;
  String city;
  double? price;
  double? rating;
  int? timeMinutes;
  Map<String, double>? coordinate;
  String? summarizedDescription;

  TravellingPlace({
    required this.placeId,
    required this.placeName,
    required this.description,
    required this.category,
    required this.city,
    this.price,
    this.rating,
    this.coordinate,
    this.timeMinutes,
    this.summarizedDescription
  });

  factory TravellingPlace.setFromJSON(Map<String, dynamic> json){
    return TravellingPlace(
      placeId: json["place_id"],
      placeName: json["place_name"],
      description: json["description"],
      category: json["category"],
      city: json["city"],
      price: json["price"],
      coordinate: json["coordinate"],
      timeMinutes: json["time_minutes"],
      summarizedDescription: json["summarized_description"]
    );
  }
}