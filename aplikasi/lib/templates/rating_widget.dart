import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/globals/colors.dart';

class RatingWidget extends StatelessWidget{

  final String rating;

  const RatingWidget({
    super.key,
    required this.rating
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(colors["dark_orange"] as int)
              ),
              padding: const EdgeInsets.all(2.0),
              child: const Icon(
                Icons.star,
                color: Colors.yellow,
                size: 18,
              )
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            rating,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
        ]
    );
  }

}