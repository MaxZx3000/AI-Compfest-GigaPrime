import 'package:flutter/material.dart';

import '../globals/colors.dart';

class BookmarkWidget extends StatefulWidget{

  bool isActivated;
  final int numberOfStars;
  int score;

  final Function onBookmarkPressed;
  
  BookmarkWidget({
    Key? key,
    this.isActivated = false,
    required this.score,
    required this.onBookmarkPressed,
    this.numberOfStars = 5,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookmarkState();
}

class _BookmarkState extends State<BookmarkWidget>{
  void changeState(int score){
    setState(() {
      widget.score = score;
    });
  }

  Widget _getInactiveStarIcon(int score){
    return TextButton(
      onPressed: () async{
        await widget.onBookmarkPressed(score + 1);
        changeState(score + 1);
      },
      child: Icon(
        Icons.star_border,
        color: Color(colors["yellow"] as int),
        size: 25,
      ),
    );
  }

  Widget _getActiveStarIcon(int score){
    return TextButton(
      onPressed: () async{
        await widget.onBookmarkPressed(score + 1);
        changeState(score + 1);
      },
      child: Icon(
        Icons.star,
        color: Color(colors["yellow"] as int),
        size: 25,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> starWidgets = [];
    for (int i = 0; i < widget.numberOfStars; i++){
      if (i < widget.score){
        starWidgets.add(_getActiveStarIcon(i));
      }
      else{
        starWidgets.add(_getInactiveStarIcon(i));
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: starWidgets,
    );
  }
}