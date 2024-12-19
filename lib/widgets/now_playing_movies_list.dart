import 'package:flutter/material.dart';
import 'package:flutter_netflix/common/api_constants.dart';
import 'package:flutter_netflix/common/utils.dart';
import 'package:flutter_netflix/widgets/cached_image_widget.dart';
import 'package:flutter_netflix/widgets/movie_detail_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NowPlayingMoviesList<T extends MovieState> extends StatelessWidget {
  const NowPlayingMoviesList({
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
          height: height * 0.005,
        ),
        Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return MovieDetailNavigator(
                  id: movieState.moviesList[index].id,
                  isTvShow: false,
                  child: Container(
                    height: height * 0.1,
                    margin: EdgeInsets.all(width * 0.02),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedImageWidget(
                            imgUrl: ApiConstants.postUrl +
                                movieState.moviesList[index].backdropPath,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Expanded(
                          child: Text(
                            movieState.moviesList[index].title,
                            style: const TextStyle(
                                color: kWhiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            softWrap: true,
                          ),
                        ),
                        const Icon(Icons.info_outline, color: kWhiteColor),
                      ],
                    ),
                  ),
                );
              },
              itemCount: movieState.moviesList.length,
            ),
          );
        })
      ],
    );
  }
}
