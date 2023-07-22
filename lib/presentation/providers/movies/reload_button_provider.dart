

/* final reloadButtonProvider =
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
 */