import 'package:flutter/material.dart';
import 'package:movie_app/modules/layout/movie%20details/model/movie_details_model.dart';

class MovieScreenshots extends StatefulWidget {
  final MovieDetailsModel movieDetailsModel;

  const MovieScreenshots({super.key, required this.movieDetailsModel});

  @override
  State<MovieScreenshots> createState() => _MovieScreenshotsState();
}

class _MovieScreenshotsState extends State<MovieScreenshots> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
