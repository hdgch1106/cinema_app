import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_providers.dart';

final moviesLoadingProvider = Provider<void>((ref) {
  try {
    ref.read(nowPlayingMoviesProviders.notifier).loadNextPage();
    ref.read(popularMoviesProviders.notifier).loadNextPage();
    ref.read(topRatedMoviesProviders.notifier).loadNextPage();
    ref.read(upcomingMoviesProviders.notifier).loadNextPage();
  } catch (e) {
    print(e.toString());
  }
});
