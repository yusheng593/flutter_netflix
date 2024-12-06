import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_netflix/common/utils.dart';
import 'package:flutter_netflix/view_models/nowPlayingMovies/now_playing_movies_provider.dart';
import 'package:flutter_netflix/view_models/search_movies/search_movies_provider.dart';
import 'package:flutter_netflix/widgets/now_playing_movies_list.dart';
import 'package:flutter_netflix/widgets/search_movies_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  Timer? debounceTimer;
  String lastSearchedMovie = '';

  @override
  void initState() {
    super.initState();
    // 在頁面加載時自動聚焦，觸發鍵盤彈出
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });

    textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (debounceTimer?.isActive ?? false) {
      debounceTimer!.cancel();
    }
    debounceTimer = Timer(const Duration(milliseconds: 2000), () {
      final movieName = textController.text.trim();
      if (movieName.isNotEmpty) {
        _searchMovie(movieName);
      }
    });
  }

  void _searchMovie(String movieName) {
    final trimmedName = movieName.trim();
    if (trimmedName.isNotEmpty) {
      lastSearchedMovie = trimmedName;
      ref.read(searchMoviesProvider.notifier).searchMovies(trimmedName);
    }
  }

  @override
  void dispose() {
    debounceTimer?.cancel();
    textController.removeListener(_onTextChanged);
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchMoviewState = ref.watch(searchMoviesProvider);
    final nowPlayingState = ref.watch(nowPlayingMoviesProvider);

    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        backgroundColor: kBlackColor,
        title: TextField(
          controller: textController,
          focusNode: focusNode,
          onSubmitted: (movieName) {
            if (movieName.trim() != lastSearchedMovie) {
              _searchMovie(movieName);
            }
            focusNode.unfocus();
          },
          decoration: InputDecoration(
            hintText: '搜尋電影',
            hintStyle: const TextStyle(color: kGreyColor),
            suffixIcon: textController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: kWhiteColor),
                    onPressed: () {
                      textController.clear();
                      ref.read(searchMoviesProvider.notifier).clearResults();
                      focusNode.requestFocus();
                    },
                  )
                : null,
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(20), // 限制輸入字數
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white, // 設定返回按鈕顏色
          onPressed: () {
            Navigator.pop(context);
            textController.clear();
            ref.read(searchMoviesProvider.notifier).clearResults();
            focusNode.requestFocus();
          },
        ),
      ),
      body: searchMoviewState.moviesList.isEmpty &&
              searchMoviewState.isSearching == false
          ? NowPlayingMoviesList(
              title: '電影推薦',
              movieState: nowPlayingState,
            )
          : SearchMoviesGrid(
              title: '搜尋結果',
              movieState: searchMoviewState,
            ),
    );
  }
}
