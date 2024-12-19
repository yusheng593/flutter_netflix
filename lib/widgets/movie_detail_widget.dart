import 'package:flutter/material.dart';
import 'package:flutter_netflix/common/api_constants.dart';
import 'package:flutter_netflix/common/utils.dart';
import 'package:flutter_netflix/models/movie_detail_model.dart';
import 'package:flutter_netflix/models/tv_detail_model.dart';
import 'package:flutter_netflix/view_models/nowPlayingMovies/now_playing_movies_provider.dart';
import 'package:flutter_netflix/widgets/cached_image_widget.dart';
import 'package:flutter_netflix/widgets/genre_wrap_widget.dart';
import 'package:flutter_netflix/widgets/search_movies_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieDetailWidget<T> extends StatelessWidget {
  const MovieDetailWidget({super.key, required this.detail});

  final T detail;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    String title;
    String backdropPath;
    String releaseDate;
    String overview;
    List<dynamic> genres;
    String formattedVoteAverage;

    // 根據模型類型賦值
    if (detail is MovieDetailModel) {
      final movie = detail as MovieDetailModel;
      title = movie.title;
      backdropPath = movie.backdropPath;
      releaseDate = movie.releaseDate;
      overview = movie.overview;
      genres = movie.genres;
      formattedVoteAverage = movie.formattedVoteAverage;
    } else if (detail is TvDetailModel) {
      final tv = detail as TvDetailModel;
      title = tv.name;
      backdropPath = tv.backdropPath;
      releaseDate = tv.firstAirDate;
      overview = tv.overview;
      genres = tv.genres;
      formattedVoteAverage = tv.formattedVoteAverage;
    } else {
      throw Exception("Unsupported detail type");
    }

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: height,
          maxHeight: double.infinity,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: width,
              height: height * 0.25,
              decoration: const BoxDecoration(color: kGreyColor),
              child: CachedImageWidget(
                imgUrl: ApiConstants.postUrl + backdropPath,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GenreWrapWidget(genres: genres),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: kWhiteColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Text(
                          releaseDate,
                          style:
                              const TextStyle(color: kWhiteColor, fontSize: 16),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '⭐️$formattedVoteAverage/10',
                          style:
                              const TextStyle(color: kWhiteColor, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  Text(
                    overview,
                    style: const TextStyle(
                        color: kWhiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            const Divider(
              color: kGreyColor,
              thickness: 1,
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final nowPlayingState = ref.watch(nowPlayingMoviesProvider);
                return Flexible(
                  fit: FlexFit.loose,
                  child: SearchMoviesGrid(
                      title: '你也可能喜歡', movieState: nowPlayingState),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
