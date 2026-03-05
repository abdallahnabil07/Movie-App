part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<MovieModel> latestMovies;
  final List<MovieModel> topRatedMovies;
  final List<MovieModel> actionMovies;
  final List<MovieModel> comedyMovies;
  final List<MovieModel> animationMovies;
  final List<MovieModel> horrorMovies;

  HomeLoaded({
    required this.latestMovies,
    required this.topRatedMovies,
    required this.actionMovies,
    required this.comedyMovies,
    required this.animationMovies,
    required this.horrorMovies,
  });
}

class HomeError extends HomeState {
  final String error;

  HomeError(this.error);
}
