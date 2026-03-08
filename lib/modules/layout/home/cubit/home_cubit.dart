import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/services/movie_service.dart';
import 'package:movie_app/modules/layout/home/model/movie_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> fetchMovies() async {
    emit(HomeLoading());
    try {
      final latestMovies = await MovieService.fetchMovies();
      final topRatedMovies = await MovieService.fetchMovies(sortBy: 'rating');
      final actionMovies = await MovieService.fetchMovies(genre: 'action');
      final comedyMovies = await MovieService.fetchMovies(genre: 'comedy');
      final animationMovies = await MovieService.fetchMovies(genre: 'animation');
      final horrorMovies = await MovieService.fetchMovies(genre: 'horror');
      
      emit(HomeLoaded(
        latestMovies: latestMovies,
        topRatedMovies: topRatedMovies,
        actionMovies: actionMovies,
        comedyMovies: comedyMovies,
        animationMovies: animationMovies,
        horrorMovies: horrorMovies,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
