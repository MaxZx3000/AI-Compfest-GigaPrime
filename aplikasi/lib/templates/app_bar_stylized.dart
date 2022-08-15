import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/globals/colors.dart';
class AppBarStylized{
  final double rightMargin;
  final List<Widget> widgets;
  final double radius = 30.0;

  AppBarStylized({
    required this.rightMargin,
    required this.widgets
  });

  AppBar getInstance() {
    return AppBar(
      flexibleSpace: Container(
          margin: EdgeInsets.only(
            top: 40,
            bottom: 10,
            right: rightMargin,
          ),
          decoration: BoxDecoration(
              color: Color(colors["dark_green"] as int),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(radius),
                  bottomRight: Radius.circular(radius)
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0.0,
                  blurRadius: 10.0,
                  offset: Offset(0, 0.5),
                ),
              ]
          ),
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: widgets
          )
      ),
      toolbarHeight: 100,
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }
}