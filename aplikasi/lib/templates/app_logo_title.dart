import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelling_app/globals/colors.dart';

class AppLogoTitle extends StatelessWidget{
  const AppLogoTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "TrAIvel",
      style: GoogleFonts.commissioner(
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: Color(colors["dark_green"] as int)
      ),
    );
  }

}