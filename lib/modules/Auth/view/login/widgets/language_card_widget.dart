import 'package:flutter/material.dart';
import 'package:movie_app/core/gen/assets.gen.dart';
import 'package:movie_app/core/theme/app_colors.dart';

class LanguageCardWidget extends StatelessWidget {
  const LanguageCardWidget({
    super.key,
    required this.isArabic,
    required this.onTap,
  });

  final bool isArabic;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 91,
        height: 39,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.yellow),
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWell(
          onTap: onTap,

          splashColor: Colors.transparent,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: !isArabic ? AppColors.yellow : Colors.transparent,
                  border: !isArabic
                      ? Border.all(color: AppColors.yellow, width: 5)
                      : null,
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(!isArabic ? 0 : 5),
                    child: Assets.icons.enIcon.svg(width: 27, height: 27),
                  ),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  color: isArabic ? AppColors.yellow : Colors.transparent,
                  border: isArabic
                      ? Border.all(color: AppColors.yellow, width: 5)
                      : null,
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(isArabic ? 0 : 5),
                    child: Assets.icons.arIcon.svg(width: 27, height: 27),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
