import 'package:flutter/material.dart';
import 'package:flutter_netflix/screens/movie_detail_screen.dart';
import 'package:flutter_netflix/services/init_getit.dart';
import 'package:flutter_netflix/services/navigation_service.dart';

class MovieDetailNavigator extends StatelessWidget {
  final int id;
  final bool isTvShow;
  final Widget child;

  const MovieDetailNavigator({
    super.key,
    required this.id,
    required this.child,
    required this.isTvShow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getIt<NavigationService>().navigate(MovieDetailScreen(
          id: id,
          isTvShow: isTvShow,
        ));
      },
      child: child,
    );
  }
}
