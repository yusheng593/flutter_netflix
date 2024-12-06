import 'package:flutter/material.dart';
import 'package:flutter_netflix/services/init_getit.dart';
import 'package:flutter_netflix/services/navigation_service.dart';
import 'package:flutter_netflix/view_models/nowPlayingMovies/now_playing_movies_provider.dart';
import 'package:flutter_netflix/view_models/popular_movies/popular_movies_provider.dart';
import 'package:flutter_netflix/view_models/top_rated_movies/top_rated_movies_provider.dart';
import 'package:flutter_netflix/view_models/top_rated_tv/top_rated_tv_provider.dart';
import 'package:flutter_netflix/widgets/app_error_widget.dart';
import 'package:flutter_netflix/widgets/bottom_nav_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

final initProvider = FutureProvider.autoDispose<void>((ref) async {
  ref.keepAlive();
  await Future.delayed(const Duration(seconds: 3)); // 跑動畫
  await Future.microtask(() async {
    await ref.read(topRatedTvProvider.notifier).getTopRatedTv();
    await ref.read(topRatedMoviesProvider.notifier).getTopRatedMovies();
    await ref.read(popularMoviesProvider.notifier).getPopularMovies();
    await ref.read(nowPlayingMoviesProvider.notifier).getNowPlayingMovies();
  });
});

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initWatch = ref.watch(initProvider);

    return Scaffold(
      body: initWatch.when(data: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          getIt<NavigationService>()
              .navigatePushReplacement(const BottomNavBar());
        });

        return const SizedBox.shrink();
      }, error: (error, _) {
        return AppErrorWidget(
            errorText: error.toString(),
            retryFunction: () => ref.refresh(initProvider));
      }, loading: () {
        return Center(
          child: Lottie.asset(
            'assets/netflix_animation.json',
            repeat: false,
          ),
        );
      }),
    );
  }
}
