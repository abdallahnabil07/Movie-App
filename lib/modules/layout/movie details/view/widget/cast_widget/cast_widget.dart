import 'package:flutter/cupertino.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/theme/app_colors.dart';

import '../../../../../../core/gen/assets.gen.dart';
import '../../../model/movie_details_model.dart';

class CastWidget extends StatelessWidget {
  final CastModel cast;

  const CastWidget({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.wd(11),
        vertical: context.hg(11),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.charcoalGray,
      ),
      child: Row(
        spacing: context.wd(10),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              cast.images,
              height: context.hg(70),
              width: context.wd(70),
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  Assets.images.unknownPersonBlue.path,
                  height: context.hg(70),
                  width: context.wd(70),
                  fit: BoxFit.fill,
                );
              },
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: context.hg(11),
              children: [
                Text(
                  'Name : ${cast.name.isEmpty ? "Unknown" : cast.name}',
                  style: context.textTheme.titleLarge!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  'Character : ${cast.character.isEmpty ? "Unknown" : cast.character}',
                  style: context.textTheme.titleLarge!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
