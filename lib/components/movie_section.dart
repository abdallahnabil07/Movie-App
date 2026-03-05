import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/components/movie_slider_card.dart';
import 'package:movie_app/model/movie_model.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final List<MovieModel> movies;
  final bool showCarousel;

  const MovieSection({
    super.key,
    required this.title,
    required this.movies,
    this.showCarousel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
              child: TextButton.icon(
                onPressed: () {
                  // TODO: Navigate to see more page
                },
                icon: Text(
                  'See More',
                  style: TextStyle(
                    color: AppColors.yellow,
                    fontSize: 14,
                  ),
                ),
                label: Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: AppColors.yellow,
                ),

              ),
            ),
          ],
        ),
        SizedBox(height: context.hg(16)),
        if (showCarousel)
          CarouselSlider(
            options: CarouselOptions(
              height: context.hg(200),
              enlargeCenterPage: false,
              autoPlay: false,
              enableInfiniteScroll: false,
              viewportFraction: 0.3,
              padEnds: false,
              scrollDirection: Axis.horizontal,
            ),
            items: movies.map((movie) {
              return MovieSliderCard(movie: movie);
            }).toList(),
          )
        else
          Container(
            height: context.hg(150),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(right: context.wd(16)),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Container(
                  width: context.wd(100),
                  margin: EdgeInsets.only(right: context.wd(12)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(context.wd(12)),
                    image: DecorationImage(
                      image: NetworkImage(movies[index].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        SizedBox(height: context.hg(24)),
      ],
    );
  }
}
