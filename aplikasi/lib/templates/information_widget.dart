import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/globals/gradient.dart';

class InformationWidget extends StatelessWidget{
  final IconData iconData;
  final String information;
  final double widgetWidth;

  const InformationWidget({
    Key? key,
    required this.iconData,
    required this.information,
    required this.widgetWidth}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widgetWidth,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: CustomGradient.getLightBlueToDarkGreen(
                beginAlignment: Alignment.bottomCenter,
                endAlignment: Alignment.topCenter,
              ),
            ),
            child: Icon(
              iconData,
              size: 70,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            information,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}