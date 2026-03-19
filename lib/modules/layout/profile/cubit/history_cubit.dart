import 'package:bloc/bloc.dart';
import 'package:movie_app/modules/layout/home/model/movie_model.dart';
import '../utils/profile_firebase_service.dart';

class HistoryCubit extends Cubit<List<MovieModel>> {
  HistoryCubit() : super([]) {
    loadHistory();
  }

  void loadHistory() async {
    try {
      final data = await ProfileFirebaseService.getHistory();
      final list = data.map((e) => MovieModel.fromFirestore(e)).toList();
      emit(list);
    } catch (e) {
      emit([]);
    }
  }

  void clearHistory() {
    emit([]);
  }

  void addToHistory(MovieModel movie) async {
    final newList = List<MovieModel>.from(state)
      ..removeWhere((m) => m.id == movie.id);
    
    newList.insert(0, movie);
    
    emit(newList);

    await ProfileFirebaseService.updateHistory(
      newList.map((m) => m.toJson()).toList(),
    );
  }
}
