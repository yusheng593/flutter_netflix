import 'package:flutter_netflix/common/utils.dart';
import 'package:flutter_netflix/models/movie_model.dart';

class UpcomingMoviesState implements MovieState {
  final int currentPage;

  @override
  final List<MovieModel> moviesList;

  final bool isLoading;

  final String fetchMoviesError;

  UpcomingMoviesState({
    this.currentPage = 1,
    this.moviesList = const [],
    this.isLoading = false,
    this.fetchMoviesError = '',
  });

  UpcomingMoviesState copyWith({
    int? currentPage,
    List<MovieModel>? moviesList,
    bool? isLoading,
    String? fetchMoviesError,
  }) {
    return UpcomingMoviesState(
      currentPage: currentPage ?? this.currentPage,
      moviesList: moviesList ?? this.moviesList,
      isLoading: isLoading ?? this.isLoading,
      fetchMoviesError: fetchMoviesError ?? this.fetchMoviesError,
    );
  }
}
