import 'package:flutter/material.dart';

class ImageSimpleItemView extends StatelessWidget{

  final String title;
  final String imageURL;
  final Function onCardClick;
  final double height;

  const ImageSimpleItemView({
    Key? key,
    required this.title,
    required this.imageURL,
    required this.onCardClick,
    required this.height,
  }) : super(key: key);

  Widget _getImageWidget(){
    return Image.network(
      imageURL,
      height: double.infinity,
      fit: BoxFit.fitHeight,
    );
  }

  Widget getSummaryWidget(){
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          maxLines: 3,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  Widget _getCombinedWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: _getImageWidget(),
        ),
        Expanded(
          flex: 2,
          child: getSummaryWidget(),
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