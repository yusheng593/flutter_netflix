import 'package:flutter/material.dart';
import 'package:flutter_netflix/common/utils.dart';
import 'package:flutter_netflix/screens/search_screen.dart';
import 'package:flutter_netflix/services/init_getit.dart';
import 'package:flutter_netflix/services/navigation_service.dart';
import 'package:flutter_netflix/view_models/upcomingMovies/upcoming_movies_provider.dart';
import 'package:flutter_netflix/widgets/upcomming_movies_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: kBlueColor,
        title: const Text(
          '熱播新片',
          style: TextStyle(
              color: kWhiteColor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              getIt<NavigationService>().navigate(const SearchScreen());
            },
            icon: const Icon(
              Icons.search,
              color: kWhiteColor,
            ),
          )
        ],
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final upcomingMoviesState = ref.watch(upcomingMoviesProvider);
          return UpcommingMoviesWidget(movieState: upcomingMoviesState);
        },
      ),
    );
  }
}
