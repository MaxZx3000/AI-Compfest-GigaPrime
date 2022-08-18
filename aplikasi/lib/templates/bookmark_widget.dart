import 'package:flutter/material.dart';

class BookmarkWidget extends StatefulWidget{

  bool isActivated;
  final Function onBookmarkPressed;
  
  BookmarkWidget({
    Key? key,
    this.isActivated = false,
    required this.onBookmarkPressed,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookmarkState();
}

class _BookmarkState extends State<BookmarkWidget>{
  void changeState(){
    setState(() {
      if (widget.isActivated){
        widget.isActivated = false;
        return;
      }
      widget.isActivated = true;
    });
  }
  Widget initializeBookmarkIcon(){
    IconData iconData;
    if (widget.isActivated){
      iconData = Icons.star;
    }
    else{
      iconData = Icons.star_border;
    }
    return Icon(
      iconData,
      color: Colors.white,
      size: 20,
    );
  }
  @override
  Widget build(BuildContext context) {
    changeState();
    return FloatingActionButton.extended(
      onPressed: (){
        changeState();
        widget.onBookmarkPressed(widget.isActivated);
      },
      label: const Text(
        "Sukai",
      ),
      icon: initializeBookmarkIcon(),
    );
  }
}