import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastificationCustom {
  // الدالة الثابتة
  static void show(
    BuildContext context, {
    required ToastificationType type,
    required String title,
    Duration autoCloseDuration = const Duration(seconds: 5),
    Alignment alignment = Alignment.bottomCenter,
  }) {
    Toastification().show(
      context: context,
      title: Text(title),
      type: type,
      alignment: alignment,
      autoCloseDuration: autoCloseDuration,
    );
  }
}
