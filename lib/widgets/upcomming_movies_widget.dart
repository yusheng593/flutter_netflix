import 'package:flutter/material.dart';
import 'package:flutter_netflix/common/api_constants.dart';
import 'package:flutter_netflix/common/app_gradients.dart';
import 'package:flutter_netflix/common/utils.dart';
import 'package:flutter_netflix/widgets/cached_image_widget.dart';

class UpcommingMoviesWidget<T extends MovieState> extends StatelessWidget {
  const UpcommingMoviesWidget({super.key, required this.movieState});

  final T movieState;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        gradient: AppGradients.blueToBlackGradient(),
      ),
      child: Expanded(
        child: ListView.builder(
          itemCount: movieState.moviesList.length,
          itemBuilder: (BuildContext context, int index) {
            List<String> dateParts =
                movieState.moviesList[index].releaseDate.split('-');
            final month = dateParts[1];
            final day = dateParts[2];

            return Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$month月',
                        style: const TextStyle(
                            color: kWhiteColor,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        day,
                        style: const TextStyle(
                            color: kWhiteColor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedImageWidget(
                              imgUrl: ApiConstants.postUrl +
                                  movieState.moviesList[index].backdropPath,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            movieState.moviesList[index].title,
                            style: const TextStyle(
                                color: kWhiteColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          movieState.moviesList[index].overview,
                          style: const TextStyle(
                              color: kWhiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
