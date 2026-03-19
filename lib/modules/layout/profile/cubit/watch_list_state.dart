import 'package:bloc/bloc.dart';
import 'package:movie_app/modules/layout/home/model/home_movie_model.dart';

import '../../profile/utils/profile_firebase_service.dart';

class WatchListCubit extends Cubit<List<MovieModel>> {
  WatchListCubit() : super([]) {
    loadWatchList();
  }

  void loadWatchList() async {
    try {
      final data = await ProfileFirebaseService.getWatchList();
      final list = data.map((e) => MovieModel.fromFirestore(e)).toList();
      emit(list);
    } catch (e) {
      emit([]);
    }
  }

  void clearWatchList() {
    emit([]);
  }

  void addMovie(MovieModel movie) async {
    if (state.any((m) => m.id == movie.id)) return;

    final newList = List<MovieModel>.from(state)..add(movie);
    emit(newList);

    await ProfileFirebaseService.updateWatchList(
      newList.map((m) => m.toJson()).toList(),
    );
  }

  void removeMovie(MovieModel movie) async {
    final newList = List<MovieModel>.from(state)
      ..removeWhere((m) => m.id == movie.id);
    emit(newList);
    await ProfileFirebaseService.updateWatchList(
      newList.map((m) => m.toJson()).toList(),
    );
  }
}
