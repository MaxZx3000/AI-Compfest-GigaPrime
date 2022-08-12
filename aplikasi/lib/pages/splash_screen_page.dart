import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelling_app/globals/asset.dart';
import 'package:travelling_app/globals/route.dart';
import 'package:travelling_app/utils/context.dart';

class SplashScreenPage extends StatelessWidget{
  const SplashScreenPage({Key? key}) : super(key: key);

  void moveToSearchPage(duration, context){
    Future.delayed(Duration(seconds: duration), (){
      Navigator.pushReplacementNamed(
        context,
        homeRouteName,
      );
    });
  }
  Widget getStrip({
    required double x,
    required double y,
    required BuildContext context}){
    return Positioned(
        left: x,
        top: y,
        child: Container(
          width: ContextUtils.getScreenWidth(context),
          height: 30,
          decoration: BoxDecoration(
            gradient: CustomGradient.getLightBlueToDarkGreen(),
          ),
        )
    );
  }

  Widget getImageLogo(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: Image.asset(
            assets["app_logo"] as String,
          ).image,
          height: 220,
        ),
        Text(
          "Sample Title",
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(),
        ),
      ],
    );
  }
  Widget getSplashBackground({
    required BuildContext context
  }){
    return Positioned(
      bottom: 0,
      width: ContextUtils.getScreenWidth(context),
      child: Image(
        image: Image.asset(
          assets["splash_screen_background"] as String,
        ).image,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    moveToSearchPage(5, context);
    return Scaffold(
      body: renderLogo(context),
    );
  }
  Widget renderLogo(BuildContext context){
    return Center(
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          getSplashBackground(context: context),
          getStrip(
              x: 0,
              y: 0,
              context: context
          ),
          getImageLogo(),
        ],
      ),
    );
  }
}