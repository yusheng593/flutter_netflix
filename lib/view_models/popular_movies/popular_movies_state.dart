import 'package:flutter_netflix/models/movie_model.dart';
import 'package:flutter_netflix/widgets/movies_card_list.dart';

class PopularMoviesState implements MovieState {
  final int currentPage;

  @override
  final List<MovieModel> moviesList;

  final bool isLoading;

  final String fetchMoviesError;

  PopularMoviesState({
    this.currentPage = 1,
    this.moviesList = const [],
    this.isLoading = false,
    this.fetchMoviesError = '',
  });

  PopularMoviesState copyWith({
    int? currentPage,
    List<MovieModel>? moviesList,
    bool? isLoading,
    String? fetchMoviesError,
  }) {
    return PopularMoviesState(
      currentPage: currentPage ?? this.currentPage,
      moviesList: moviesList ?? this.moviesList,
      isLoading: isLoading ?? this.isLoading,
      fetchMoviesError: fetchMoviesError ?? this.fetchMoviesError,
    );
  }
}
