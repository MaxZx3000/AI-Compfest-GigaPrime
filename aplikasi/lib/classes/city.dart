enum CityKey {
 JAKARTA,
}

class City{
  String name;
  String logoURL;
  CityKey cityKey;

  City({
    required this.name,
    required this.logoURL,
    required this.cityKey
  });
}