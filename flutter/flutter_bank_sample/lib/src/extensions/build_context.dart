import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter_bank_sample/src/theme/styling.dart';

extension DarkMode on BuildContext {
  /// returns true if device is running in dark mode, false otherwise.
  bool isDarkMode() {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}

extension ScreenTypeExtension on BuildContext {
  /// Returns screen type based on size of our application area.
  ScreenType getFormFactor(BuildContext context) {
    // Use .shortestSide to detect device type regardless of orientation
    double deviceWidth = MediaQuery.of(context).size.shortestSide;
    if (deviceWidth > FormFactor.desktop) return ScreenType.desktop;
    if (deviceWidth > FormFactor.tablet) return ScreenType.tablet;
    if (deviceWidth > FormFactor.handset) return ScreenType.phone;
    return ScreenType.watch;
  }
}
