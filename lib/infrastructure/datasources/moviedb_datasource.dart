import 'package:cinema_app/config/constants/environment.dart';
import 'package:cinema_app/domain/datasources/movies_datasource.dart';
import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/infrastructure/mappers/movie_mapper.dart';
import 'package:cinema_app/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: "https://api.themoviedb.org/3",
    queryParameters: {
      "api_key": Environment.theMovieDBKey,
      "language": "es-MX"
    },
  ));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);
    final List<Movie> movies = movieDBResponse.results
        .where((movieDb) => movieDb.posterPath != "no-poster")
        .map((movieDb) => MovieMapper.movieDBToEntity(movieDb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get("/movie/now_playing", queryParameters: {"page": page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get("/movie/popular", queryParameters: {"page": page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getToprated({int page = 1}) async {
    final response =
        await dio.get("/movie/top_rated", queryParameters: {"page": page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response =
        await dio.get("/movie/upcoming", queryParameters: {"page": page});
    return _jsonToMovies(response.data);
  }
}