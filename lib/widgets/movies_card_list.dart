// 定義一個介面，確保所有狀態類型都實作這個介面
import 'package:flutter/material.dart';
import 'package:flutter_netflix/common/api_constants.dart';
import 'package:flutter_netflix/common/utils.dart';
import 'package:flutter_netflix/models/movie_model.dart';
import 'package:flutter_netflix/widgets/cached_image_widget.dart';

abstract class MovieState {
  List<MovieModel> get moviesList;
}

class MoviesCardList<T extends MovieState> extends StatelessWidget {
  const MoviesCardList({
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
