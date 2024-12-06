import 'package:flutter/material.dart';
import 'package:flutter_netflix/common/api_constants.dart';
import 'package:flutter_netflix/common/utils.dart';
import 'package:flutter_netflix/widgets/cached_image_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchMoviesGrid<T extends MovieState> extends StatelessWidget {
  const SearchMoviesGrid({
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
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? _) {
            return Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 每行 3 個項目
                    mainAxisSpacing: 10, // 項目之間的垂直間距
                    crossAxisSpacing: 10, // 項目之間的水平間距
                    childAspectRatio: 0.7, // 寬高比，調整圖片比例
                  ),
                  itemCount: movieState.moviesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedImageWidget(
                          imgUrl: ApiConstants.postUrl +
                              movieState.moviesList[index].posterPath),
                    );
                  }),
            );
          },
        )
      ],
    );
  }
}
