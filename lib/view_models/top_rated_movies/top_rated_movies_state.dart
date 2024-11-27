import 'package:flutter_netflix/models/movie_model.dart';
import 'package:flutter_netflix/widgets/movies_card_list.dart';

class TopRatedMoviesState implements MovieState {
  final int currentPage;

  @override
  final List<MovieModel> moviesList;

  final bool isLoading;

  final String fetchMoviesError;

  TopRatedMoviesState({
    this.currentPage = 1,
    this.moviesList = const [],
    this.isLoading = false,
    this.fetchMoviesError = '',
  });

  TopRatedMoviesState copyWith({
    int? currentPage,
    List<MovieModel>? moviesList,
    bool? isLoading,
    String? fetchMoviesError,
  }) {
    return TopRatedMoviesState(
      currentPage: currentPage ?? this.currentPage,
      moviesList: moviesList ?? this.moviesList,
      isLoading: isLoading ?? this.isLoading,
      fetchMoviesError: fetchMoviesError ?? this.fetchMoviesError,
    );
  }
}
