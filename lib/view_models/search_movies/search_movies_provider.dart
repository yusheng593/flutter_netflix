import 'dart:developer';

import 'package:flutter_netflix/models/movie_model.dart';
import 'package:flutter_netflix/repository/movies_repository.dart';
import 'package:flutter_netflix/services/init_getit.dart';
import 'package:flutter_netflix/services/navigation_service.dart';
import 'package:flutter_netflix/view_models/search_movies/search_movies_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchMoviesProvider =
    StateNotifierProvider<SearchMoviesProvider, SearchMoviesState>(
        (_) => SearchMoviesProvider());

class SearchMoviesProvider extends StateNotifier<SearchMoviesState> {
  SearchMoviesProvider() : super(SearchMoviesState());

  final MoviesRepository _moviesRepository = getIt<MoviesRepository>();

  Future<void> searchMovies(String title) async {
    if (state.isLoading) {
      return;
    }

    if (title.isEmpty) {
      return;
    }

    // 檢查是否需要重置搜尋
    bool isNewSearch = title != state.lastSearchQuery;

    if (isNewSearch) {
      // 新的搜尋，重置列表和頁數
      state = state.copyWith(
        currentPage: 1,
        moviesList: [],
        lastSearchQuery: title,
        isSearching: true,
      );
    }

    state = state.copyWith(isLoading: true, isSearching: true);

    try {
      List<MovieModel> resultMovies = await _moviesRepository.searchMovie(
          title: title, page: state.currentPage);
      state = state.copyWith(
        moviesList: [...state.moviesList, ...resultMovies],
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

  void clearResults() {
    state = state.copyWith(
        currentPage: 1,
        moviesList: [],
        lastSearchQuery: '',
        isLoading: false,
        isSearching: false);
  }
}
