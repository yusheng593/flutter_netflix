import 'package:flutter/material.dart';
import 'package:flutter_netflix/common/utils.dart';
import 'package:flutter_netflix/view_models/popular_movies/popular_movies_provider.dart';
import 'package:flutter_netflix/view_models/top_rated_movies/top_rated_movies_provider.dart';
import 'package:flutter_netflix/widgets/movies_card_list.dart';
import 'package:flutter_netflix/widgets/top_rated_tv_list.dart';
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
              TopRatedTvList(width: width, height: height),
              SizedBox(
                height: height * 0.03,
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final popularMovieState = ref.watch(popularMoviesProvider);
                  return MoviesCardList(
                      title: '熱門電影', movieState: popularMovieState);
                },
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final topRatedMovieState = ref.watch(topRatedMoviesProvider);
                  return MoviesCardList(
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
