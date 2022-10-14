import 'package:flutter/material.dart';
import 'package:travelling_app/globals/gradient.dart';
import 'package:travelling_app/templates/gradient_button.dart';
import 'package:travelling_app/utils/context.dart';

class SearchBar extends StatefulWidget{
  final String placeholderText;
  final Function onSearchClick;
  final double maxWidth;
  final BoxShadow searchBarShadow;
  final Alignment alignment;
  final double offsetValue;

  const SearchBar({Key? key,
    this.placeholderText = "",
    required this.onSearchClick,
    required this.maxWidth,
    required this.searchBarShadow,
    required this.alignment,
    required this.offsetValue
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar>{
  String currentText = "";

  void setCurrentText(String newText){
    setState(() {
      currentText = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getTextInput(),
        getSearchButton()
      ],
    );
  }

  Widget getTextInput(){
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              topLeft: Radius.circular(30.0)
          ),
          boxShadow: [widget.searchBarShadow]
      ),
      child: TextField(
        onChanged: (String text){
          setCurrentText(text);
        },
        maxLines: 1,
        decoration: InputDecoration(
          hintText: widget.placeholderText,
          constraints: BoxConstraints.expand(
            width: widget.maxWidth,
            height: 45,
          ),
          contentPadding: const EdgeInsets.only(left: 15.0),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget getSearchButton(){
    return GradientButton(
        gradient: CustomGradient.getOrangeToDarkOrange(),
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(30.0),
            topRight: Radius.circular(30.0)
        ),
        buttonContent: const Icon(
          Icons.search,
          size: 20,
        ),
        onButtonTap: (){
          widget.onSearchClick(currentText);
        },
        padding: const EdgeInsets.only(
            left: 22.5,
            right: 22.5,
            top: 11,
            bottom: 11
        ),
        shadow: widget.searchBarShadow,
    );
  }

}