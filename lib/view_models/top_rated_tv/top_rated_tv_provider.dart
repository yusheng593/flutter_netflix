import 'dart:developer';

import 'package:flutter_netflix/models/tv_model.dart';
import 'package:flutter_netflix/repository/movies_repository.dart';
import 'package:flutter_netflix/services/init_getit.dart';
import 'package:flutter_netflix/services/navigation_service.dart';
import 'package:flutter_netflix/view_models/top_rated_tv/top_rated_tv_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final topRatedTvProvider =
    StateNotifierProvider<TopRatedTvProvider, TopRatedTvState>(
        (_) => TopRatedTvProvider());

class TopRatedTvProvider extends StateNotifier<TopRatedTvState> {
  TopRatedTvProvider() : super(TopRatedTvState());

  final MoviesRepository _moviesRepository = getIt<MoviesRepository>();

  Future<void> getTopRatedTv() async {
    if (state.isLoading) {
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      List<TvModel> popularTv =
          await _moviesRepository.fetchTopRatedTv(page: state.currentPage);
      state = state.copyWith(
        tvList: [...state.tvList, ...popularTv],
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
