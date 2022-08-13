import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalItemWidget extends StatelessWidget{
  final String titleText;
  final String subtitleText;
  final double rating;

  const HorizontalItemWidget({
    Key? key,
    required this.titleText,
    required this.subtitleText,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(titleText),
        Text(subtitleText),
        Text(
          rating.toString(),
        ),
      ],
    );
  }

}