import 'package:flutter/cupertino.dart';
import 'package:travelling_app/classes/user/bookmarked_travelling_place.dart';
import 'package:travelling_app/fetch-helpers/data-fetcher.dart';

class RecommendationColabWidget extends StatefulWidget{

  final List<BookmarkedTravellingPlace> bookmarkedTravellingPlaces;

  const RecommendationColabWidget({
    Key? key,
    required this.bookmarkedTravellingPlaces,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecommendationState();

}

class _RecommendationState extends State<RecommendationColabWidget>{

  Widget _getTitle(){
    return const Text(
      "Rekomendasi berdasarkan rating Anda.",
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }

  Widget _getRecommendationsContent(){
    return FutureBuilder(
      future: DataFetcher.getColabTravellingPlaces(
        widget.bookmarkedTravellingPlaces,
      ),
      builder: (context, snapshot) {
        print("Printing data...");
        return Column(

        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getTitle(),
        _getRecommendationsContent()
      ],
    );
  }
}