abstract class TabBarState {}

class TabBarInitial extends TabBarState {}

class TabBarLoading extends TabBarState {}

class TabBarLoaded extends TabBarState {
  final List<String> genres;
  final List<dynamic> movies;
  final int? initialIndex;

  TabBarLoaded(this.genres, this.movies, {this.initialIndex});
}

class TabBarError extends TabBarState {
  final String message;

  TabBarError(this.message);
}
