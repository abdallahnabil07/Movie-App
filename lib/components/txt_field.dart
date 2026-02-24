import 'package:flutter/material.dart';

import '../core/extensions/context_extensions.dart';
import '../core/theme/app_colors.dart';

class TxtField extends StatelessWidget {
  final double? width;
  final double? height;
  final double paddingHorizontal;
  final double paddingVertical;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onChanged;
  final String hintText;
  final int? maxLine;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  const TxtField({
    super.key,
    required this.hintText,
    this.controller,
    this.maxLine = 1,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.width,
    this.height,
    this.onChanged,
    this.textInputType = TextInputType.text,
    required this.paddingHorizontal,
    required this.paddingVertical,
    this.textStyle,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = Colors.transparent;
    final focusedBorderColor = AppColors.white;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: paddingVertical,
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: TextFormField(
          onChanged: onChanged,
          validator: validator,
          maxLines: maxLine,
          controller: controller,
          keyboardType: textInputType,
          style: textStyle ?? context.textTheme.titleMedium!.copyWith(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.charcoalGray,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: hintStyle?? context.textTheme.titleMedium!.copyWith(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: focusedBorderColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.redColor, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
