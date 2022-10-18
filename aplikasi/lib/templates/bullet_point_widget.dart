import 'package:flutter/cupertino.dart';

class BulletPointWidget extends StatelessWidget{

  final double spaceWidth;
  final String bulletType;
  final String text;

  const BulletPointWidget({
    Key? key,
    this.bulletType = "•",
    required this.text,
    required this.spaceWidth
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "•",
        ),
        SizedBox(
          width: spaceWidth,
        ),
        Flexible(
          child: Text(
            text,
          ),
        ),
      ],
    );
  }
}