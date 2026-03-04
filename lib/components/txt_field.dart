import 'package:flutter/material.dart';

import '../core/extensions/context_extensions.dart';
import '../core/theme/app_colors.dart';

class TxtField extends StatefulWidget {
  final double? width;
  final double? height;
  final double paddingHorizontal;
  final double paddingVertical;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onChanged;
  final String? hintText;
  final int? maxLine;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final bool obscureText;

  const TxtField({
    super.key,
    this.hintText,
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
    this.obscureText = false,
  });

  @override
  State<TxtField> createState() => _TxtFieldState();
}

class _TxtFieldState extends State<TxtField> {
  late bool isObscure;

  @override
  void initState() {
    super.initState();
    isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = Colors.transparent;
    final focusedBorderColor = AppColors.white;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.paddingHorizontal,
        vertical: widget.paddingVertical,
      ),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: TextFormField(
          obscureText: isObscure,
          onChanged: widget.onChanged,
          validator: widget.validator,
          maxLines: widget.maxLine,
          controller: widget.controller,
          keyboardType: widget.textInputType,
          style:
              widget.textStyle ??
              context.textTheme.titleMedium!.copyWith(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.charcoalGray,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      isObscure ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                  )
                : widget.suffixIcon,

            hintText: widget.hintText,
            hintStyle:
                widget.hintStyle ??
                context.textTheme.titleMedium!.copyWith(
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
