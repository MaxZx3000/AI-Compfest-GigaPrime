import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:travelling_app/globals/gradient.dart';
import 'package:travelling_app/pages/gradient_button.dart';
import 'package:travelling_app/utils/context.dart';

class SearchBar extends StatefulWidget{
  final String placeholderText;
  final Function onSearchClick;
  final double maxWidth;
  final BoxShadow searchBarShadow;

  const SearchBar({Key? key,
    this.placeholderText = "",
    required this.onSearchClick,
    required this.maxWidth,
    required this.searchBarShadow
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchBarState(
      placeholderText: placeholderText,
      onSearchClick: onSearchClick,
      maxWidth: maxWidth,
      shadow: this.searchBarShadow
  );
}

class _SearchBarState extends State<SearchBar>{
  final String placeholderText;
  final Function onSearchClick;
  final double maxWidth;
  final BoxShadow shadow;
  String currentText = "";

  _SearchBarState({
    this.placeholderText = "",
    required this.onSearchClick,
    required this.maxWidth,
    required this.shadow
  });

  void setCurrentText(String newText){
    setState(() {
      currentText = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
          boxShadow: [shadow]
      ),
      child: TextField(
        onChanged: (String text){
          setCurrentText(text);
        },
        maxLines: 1,
        decoration: InputDecoration(
          hintText: placeholderText,
          constraints: BoxConstraints.expand(
            width: getSearchBarWidth() - 150,
            height: 46,
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
        buttonContent: const Icon(Icons.search),
        onButtonTap: onSearchClick(),
        padding: const EdgeInsets.only(
            left: 22.5,
            right: 22.5,
            top: 11,
            bottom: 11
        ),
        shadow: shadow
    );
  }

  double getSearchBarWidth(){
    double screenWidth = ContextUtils.getScreenWidth(context);
    if (screenWidth > maxWidth){
      return maxWidth;
    }
    return screenWidth;
  }
}