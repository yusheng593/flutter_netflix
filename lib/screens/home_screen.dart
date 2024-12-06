import 'package:flutter/material.dart';
import 'package:flutter_netflix/common/app_gradients.dart';
import 'package:flutter_netflix/common/app_spaces.dart';
import 'package:flutter_netflix/common/utils.dart';
import 'package:flutter_netflix/screens/search_screen.dart';
import 'package:flutter_netflix/services/init_getit.dart';
import 'package:flutter_netflix/services/navigation_service.dart';
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
            onPressed: () {
              getIt<NavigationService>().navigate(const SearchScreen());
            },
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: width * 0.047,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    height: height * 0.035,
                    decoration: BoxDecoration(
                      color: kWhiteColor.withOpacity(0.2),
                      border: Border.all(color: kWhiteColor.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(height * 0.035),
                    ),
                    child: Center(
                      child: Text(
                        '最高評分劇集',
                        style: TextStyle(
                          color: kWhiteColor,
                          fontSize: height * 0.015,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppSpaces.heightSpace(context),
              ),
              const TopRatedTvList(),
              SizedBox(
                height: AppSpaces.heightSpace(context),
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final popularMovieState = ref.watch(popularMoviesProvider);
                  return MoviesCardList(
                      title: '熱門電影', movieState: popularMovieState);
                },
              ),
              SizedBox(
                height: AppSpaces.heightSpace(context),
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
