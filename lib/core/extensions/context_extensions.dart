import 'dart:core';

import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  TextTheme get textTheme => Theme.of(this).textTheme;

  double hg(double n) => n * (height / 880);

  double wd(double n) => n * (width / 390);
}
