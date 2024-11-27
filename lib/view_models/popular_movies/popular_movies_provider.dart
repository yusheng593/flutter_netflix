import 'dart:developer';

import 'package:flutter_netflix/models/movie_model.dart';
import 'package:flutter_netflix/repository/movies_repository.dart';
import 'package:flutter_netflix/services/init_getit.dart';
import 'package:flutter_netflix/services/navigation_service.dart';
import 'package:flutter_netflix/view_models/popular_movies/popular_movies_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final popularMoviesProvider =
    StateNotifierProvider<PopularMoviesProvider, PopularMoviesState>(
        (_) => PopularMoviesProvider());

class PopularMoviesProvider extends StateNotifier<PopularMoviesState> {
  PopularMoviesProvider() : super(PopularMoviesState());

  final MoviesRepository _moviesRepository = getIt<MoviesRepository>();

  Future<void> getPopularMovies() async {
    if (state.isLoading) {
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      List<MovieModel> popularMovies =
          await _moviesRepository.fetchPopularMovies(page: state.currentPage);
      state = state.copyWith(
        moviesList: [...state.moviesList, ...popularMovies],
        currentPage: state.currentPage + 1,
        fetchMoviesError: '',
        isLoading: false,
      );
    } catch (error) {
      state = state.copyWith(
        fetchMoviesError: error.toString(),
        isLoading: false,
      );
      log('錯誤訊息: $error');
      getIt<NavigationService>().showSnackbar(error.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
