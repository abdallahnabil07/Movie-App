import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;
  // responsive height
  double hg(double n) {
    final h = MediaQuery.of(this).size.height;
    return n * (h / 880);
  }

  // responsive width
  double wd(double n) {
    final w = MediaQuery.of(this).size.width;
    return n * (w / 390);
  }

  // // responsive font size using textScaler
  // double fs(double fontSize, {double baseWidth = 390}) {
  //   final w = MediaQuery.of(this).size.width;
  //   final scaler = MediaQuery.textScalerOf(this);
  //
  //   // 1. احسب الحجم المتناسب مع عرض الشاشة
  //   final responsiveSize = fontSize * (w / baseWidth);
  //
  //   return scaler.scale(responsiveSize);
  // }

  // textTheme shortcut
  TextTheme get textTheme => Theme.of(this).textTheme;
}