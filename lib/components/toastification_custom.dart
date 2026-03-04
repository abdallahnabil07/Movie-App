import 'package:flutter/material.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:toastification/toastification.dart';

class ToastificationCustom {
  // الدالة الثابتة
  static void show(
    BuildContext context, {
    required ToastificationType type,
    required String title,
    Duration autoCloseDuration = const Duration(seconds: 5),
    Alignment alignment = Alignment.topCenter,
  }) {
    Toastification().show(
      backgroundColor: AppColors.yellow,
      borderSide: BorderSide(color: AppColors.transparentColor),
      context: context,
      title: Text(
        textAlign: TextAlign.center,
        title,
        style: context.textTheme.bodyMedium!.copyWith(
          color: AppColors.primaryColor,
        ),
      ),
      type: type,
      alignment: alignment,
      autoCloseDuration: autoCloseDuration,
    );
  }
}
