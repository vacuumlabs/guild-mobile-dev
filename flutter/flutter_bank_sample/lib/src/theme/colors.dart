import 'package:flutter/material.dart';

class CustomColors {
  static const MaterialColor hotPink = MaterialColor(
    _hotPinkPrimaryValue,
    <int, Color>{
      50: Color(0xFFf390bb),
      100: Color(0xFFf179ad),
      200: Color(0xFFee639f),
      300: Color(0xFFec4d91),
      400: Color(0xFFe93684),
      500: Color(_hotPinkPrimaryValue),
      600: Color(0xFFd01d6a),
      700: Color(0xFFb91a5e),
      800: Color(0xFFa21653),
      900: Color(0xFF8b1347),
    },
  );
  static const int _hotPinkPrimaryValue = 0xFFE72076;

  static const Color buttonLabelColor = Color(0xFFFFFFFF);

  static const Color secondaryColor = Color(0xFFDEDEDE);
  static const Color secondaryColorDark = Color(0xFF222222);
}
