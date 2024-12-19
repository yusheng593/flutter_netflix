import 'package:flutter/material.dart';
import 'package:flutter_netflix/common/utils.dart';

class GenreWrapWidget extends StatelessWidget {
  const GenreWrapWidget({super.key, required this.genres});
  final List<dynamic> genres;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        genres.length,
        (index) => chipWidget(
          genre: genres[index].name,
          isLast: index == genres.length - 1,
        ),
      ),
    );
  }

  Widget chipWidget({required String genre, isLast}) {
    return isLast
        ? Text(
            genre,
            style: const TextStyle(color: kWhiteColor, fontSize: 16),
          )
        : Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: genre,
                  style: const TextStyle(color: kWhiteColor, fontSize: 16),
                ),
                const TextSpan(
                  text: ' • ',
                  style: TextStyle(color: kGreyColor, fontSize: 16),
                ),
              ],
            ),
          );
  }
}
