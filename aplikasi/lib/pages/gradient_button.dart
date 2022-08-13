import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../globals/colors.dart';

class GradientButton extends StatelessWidget{
  final Gradient gradient;
  final BorderRadius borderRadius;
  final Widget buttonContent;
  final Function onButtonTap;
  final EdgeInsets padding;
  final BoxShadow shadow;

  const GradientButton({Key? key,
    required this.gradient,
    required this.borderRadius,
    required this.buttonContent,
    required this.onButtonTap,
    required this.padding,
    required this.shadow
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onButtonTap();
      },
      borderRadius: borderRadius,
      hoverColor: Color(secondaryColors["translucent_white"] as int),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: borderRadius,
          boxShadow: [shadow],
        ),
        padding: padding,
        child: buttonContent,
      ),
    );
  }
}