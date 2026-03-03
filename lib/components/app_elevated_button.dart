import 'package:flutter/material.dart';

import '../core/extensions/context_extensions.dart';
import '../core/gen/assets.gen.dart';
import '../core/theme/app_colors.dart';

class AppElevatedButton extends StatelessWidget {
  final double height;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final String textButton;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final bool? addIcon;
  final SvgGenImage? icon;
  final double? heightIcon;
  final double? widthIcon;
  final double? paddingHorizontalForIcon;
  final double? paddingVerticalForIcon;

  const AppElevatedButton({
    super.key,
    required this.textButton,
    this.backgroundColor = AppColors.yellow,
    required this.onPressed,
    this.textColor = AppColors.primaryColor,
    this.borderColor,
    required this.height,
    this.width = double.infinity,
    this.icon,
    this.addIcon,
    this.heightIcon,
    this.widthIcon,
    this.paddingHorizontalForIcon,
    this.paddingVerticalForIcon,
    required this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 1,
            ),
          ),
        ),
        onPressed: onPressed,

        child: (addIcon == true && icon != null)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: paddingHorizontalForIcon!,
                        vertical: paddingVerticalForIcon!,
                      ),
                      child: icon!.svg(
                        width: widthIcon ?? 24,
                        height: heightIcon ?? 24,
                      ),
                    ),
                  Text(
                    textButton,
                    style: context.textTheme.titleLarge!.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w400,
                      fontSize: fontSize,
                    ),
                  ),
                ],
              )
            : Text(
                textAlign: TextAlign.center,
                textButton,
                style: context.textTheme.titleLarge!.copyWith(
                  color: textColor,
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                ),
              ),
      ),
    );
  }
}
