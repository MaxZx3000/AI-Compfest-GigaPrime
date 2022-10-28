import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/globals/asset.dart';
import 'package:travelling_app/templates/app_bar_stylized.dart';
import 'package:travelling_app/templates/app_logo_title.dart';
import 'package:travelling_app/templates/backable_app_bar.dart';

class AboutPage extends StatelessWidget{

  const AboutPage({Key? key}) : super(key: key);

  Widget _getLogoWidget(){
    return Image.asset(
      assets["app_logo"] as String,
      height: 200,
      width: 200,
    );
  }

  Widget _getAboutWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: const [
          SizedBox(
            height: 20,
          ),
          Text(
            "Aplikasi ini bertujuan untuk mendapatkan informasi detail mengenai" +
              " tempat pariwisata di Indonesia menggunakan artificial intelligence." +
              " Tidak hanya itu, user juga bisa mendapatkan rekomendasi berdasarkan keyword, lokasi, harga tiket, " +
              " dan rating tempat pariwisata yang diberikan. Sebagai tambahan, terdapat fitur time series," +
              " yang bertujuan untuk mendapatkan insight terkait forecasting pada suatu kasus tourism",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Fitur yang terdapat pada aplikasi ini:",
            textAlign: TextAlign.center,
          ),
          Text(
            "1. Content Based Filtering",
          ),
          Text(
            "2. Colab Based Filtering",
          ),
          Text(
            "3. Text Summarization",
          ),
          Text(
            "4. Keyword Extraction",
          ),
          Text(
            "5. Time Series Forecasting",
          ),
        ],
      ),
    );
  }

  Widget _getBackground(){
    return Image.asset(
      assets["splash_screen_background"] as String,
      height: 300,
      fit: BoxFit.fill,
      width: double.infinity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: BackableAppBar(
        appBarTitle: "Tentang Aplikasi ini",
        onBackIconPressed: (){
          Navigator.pop(context);
        },
        rightMargin: 80,
      ).getInstance(context),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            _getLogoWidget(),
            const AppLogoTitle(),
            _getAboutWidget(),
            _getBackground(),
          ],
        ),
      ),
    );
  }

}