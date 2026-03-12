import 'package:flutter/cupertino.dart';
import 'package:movie_app/core/theme/app_colors.dart';

import '../../../../../../core/extensions/context_extensions.dart';

class GenresWidget extends StatelessWidget {
  final String genres;

  const GenresWidget({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.charcoalGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          genres,
          style: context.textTheme.titleLarge!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
