import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_netflix/common/utils.dart';
import 'package:flutter_netflix/models/movie_detail_model.dart';
import 'package:flutter_netflix/models/tv_detail_model.dart';
import 'package:flutter_netflix/repository/movies_repository.dart';
import 'package:flutter_netflix/services/init_getit.dart';
import 'package:flutter_netflix/widgets/movie_detail_widget.dart';
import 'package:lottie/lottie.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen(
      {super.key, required this.id, required this.isTvShow});

  final int id;
  final bool isTvShow;

  @override
  Widget build(BuildContext context) {
    log('movieId: $id');
    late Future<dynamic> futureMovieDetail;

    if (isTvShow) {
      futureMovieDetail = getIt<MoviesRepository>().fetchTvDetails(tvId: id);
    } else {
      futureMovieDetail =
          getIt<MoviesRepository>().fetchMoviedetails(movieId: id);
    }

    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        backgroundColor: kBlackColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isTvShow
          ? FutureBuilder<TvDetailModel>(
              future: futureMovieDetail as Future<TvDetailModel>,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Lottie.asset(
                      'animation/detail_loading.json',
                      width: 100,
                      height: 100,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No data available'));
                } else {
                  return MovieDetailWidget(detail: snapshot.data!);
                }
              },
            )
          : FutureBuilder<MovieDetailModel>(
              future: futureMovieDetail as Future<MovieDetailModel>,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Lottie.asset(
                      'animation/detail_loading.json',
                      width: 100,
                      height: 100,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No data available'));
                } else {
                  return MovieDetailWidget(detail: snapshot.data!);
                }
              },
            ),
    );
  }
}
