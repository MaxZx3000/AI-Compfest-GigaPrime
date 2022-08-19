import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import 'package:travelling_app/globals/colors.dart';

class CircularLoadingElement extends StatelessWidget{
  const CircularLoadingElement({Key? key,
    required this.message
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: Color(colors["dark_green"] as int),
              width: 2,
            ),
          ),
          height: 80,
          width: 80,
          child: GradientProgressIndicator(
            gradientColors: [
              Color(colors["dark_green"] as int),
              Color(colors["light_blue"] as int)
            ],
            gradientStops: const [0, 0.8],
            strokeWidth: 8,
            duration: 1,
            radius: 30,
            child: Column(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(message),
      ],
    );
  }
}
