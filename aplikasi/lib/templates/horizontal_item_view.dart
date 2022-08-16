import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/globals/colors.dart';

class HorizontalItemWidget extends StatelessWidget{
  final String titleText;
  final String subtitleText;
  final String rating;
  final double width;

  const HorizontalItemWidget({
    Key? key,
    required this.titleText,
    required this.subtitleText,
    required this.rating,
    this.width = double.infinity,
  }) : super(key: key);

   Widget getSummaryWidget(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: Text(
            titleText,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: Text(
            subtitleText,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: Row(
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
          ),
        )
      ],
    );
  }

  Widget getCardWidget(Widget childWidget){
    return Container(
      width: width,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0)
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.black12,
            spreadRadius: 0,
            blurRadius: 5
          )
        ]
      ),
      child: childWidget
    );
  }

  @override
  Widget build(BuildContext context) {
    return getCardWidget(
      getSummaryWidget()
    );
  }
}