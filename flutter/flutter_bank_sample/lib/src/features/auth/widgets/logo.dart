import 'package:flutter/material.dart';
import 'package:flutter_bank_sample/src/extensions/build_context.dart';
import 'package:flutter_bank_sample/src/extensions/widget.dart';
import 'package:flutter_bank_sample/src/theme/styling.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Image.asset(
        context.isDarkMode() ? "assets/image/vacuumlabs_logo_horizontal_inverse_rgb.png" : "assets/image/vacuumlabs_logo_horizontal_rgb.png",
        width: 200,
      ).setPaddings(const EdgeInsets.all(Insets.extraLarge)),
    );
  }
}
