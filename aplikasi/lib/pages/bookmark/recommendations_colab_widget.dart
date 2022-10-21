import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/classes/travelling_place.dart';
import 'package:travelling_app/classes/user/bookmarked_travelling_place.dart';
import 'package:travelling_app/fetch-helpers/data-fetcher.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/globals/route.dart';
import 'package:travelling_app/templates/card_template.dart';
import 'package:travelling_app/templates/circular_loading_element.dart';
import 'package:travelling_app/templates/top_image_horizontal_item_view.dart';
import 'package:travelling_app/templates/information_widget.dart';
import 'package:travelling_app/templates/rating_widget.dart';

class RecommendationColabWidget extends StatefulWidget{

  final List<BookmarkedTravellingPlace> bookmarkedTravellingPlaces;
  final Function parentFunction;

  const RecommendationColabWidget({
    Key? key,
    required this.bookmarkedTravellingPlaces,
    required this.parentFunction,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecommendationState();

}

class _RecommendationState extends State<RecommendationColabWidget>{

  Widget _getLoadingWidget(){
    return const CircularLoadingElement(
      message: "Sedang memproses rekomendasi untuk Anda...",
    );
  }

  Widget _getRecommendationsWidget(List<TravellingPlace> recommendedTravellingPlaces){
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: recommendedTravellingPlaces.length,
          itemBuilder: (context, index) {
            TravellingPlace recommendedTravellingPlace = recommendedTravellingPlaces[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TopImageHorizontalItemWidget(
                imageURL: recommendedTravellingPlace.imageURL,
                titleText: recommendedTravellingPlace.placeName,
                subtitleText: recommendedTravellingPlace.city,
                width: 300,
                height: 200,
                additionalWidget: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RatingWidget(
                    rating: recommendedTravellingPlace.rating.toString(),
                  ),
                ),
                onClickCard: (){
                  Navigator.pushNamed(
                      context,
                      detailRouteName,
                      arguments: recommendedTravellingPlace
                  ).then((value) => {
                    widget.parentFunction()
                  });
                },
              ),
            );
          },
      ),
    );
  }

  Widget _getNotEnoughRatingCountWidget(){
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: InformationWidget(
        iconData: Icons.star,
        information: "Anda memerlukan minimal 6 rating untuk mendapatkan rekomendasi.",
        widgetWidth: 300,
      ),
    );
  }

  Widget _getRecommendationsContent(){
    if (widget.bookmarkedTravellingPlaces.length < 6){
      return _getNotEnoughRatingCountWidget();
    }
    return FutureBuilder(
      future: DataFetcher.getColabTravellingPlaces(
        widget.bookmarkedTravellingPlaces,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done){
          return _getLoadingWidget();
        }
        if (snapshot.hasError){
          print(snapshot.error);
          return const Text(
            "Unknown Error Occured!",
          );
        }
        List<TravellingPlace> recommendedTravellingPlaces = snapshot.data as List<TravellingPlace>;
        return _getRecommendationsWidget(
            recommendedTravellingPlaces,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CardTemplate(
      height: 310,
      title: "Rekomendasi berdasarkan rating Anda",
      contentWidget: _getRecommendationsContent(),
    );
  }
}