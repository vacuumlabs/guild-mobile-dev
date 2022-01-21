import 'package:flutter/material.dart';

extension Paddings on Widget {
  /// set paddings
  Padding setPaddings(EdgeInsetsGeometry paddings) {
    return Padding(
      padding: paddings,
      child: this,
    );
  }
}
