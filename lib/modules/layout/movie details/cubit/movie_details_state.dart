import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/network/constants/api_constants.dart';
import 'package:movie_app/core/network/constants/end_points.dart';
import 'package:movie_app/modules/layout/movie%20details/model/movie_details_model.dart';

part 'movie_details_cubit.dart';

sealed class MovieDetailsState {}

class MovieDetailsInitialState extends MovieDetailsState {}

class MovieDetailsLoadingState extends MovieDetailsState {}

class MovieDetailsSuccessState extends MovieDetailsState {
  final MovieDetailsModel movie;

  MovieDetailsSuccessState({required this.movie});
}

class MovieDetailsErrorState extends MovieDetailsState {
  final String errorMessage;

  MovieDetailsErrorState({required this.errorMessage});
}
