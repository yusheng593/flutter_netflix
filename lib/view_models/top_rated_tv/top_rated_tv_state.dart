import 'package:flutter_netflix/models/tv_model.dart';

class TopRatedTvState {
  final int currentPage;

  final List<TvModel> tvList;

  final bool isLoading;

  final String fetchMoviesError;

  TopRatedTvState({
    this.currentPage = 1,
    this.tvList = const [],
    this.isLoading = false,
    this.fetchMoviesError = '',
  });

  TopRatedTvState copyWith({
    int? currentPage,
    List<TvModel>? tvList,
    bool? isLoading,
    String? fetchMoviesError,
  }) {
    return TopRatedTvState(
      currentPage: currentPage ?? this.currentPage,
      tvList: tvList ?? this.tvList,
      isLoading: isLoading ?? this.isLoading,
      fetchMoviesError: fetchMoviesError ?? this.fetchMoviesError,
    );
  }
}
