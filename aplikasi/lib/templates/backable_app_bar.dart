import 'package:flutter/material.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/templates/app_bar_stylized.dart';

class DetailAppBar{
  final String appBarTitle;

  DetailAppBar({
    required this.appBarTitle,
  });

  Widget getBackIcon(){
    return Container(
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(colors["dark_orange"] as int),
      ),
      child: const Icon(
        Icons.arrow_back,
        size: 32,
        color: Colors.white,
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
        rightMargin: 140,
    ).getInstance();
  }
}