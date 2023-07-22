import 'package:cinema_app/domain/entities/movie.dart';

abstract class LocalStorageDatasource {
  Future<void> toggleFavorite(Movie movie);

  Future<bool> isMovieFavorite(int movideId);

  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
