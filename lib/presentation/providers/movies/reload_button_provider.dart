import 'package:cinema_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reloadButtonProvider =
    StateNotifierProvider<ReloadButtonNotifier, bool>((ref) {
  final moviesLoading = ref.read(nowPlayingMoviesProviders.notifier);
  return ReloadButtonNotifier(moviesLoading: moviesLoading);
});

typedef LoadingCallback = Future<bool>;

class ReloadButtonNotifier extends StateNotifier<bool> {
  final MoviesNotifier moviesLoading;
  ReloadButtonNotifier({required this.moviesLoading}) : super(false);

  void updateReloadButton() {
    state = !moviesLoading.loadNextPageSuccess;
  }
}
