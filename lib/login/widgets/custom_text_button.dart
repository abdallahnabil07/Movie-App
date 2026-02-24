import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../../core/theme/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    required this.fontWeight,
    this.onTap,
  });

  final String text;
  final FontWeight fontWeight;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: fontWeight,
          fontSize: 14,
          color: AppColors.yellow,
        ),
      ),
    );
  }
}
