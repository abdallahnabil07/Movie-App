import 'package:flutter/material.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/theme/app_colors.dart';

class CharacterSelected extends StatelessWidget {
  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  const CharacterSelected({
    super.key,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(context.wd(7)),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.yellow : AppColors.transparentColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.yellow, width: 2),
          ),
          child: Image.asset(
            image,
            height: context.hg(150),
            width: context.wd(150),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}