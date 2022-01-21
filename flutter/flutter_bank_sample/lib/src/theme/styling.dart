/// Common insets to be used across our project.
class Insets {
  static const double xsmall = 4;
  static const double small = 8;
  static const double medium = 12;
  static const double large = 16;
  static const double extraLarge = 24;
}

/// Common radius values to be used across our project.
class Radius {
  static const double small = 8;
  static const double medium = 12;
  static const double large = 16;
}

/// Form factor thresholds when identifying device screen types.
class FormFactor {
  static double desktop = 900;
  static double tablet = 600;
  static double handset = 300;
}

/// Screen types of devices for adaptive UI.
enum ScreenType {
  desktop, tablet, phone, watch
}