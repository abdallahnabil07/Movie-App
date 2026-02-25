import 'package:flutter/material.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/theme/app_colors.dart';

class BottomContainerCustom extends StatelessWidget {
  final String topText;
  final String? title;
  final int flex;
  final int indexForBottomContainer;

  const BottomContainerCustom({
    super.key,
    required this.topText,
    this.title,
    required this.flex,
    required this.indexForBottomContainer,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Transform.translate(
        offset: Offset(0, -context.hg(30)),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: context.hg(10)),
                child: Text(
                  textAlign: TextAlign.center,
                  topText,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontSize: context.hg(24),
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              if (title != null)
                Padding(
                  padding: EdgeInsets.only(
                    left: context.wd(16),
                    right: context.wd(16),
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    title!,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontSize: context.hg(18),
                      color: AppColors.white,
                      fontWeight: FontWeight.w400,
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
