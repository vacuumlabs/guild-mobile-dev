import 'package:flutter/material.dart';
import 'package:flutter_bank_sample/src/theme/colors.dart';

class Themes {
  static ThemeData getDark(BuildContext context) => ThemeData.dark().copyWith(
        // This is the theme of your application.
        primaryColor: CustomColors.hotPink,
        colorScheme: const ColorScheme.dark(
          primary: CustomColors.hotPink,
          secondary: CustomColors.secondaryColorDark,
        ),
        scaffoldBackgroundColor: const Color(0xFF20323F),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          floatingLabelStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: CustomColors.hotPink,
              ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
          backgroundColor: CustomColors.hotPink,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        )),
      );

  static ThemeData getLight(BuildContext context) => ThemeData.light().copyWith(
        // This is the theme of your application.
        primaryColor: CustomColors.hotPink,
        colorScheme: const ColorScheme.dark(
          primary: CustomColors.hotPink,
          onPrimary: Colors.black,
          secondary: CustomColors.secondaryColor,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          floatingLabelStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: CustomColors.hotPink,
              ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
          backgroundColor: CustomColors.hotPink,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        )),
      );
}
