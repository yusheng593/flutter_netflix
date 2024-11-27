import 'package:flutter/material.dart';
import 'package:flutter_netflix/common/api_constants.dart';
import 'package:flutter_netflix/common/utils.dart';
import 'package:flutter_netflix/models/movie_model.dart';
import 'package:flutter_netflix/view_models/popular_movies/popular_movies_provider.dart';
import 'package:flutter_netflix/view_models/top_rated_movies/top_rated_movies_provider.dart';
import 'package:flutter_netflix/view_models/top_rated_tv/top_rated_tv_provider.dart';
import 'package:flutter_netflix/widgets/cached_image_widget.dart';
import 'package:flutter_netflix/widgets/top_rated_tv_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlueColor,
        leading: Image.asset('assets/netflix.png'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: kWhiteColor,
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppGradients.blueToBlackGradient(),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final topRatedTvState = ref.watch(topRatedTvProvider);
                  return SizedBox(
                    height: height * 0.6,
                    child: PageView.builder(
                      itemCount: topRatedTvState.tvList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.07),
                          child: TopRatedTvWidget(
                            topRatedMovies: topRatedTvState.tvList[index],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final popularMovieState = ref.watch(popularMoviesProvider);
                  return MoviesListWidget(
                      title: '熱門電影', movieState: popularMovieState);
                },
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final topRatedMovieState = ref.watch(topRatedMoviesProvider);
                  return MoviesListWidget(
                      title: '最多人讚', movieState: topRatedMovieState);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 定義一個介面，確保所有狀態類型都實作這個介面
abstract class MovieState {
  List<MovieModel> get moviesList;
}

class MoviesListWidget<T extends MovieState> extends StatelessWidget {
  const MoviesListWidget({
    super.key,
    required this.title,
    required this.movieState,
  });

  final String title;
  final T movieState;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width * 0.02),
          child: Text(
            title,
            style: const TextStyle(
                color: kWhiteColor, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        SizedBox(
          width: double.infinity,
          height: height * 0.2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movieState.moviesList.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == movieState.moviesList.length) {
                return SizedBox(
                  width: width * 0.02,
                );
              }
              return Container(
                padding: EdgeInsets.only(left: width * 0.02),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedImageWidget(
                      imgUrl: ApiConstants.postUrl +
                          movieState.moviesList[index].posterPath),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
