import 'package:travelling_app/classes/news.dart';

class NewsDetail{
  final News news;
  final List<String> topWords;
  final String summarizedText;

  NewsDetail({
    required this.news,
    required this.topWords,
    required this.summarizedText
  });

  factory NewsDetail.setFromJSON(News news, dynamic jsonDatum){
    List<String> topWords = [];
    jsonDatum["top_words"].forEach((dynamic topWord){
      topWords.add(topWord);
    });

    return NewsDetail(
      news: news,
      topWords: topWords,
      summarizedText: jsonDatum["summarized_text"]
    );
  }
}