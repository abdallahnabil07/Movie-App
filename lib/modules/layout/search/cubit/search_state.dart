import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/network/constants/api_constants.dart';
import 'package:movie_app/core/network/constants/end_points.dart';

part 'search_cubit.dart';

sealed class SearchState {}

class InitialState extends SearchState {}

class LoadingState extends SearchState {}

class SuccessState extends SearchState {
  final List movieList;

  SuccessState({required this.movieList});
}

class EmptyState extends SearchState {}

class ErrorState extends SearchState {
  final String errorMessage;

  ErrorState({required this.errorMessage});
}
