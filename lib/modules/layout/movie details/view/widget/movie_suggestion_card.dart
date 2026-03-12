import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../home/model/movie_model.dart';

class MovieSuggestionCard extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback onTap;

  const MovieSuggestionCard({
    super.key,
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.wd(16)),
          image: DecorationImage(
            image: CachedNetworkImageProvider(movie.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.wd(16)),
          ),
          padding: EdgeInsets.all(context.wd(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.wd(48),
                height: context.hg(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.wd(8)),
                  color: Colors.black38,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: context.wd(2),
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      movie.rating.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: AppColors.yellow,
                      size: context.wd(12),
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  movie.title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
