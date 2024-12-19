import 'dart:developer';

import 'package:flutter_netflix/models/movie_model.dart';
import 'package:flutter_netflix/repository/movies_repository.dart';
import 'package:flutter_netflix/services/init_getit.dart';
import 'package:flutter_netflix/services/navigation_service.dart';
import 'package:flutter_netflix/view_models/upcomingMovies/upcoming_movies_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final upcomingMoviesProvider =
    StateNotifierProvider<UpcomingMoviesProvider, UpcomingMoviesState>(
        (_) => UpcomingMoviesProvider());

class UpcomingMoviesProvider extends StateNotifier<UpcomingMoviesState> {
  UpcomingMoviesProvider() : super(UpcomingMoviesState());

  final MoviesRepository _moviesRepository = getIt<MoviesRepository>();

  Future<void> getUpcomingMovies() async {
    if (state.isLoading) {
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      List<MovieModel> upcomingMovies =
          await _moviesRepository.fetchUpcomingMovies(page: state.currentPage);
      state = state.copyWith(
        moviesList: [...state.moviesList, ...upcomingMovies],
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
