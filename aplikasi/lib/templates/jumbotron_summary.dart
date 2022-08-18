import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SummaryWidget extends StatelessWidget{

  final String title;
  final String subtitle;

  const SummaryWidget({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.black45,
            ),
          )
        ],
      ),
    );
  }
}