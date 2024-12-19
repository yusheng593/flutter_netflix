import 'package:flutter_netflix/models/movie_detail_model.dart';
import 'package:flutter_netflix/models/movie_model.dart';
import 'package:flutter_netflix/models/tv_detail_model.dart';
import 'package:flutter_netflix/models/tv_model.dart';
import 'package:flutter_netflix/services/api_service.dart';

class MoviesRepository {
  final ApiService _apiService;
  MoviesRepository(this._apiService);

  Future<List<MovieModel>> fetchPopularMovies({int page = 1}) async {
    return await _apiService.fetchPopularMovies(page: page);
  }

  Future<List<MovieModel>> fetchTopRatedMovies({int page = 1}) async {
    return await _apiService.fetchTopRatedMovies(page: page);
  }

  Future<List<TvModel>> fetchTopRatedTv({int page = 1}) async {
    return await _apiService.fetchTopRatedTv(page: page);
  }

  Future<List<MovieModel>> searchMovie(
      {required String title, int page = 1}) async {
    return await _apiService.searchMovie(title: title, page: page);
  }

  Future<List<MovieModel>> fetchNowPlayingMovies({int page = 1}) async {
    return await _apiService.fetchNowPlayingMovies(page: page);
  }

  Future<MovieDetailModel> fetchMoviedetails({required int movieId}) async {
    return await _apiService.fetchMovieDetails(movieId: movieId);
  }

  Future<TvDetailModel> fetchTvDetails({required int tvId}) async {
    return await _apiService.fetchTvDetails(tvId: tvId);
  }

  //fetchUpcomingMovies
  Future<List<MovieModel>> fetchUpcomingMovies({int page = 1}) async {
    return await _apiService.fetchUpcomingMovies(page: page);
  }
}
