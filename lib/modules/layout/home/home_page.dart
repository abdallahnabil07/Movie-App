import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_app/core/extensions/context_extensions.dart';
import 'package:movie_app/components/movie_slider_card.dart';
import 'package:movie_app/components/movie_section.dart';
import 'package:movie_app/modules/layout/home/cubit/home_cubit.dart';
import 'package:shimmer_flutter/shimmer_flutter.dart';
import '../../../core/gen/assets.gen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentMovieIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..fetchMovies(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                if (state is HomeLoaded && state.latestMovies.isNotEmpty)
                  Container(
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: state.latestMovies[_currentMovieIndex].image,
                      fit: BoxFit.contain,
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.4, 0.7,0.1],
                      colors: [
                        Colors.transparent,
                        Colors.black87,
                        Colors.black,
                        Colors.black,
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Assets.images.availableNow.image(),
                      _buildLatestMovies(context, state),
                      Assets.images.watchNow.image(),
                      _buildTopRatedMovies(context, state),
                      _buildActionMovies(context, state),
                      _buildComedyMovies(context, state),
                      _buildAnimationMovies(context, state),
                      _buildHorrorMovies(context, state),



                    ],
                  ),
                ),
              ]
            ),
          );
        },
      ),
    );
  }

  Widget _buildLatestMovies(BuildContext context, HomeState state) {
    if (state is HomeLoading) {
      return Container(
        height: context.hg(350),
        child: Center(
          child: Shimmer(
            width: context.wd(200),
            height: context.hg(300),
            baseColor: Colors.grey,
          ),
        ),
      );
    }

    if (state is HomeError) {
      return Container(
        height: context.hg(350),
        child: Center(
          child: Text(
            'Error loading movies: ${state.error}',
            style: Theme.of(context).textTheme.bodyMedium,
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
          viewportFraction: 0.6,
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

    return Container(
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
    if (state is HomeLoading) {
      return Container(
        height: context.hg(250),
        padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: context.wd(100),
              height: context.hg(24),
              child: Shimmer(
                baseColor: Colors.grey,
              ),
            ),
            SizedBox(height: context.hg(12)),
            Row(
              children: List.generate(3, (index) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: index < 2 ? context.wd(8) : 0),
                  child: Shimmer(
                    width: double.infinity,
                    height: context.hg(180),
                    baseColor: Colors.grey,
                  ),
                ),
              )),
            ),
          ],
        ),
      );
    }
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
    if (state is HomeLoading) {
      return Container(
        height: context.hg(250),
        padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: context.wd(80),
              height: context.hg(24),
              child: Shimmer(
                baseColor: Colors.grey,
              ),
            ),
            SizedBox(height: context.hg(12)),
            Row(
              children: List.generate(3, (index) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: index < 2 ? context.wd(8) : 0),
                  child: Shimmer(
                    width: double.infinity,
                    height: context.hg(180),
                    baseColor: Colors.grey,
                  ),
                ),
              )),
            ),
          ],
        ),
      );
    }
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
    if (state is HomeLoading) {
      return Container(
        height: context.hg(250),
        padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: context.wd(70),
              height: context.hg(24),
              child: Shimmer(
                baseColor: Colors.grey,
              ),
            ),
            SizedBox(height: context.hg(12)),
            Row(
              children: List.generate(3, (index) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: index < 2 ? context.wd(8) : 0),
                  child: Shimmer(
                    width: double.infinity,
                    height: context.hg(180),
                    baseColor: Colors.grey,
                  ),
                ),
              )),
            ),
          ],
        ),
      );
    }
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
    if (state is HomeLoading) {
      return Container(
        height: context.hg(250),
        padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: context.wd(90),
              height: context.hg(24),
              child: Shimmer(
                baseColor: Colors.grey,
              ),
            ),
            SizedBox(height: context.hg(12)),
            Row(
              children: List.generate(3, (index) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: index < 2 ? context.wd(8) : 0),
                  child: Shimmer(
                    width: double.infinity,
                    height: context.hg(180),
                    baseColor: Colors.grey,
                  ),
                ),
              )),
            ),
          ],
        ),
      );
    }
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
    if (state is HomeLoading) {
      return Container(
        height: context.hg(250),
        padding: EdgeInsets.symmetric(horizontal: context.wd(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: context.wd(60),
              height: context.hg(24),
              child: Shimmer(
                baseColor: Colors.grey,
              ),
            ),
            SizedBox(height: context.hg(12)),
            Row(
              children: List.generate(3, (index) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: index < 2 ? context.wd(8) : 0),
                  child: Shimmer(
                    width: double.infinity,
                    height: context.hg(180),
                    baseColor: Colors.grey,
                  ),
                ),
              )),
            ),
          ],
        ),
      );
    }
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
