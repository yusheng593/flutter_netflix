import 'package:flutter_netflix/common/utils.dart';
import 'package:flutter_netflix/models/movie_model.dart';

class NowPlayingMoviesState implements MovieState {
  final int currentPage;

  @override
  final List<MovieModel> moviesList;

  final bool isLoading;

  final String fetchMoviesError;

  NowPlayingMoviesState({
    this.currentPage = 1,
    this.moviesList = const [],
    this.isLoading = false,
    this.fetchMoviesError = '',
  });

  NowPlayingMoviesState copyWith({
    int? currentPage,
    List<MovieModel>? moviesList,
    bool? isLoading,
    String? fetchMoviesError,
  }) {
    return NowPlayingMoviesState(
      currentPage: currentPage ?? this.currentPage,
      moviesList: moviesList ?? this.moviesList,
      isLoading: isLoading ?? this.isLoading,
      fetchMoviesError: fetchMoviesError ?? this.fetchMoviesError,
    );
  }
}
