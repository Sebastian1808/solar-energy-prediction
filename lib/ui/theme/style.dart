import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 34,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle headline2 = TextStyle(
    fontSize: 30,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 17,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle bodyTextLarge = TextStyle(
    fontSize: 20,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );


  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.nunito(
        textStyle: headline1,
        color: Colors.black
    ),
    bodyLarge: GoogleFonts.nunito(
        textStyle: bodyText,
        color: Colors.black
    ),
  );

  static EdgeInsets paddingBody = const EdgeInsets.only(
      top: 5.0,
      right: 20.0,
      left: 20.0,
      bottom: 20.0
  );

}
