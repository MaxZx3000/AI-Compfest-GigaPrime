import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/classes/news.dart';
import 'package:travelling_app/classes/news_detail.dart';
import 'package:travelling_app/fetch-helpers/data-fetcher.dart';
import 'package:travelling_app/templates/backable_app_bar.dart';
import 'package:travelling_app/templates/card_template.dart';
import 'package:travelling_app/templates/circular_loading_element.dart';
import 'package:travelling_app/templates/jumbotron_summary.dart';
import 'package:travelling_app/templates/single_text_widget.dart';
import 'package:travelling_app/utils/context.dart';

class NewsPage extends StatefulWidget{

  const NewsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewsPageState();

}

class _NewsPageState extends State<NewsPage>{

  late News news;

  Widget _getLargeImageWidget(){
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(20.0),
        bottomLeft: Radius.circular(20.0)
      ),
      child: Image.network(
        news.thumbnailImage,
        height: 250,
        cacheHeight: 250,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }

  Widget _getJumbotronWidget(){
    return Column(
      children: [
        SummaryWidget(
          title: news.title,
          subtitle: "${news.type}, ${news.siteName}",
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            "Full link: ${news.link}",
          ),
        )
      ],
    );
  }

  Widget _getKeywordsWidget(NewsDetail newsDetail){
    Widget keywordsWidget = ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: newsDetail.topWords.length,
      itemBuilder: (context, index) {
        return SingleTextWidget(
          text: newsDetail.topWords[index],
          marginValue: 10,
        );
      },
    );
    return CardTemplate(
      title: "Kata Kunci",
      contentWidget: keywordsWidget,
      height: 45
    );
  }

  Widget _getSummaryNewsWidget(NewsDetail newsDetail){
    return CardTemplate(
      title: "Rangkuman Berita",
      contentWidget: SingleChildScrollView(
        primary: false,
        child: Text(
          newsDetail.summarizedText,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            height: 1.4,
          ),
        ),
      ),
      height: 300,
    );
  }

  Widget _getCircularProgressLoading(){
    const String message = "Memproses Rangkuman dan Kata Kunci pada berita ini...";
    return const CircularLoadingElement(
      message: message,
    );
  }

  Widget _getFutureBuilderNewsWidget(){
    Widget _getNewsDetailWidget(NewsDetail newsDetail){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _getKeywordsWidget(newsDetail),
            const SizedBox(
              height: 10,
            ),
            _getSummaryNewsWidget(newsDetail),
          ],
        ),
      );
    }
    return FutureBuilder(
      future: DataFetcher.getNewsDetail(news),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done){
          return _getCircularProgressLoading();
        }
        else if (snapshot.hasData){
          return _getNewsDetailWidget(snapshot.data as NewsDetail);
        }
        return const Text(
          "Unknown Error Occured!",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    news = ContextUtils.getArguments(context) as News;
    return Scaffold(
      appBar: BackableAppBar(
        onBackIconPressed: (){
          Navigator.pop(context);
        },
        appBarTitle: "News Detail",
        rightMargin: 140
      ).getInstance(context),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            _getLargeImageWidget(),
            _getJumbotronWidget(),
            _getFutureBuilderNewsWidget(),
          ],
        )
      ),
    );
  }

}