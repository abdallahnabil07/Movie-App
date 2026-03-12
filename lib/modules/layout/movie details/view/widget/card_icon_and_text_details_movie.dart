import 'package:flutter/material.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/gen/assets.gen.dart';
import 'package:movie_app/core/theme/app_colors.dart';

class CardIconAndTextDetailsMovie extends StatelessWidget {
  final SvgGenImage icon;
  final String text;

  const CardIconAndTextDetailsMovie({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.hg(47),
      decoration: BoxDecoration(
        color: AppColors.charcoalGray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.hg(11),
          horizontal: context.wd(12),
        ),
        child: Row(
          spacing: context.wd(14),
          children: [
            icon.svg(width: context.wd(28), height: context.hg(25)),
            Text(
              text,
              style: context.textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.white,
                fontSize: context.hg(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
