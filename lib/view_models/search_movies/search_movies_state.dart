import 'package:flutter_netflix/common/utils.dart';
import 'package:flutter_netflix/models/movie_model.dart';

class SearchMoviesState implements MovieState {
  final int currentPage;

  @override
  final List<MovieModel> moviesList;

  final bool isLoading;

  final String fetchMoviesError;

  final String lastSearchQuery;

  final bool isSearching;

  SearchMoviesState({
    this.currentPage = 1,
    this.moviesList = const [],
    this.isLoading = false,
    this.fetchMoviesError = '',
    this.lastSearchQuery = '',
    this.isSearching = false,
  });

  SearchMoviesState copyWith({
    int? currentPage,
    List<MovieModel>? moviesList,
    bool? isLoading,
    String? fetchMoviesError,
    String? lastSearchQuery,
    bool? isSearching,
  }) {
    return SearchMoviesState(
      currentPage: currentPage ?? this.currentPage,
      moviesList: moviesList ?? this.moviesList,
      isLoading: isLoading ?? this.isLoading,
      fetchMoviesError: fetchMoviesError ?? this.fetchMoviesError,
      lastSearchQuery: lastSearchQuery ?? this.lastSearchQuery,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}
