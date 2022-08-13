import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travelling_app/globals/asset.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/globals/gradient.dart';
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

  Widget getImageLogo(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 100
          ),
          child: Image(
            image: Image.asset(
              assets["app_logo"] as String,
            ).image,
            height: 220,
          ),
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
      child: Image.asset(
        assets["splash_screen_background"] as String,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    moveToSearchPage(5, context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Color(colors["dark_green"] as int),
        ),
        child: Scaffold(
          body: renderLogo(context),
        )
    );
  }
  Widget renderLogo(BuildContext context){
    return Center(
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          getSplashBackground(context: context),
          getImageLogo(),
        ],
      ),
    );
  }
}