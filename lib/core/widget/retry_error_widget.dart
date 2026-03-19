import 'package:flutter/material.dart';
import 'package:movie_app/components/app_elevated_button.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/theme/app_colors.dart';

class RetryErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onPressed;

  const RetryErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          errorMessage,
          style: context.textTheme.bodyMedium!.copyWith(
            color: AppColors.redColor,
            fontSize: context.hg(20),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(context.wd(16)),
          child: AppElevatedButton(
            onPressed: onPressed,
            textButton: 'Try again',
            height: context.hg(50),
            width: double.infinity,
            fontSize: context.hg(18),
          ),
        ),
      ],
    );
  }
}
