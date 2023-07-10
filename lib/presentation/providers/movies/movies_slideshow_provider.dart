import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/presentation/providers/movies/movies_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProviders);
  if (nowPlayingMovies.isEmpty) return [];
  return nowPlayingMovies.sublist(0, 6);
});
