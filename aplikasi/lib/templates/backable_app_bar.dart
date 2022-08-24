import 'package:flutter/material.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/templates/app_bar_stylized.dart';

class BackableAppBar{
  final String appBarTitle;
  Function onBackIconPressed;
  final double rightMargin;

  BackableAppBar({
    required this.appBarTitle,
    required this.onBackIconPressed,
    required this.rightMargin,
  });

  Widget getBackIcon(){
    return Container(
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(colors["dark_orange"] as int),
      ),
      child: TextButton(
        onPressed: (){
          onBackIconPressed();
        },
        style: ButtonStyle(),
        child: const Icon(
          Icons.arrow_back,
          size: 32,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget getVerticalDivider(){
    return const SizedBox(
      width: 10,
      height: 10,
    );
  }

  Widget getTitle(){
    return Text(
        appBarTitle,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 18
        )
    );
  }

  AppBar getInstance(BuildContext context) {
    return AppBarStylized(
        widgets: [
          getBackIcon(),
          getVerticalDivider(),
          getTitle()
        ],
        rightMargin: rightMargin,
    ).getInstance();
  }
}