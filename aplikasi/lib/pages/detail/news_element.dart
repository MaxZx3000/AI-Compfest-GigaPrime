import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/classes/news.dart';
import 'package:travelling_app/fetch-helpers/data-fetcher.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/globals/route.dart';
import 'package:travelling_app/templates/circular_loading_element.dart';
import 'package:travelling_app/templates/image_horizontal_item_view.dart';
import 'package:travelling_app/utils/context.dart';

class NewsElement extends StatefulWidget{

  const NewsElement({
    Key? key,
    required this.query,
  }) : super(key: key);

  final String query;

  @override
  State<StatefulWidget> createState() => _NewsElementState();

}

class _NewsElementState extends State<NewsElement>{

  Widget _getNewsHeaders(List<News> news){
    // double childAspectRatio = 0;
    // if (ContextUtils.getScreenWidth(context) > 500){
    //   childAspectRatio = 2.8;
    // }
    // else{
    //   childAspectRatio = 2.8;
    // }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 600,
        mainAxisExtent: 140,
      ),
      shrinkWrap: true,
      primary: false,
      scrollDirection: Axis.vertical,
      itemCount: news.length,
      itemBuilder: (BuildContext ctx, index){
        return Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
            top: 5,
            bottom: 5,
          ),
          child: ImageHorizontalItemView(
            urlImage:  news[index].thumbnailImage,
            titleText: news[index].title,
            subtitleText: news[index].siteName,
            onCardClick: (){
              Navigator.pushNamed(
                context,
                newsRouteName,
                arguments: news[index]
              );
            },
            additionalWidgets: const SizedBox(
              height: 0,
            ),
            height: 130,
          ),
        );
      },
    );
  }

  Widget _getCircularProgressLoading(){
    return const CircularLoadingElement(
      message: "Sedang memuat...",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Berita Terkait dengan ${widget.query}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: DataFetcher.getNewsList(widget.query),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done){
                return _getCircularProgressLoading();
              }
              else if (snapshot.hasData){
                return _getNewsHeaders(snapshot.data as List<News>);
              }
              return const Text(
                "Unknown Error Occured!"
              );
            },
          ),
        ],
      ),
    );
  }
}