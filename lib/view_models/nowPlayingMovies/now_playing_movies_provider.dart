import 'dart:developer';

import 'package:flutter_netflix/models/movie_model.dart';
import 'package:flutter_netflix/repository/movies_repository.dart';
import 'package:flutter_netflix/services/init_getit.dart';
import 'package:flutter_netflix/services/navigation_service.dart';
import 'package:flutter_netflix/view_models/nowPlayingMovies/now_playing_movies_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<NowPlayingMoviesProvider, NowPlayingMoviesState>(
        (_) => NowPlayingMoviesProvider());

class NowPlayingMoviesProvider extends StateNotifier<NowPlayingMoviesState> {
  NowPlayingMoviesProvider() : super(NowPlayingMoviesState());

  final MoviesRepository _moviesRepository = getIt<MoviesRepository>();

  Future<void> getNowPlayingMovies() async {
    if (state.isLoading) {
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      List<MovieModel> nowPlayingMovies = await _moviesRepository
          .fetchNowPlayingMovies(page: state.currentPage);
      state = state.copyWith(
        moviesList: [...state.moviesList, ...nowPlayingMovies],
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
