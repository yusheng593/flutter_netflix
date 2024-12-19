import 'package:flutter/material.dart';
import 'package:flutter_netflix/common/api_constants.dart';
import 'package:flutter_netflix/common/utils.dart';
import 'package:flutter_netflix/models/tv_model.dart';
import 'package:flutter_netflix/widgets/cached_image_widget.dart';
import 'package:flutter_netflix/widgets/movie_detail_navigator.dart';

class TopRatedTvWidget extends StatelessWidget {
  const TopRatedTvWidget({super.key, required this.topRatedMovies});

  final TvModel topRatedMovies;

  @override
  Widget build(BuildContext context) {
    return MovieDetailNavigator(
      id: topRatedMovies.id,
      isTvShow: true,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kWhiteColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedImageWidget(
              imgUrl: ApiConstants.postUrl + topRatedMovies.posterPath),
        ),
      ),
    );
  }
}
