import 'package:flutter/cupertino.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/globals/gradient.dart';

class SingleTextWidget extends StatelessWidget{

  final String text;
  final double marginValue;

  const SingleTextWidget({
    Key? key,
    required this.text,
    required this.marginValue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(
        right: marginValue
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(colors["dark_green"] as int),
          width: 3
        ),
        borderRadius: const BorderRadius.all(
          Radius.elliptical(
            100, 100
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}