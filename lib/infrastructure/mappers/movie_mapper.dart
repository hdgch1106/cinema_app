import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB movieDb) => Movie(
      adult: movieDb.adult,
      backdropPath: movieDb.backdropPath != ""
          ? "https://image.tmdb.org/t/p/w500${movieDb.backdropPath}"
          : "https://t4.ftcdn.net/jpg/02/51/95/53/360_F_251955356_FAQH0U1y1TZw3ZcdPGybwUkH90a3VAhb.jpg",
      genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
      id: movieDb.id,
      originalLanguage: movieDb.originalLanguage,
      originalTitle: movieDb.originalTitle,
      overview: movieDb.overview,
      popularity: movieDb.popularity,
      posterPath: movieDb.posterPath != ""
          ? "https://image.tmdb.org/t/p/w500${movieDb.posterPath}"
          : "no-poster",
      releaseDate: movieDb.releaseDate,
      title: movieDb.title,
      video: movieDb.video,
      voteAverage: movieDb.voteAverage,
      voteCount: movieDb.voteCount);
}
