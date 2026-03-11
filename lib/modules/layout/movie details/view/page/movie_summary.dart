import 'package:flutter/material.dart';
import 'package:movie_app/modules/layout/home/model/movie_model.dart';

class MovieSummary extends StatefulWidget {
  final MovieModel movieModel;

  const MovieSummary({super.key, required this.movieModel});

  @override
  State<MovieSummary> createState() => _MovieSummaryState();
}

class _MovieSummaryState extends State<MovieSummary> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
