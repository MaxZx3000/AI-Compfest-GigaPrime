import 'package:travelling_app/classes/travelling_place.dart';

class News{
  String title;
  String link;
  String thumbnailImage;
  String type;
  String siteName;

  News({
    required this.title,
    required this.link,
    required this.thumbnailImage,
    required this.type,
    required this.siteName,
  });

  factory News.setFromJSON(dynamic jsonDatum){
    return News(
      link: jsonDatum["link"],
      title: jsonDatum["title"],
      thumbnailImage: jsonDatum["thumbnail_image"],
      type: jsonDatum["type"],
      siteName: jsonDatum["site_name"],
    );
  }
}