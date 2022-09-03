import 'package:flutter/material.dart';

class ImageHorizontalItemView extends StatelessWidget{
  final String urlImage;
  final String titleText;
  final String subtitleText;
  final Widget additionalWidgets;
  final double height;
  final Function onCardClick;
  // final double width;

  const ImageHorizontalItemView({
    Key? key,
    required this.urlImage,
    required this.titleText,
    required this.subtitleText,
    required this.additionalWidgets,
    required this.height,
    required this.onCardClick,
    // required this.width,
  }) : super(key: key);

  Widget _getImageWidget(){
    return Image.network(
      urlImage,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget getSummaryWidget(){
    return Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: 10,
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            maxLines: 3,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            subtitleText,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _getCombinedWidget(){
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: _getImageWidget(),
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              getSummaryWidget(),
              additionalWidgets
            ]
          ),
        ),
      ],
    );
  }

  Widget getCardWidget(Widget childWidget){
    return Container(
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
    return SizedBox(
      height: height,
      child: getCardWidget(
        TextButton(
          onPressed: () {
            onCardClick();
          },
          style: TextButton.styleFrom(
              primary: Colors.black
          ),
          child: _getCombinedWidget()
        )
      ),
    );
  }
}