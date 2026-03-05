import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/model/movie_model.dart';


class MovieSliderCard extends StatelessWidget {
  final MovieModel movie;

  const MovieSliderCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: (){},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: context.wd(8)),
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
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black38,
              ],
            ),
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
