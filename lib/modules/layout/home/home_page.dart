import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/components/shimmer_movie_card.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/modules/layout/home/cubit/home_cubit.dart';
import 'package:movie_app/modules/layout/home/widget/movie_section.dart';
import 'package:movie_app/modules/layout/home/widget/movie_slider_card.dart';

import '../../../core/gen/assets.gen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit homeCubit;
  int _currentMovieIndex = 0;

  @override
  void initState() {
    super.initState();
    homeCubit = HomeCubit();
    homeCubit.fetchMovies();
  }

  @override
  void dispose() {
    homeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homeCubit,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                if (state is HomeLoaded && state.latestMovies.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: state.latestMovies[_currentMovieIndex].image,
                      fit: BoxFit.contain,
                      errorWidget: (context, url, error) =>
                          Container(color: Colors.grey[900]),
                    ),
                  ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.4, 0.7, 1],
                      colors: [
                        Colors.transparent,
                        Colors.black87,
                        Colors.black,
                        Colors.black,
                      ],
                    ),
                  ),
                ),
                ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Assets.images.availableNow.image(),
                    _buildLatestMovies(context, state),
                    Assets.images.watchNow.image(),
                    _buildTopRatedMovies(context, state),
                    _buildActionMovies(context, state),
                    _buildComedyMovies(context, state),
                    _buildAnimationMovies(context, state),
                    _buildHorrorMovies(context, state),
                    SizedBox(height: context.hg(75)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLatestMovies(BuildContext context, HomeState state) {
    if (state is HomeLoading) {
      return SizedBox(
        height: context.hg(380),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
          itemCount: 3,
          separatorBuilder: (_, _) => SizedBox(width: context.wd(12)),
          itemBuilder: (context, index) => ShimmerMovieCard(isTopMovie: true),
        ),
      );
    }

    if (state is HomeError) {
      return SizedBox(
        height: context.hg(350),
        child: Center(
          child: Text(
            'Error loading movies: ${state.error}',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.lightGreyColor,
              fontSize: context.hg(20),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (state is HomeLoaded) {
      return CarouselSlider(
        options: CarouselOptions(
          height: context.hg(350),
          enlargeCenterPage: true,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          viewportFraction: 0.55,
          onPageChanged: (index, reason) {
            setState(() {
              _currentMovieIndex = index % state.latestMovies.length;
            });
          },
        ),
        items: state.latestMovies.map((movie) {
          return MovieSliderCard(movie: movie);
        }).toList(),
      );
    }

    return SizedBox(
      height: context.hg(350),
      child: Center(
        child: Text(
          'No movies available',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildTopRatedMovies(BuildContext context, HomeState state) {
    if (state is HomeLoading) return ShimmerMovieCard(isSectionShimmer: true);
    if (state is HomeLoaded) {
      return MovieSection(
        title: 'Top Rated',
        movies: state.topRatedMovies,
        showCarousel: true,
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildActionMovies(BuildContext context, HomeState state) {
    if (state is HomeLoading) return ShimmerMovieCard(isSectionShimmer: true);
    if (state is HomeLoaded) {
      return MovieSection(
        title: 'Action',
        movies: state.actionMovies,
        showCarousel: true,
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildComedyMovies(BuildContext context, HomeState state) {
    if (state is HomeLoading) return ShimmerMovieCard(isSectionShimmer: true);
    if (state is HomeLoaded) {
      return MovieSection(
        title: 'Comedy',
        movies: state.comedyMovies,
        showCarousel: true,
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildAnimationMovies(BuildContext context, HomeState state) {
    if (state is HomeLoading) return ShimmerMovieCard(isSectionShimmer: true);
    if (state is HomeLoaded) {
      return MovieSection(
        title: 'Animation',
        movies: state.animationMovies,
        showCarousel: true,
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildHorrorMovies(BuildContext context, HomeState state) {
    if (state is HomeLoading) return ShimmerMovieCard(isSectionShimmer: true);
    if (state is HomeLoaded) {
      return MovieSection(
        title: 'Horror',
        movies: state.horrorMovies,
        showCarousel: true,
      );
    }
    return SizedBox.shrink();
  }
}
