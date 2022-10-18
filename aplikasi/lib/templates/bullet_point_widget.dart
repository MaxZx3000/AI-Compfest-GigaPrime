import 'package:flutter/cupertino.dart';

class BulletPointWidget extends StatelessWidget{

  final double spaceWidth;
  final String bulletType;
  final String text;
  final TextAlign textAlign;

  const BulletPointWidget({
    Key? key,
    this.bulletType = "•",
    this.textAlign = TextAlign.justify,
    required this.text,
    required this.spaceWidth,
    // required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Align(
          alignment: Alignment.topCenter,
          child: Text(
            "•",
          ),
        ),
        SizedBox(
          width: spaceWidth,
        ),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(
              height: 1.4
            ),
            textAlign: textAlign,
          ),
        ),
      ],
    );
  }
}