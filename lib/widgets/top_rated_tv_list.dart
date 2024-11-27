import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_netflix/view_models/top_rated_tv/top_rated_tv_provider.dart';
import 'package:flutter_netflix/widgets/top_rated_tv_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopRatedTvList extends StatelessWidget {
  const TopRatedTvList({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final topRatedTvState = ref.watch(topRatedTvProvider);

        return CarouselSlider.builder(
          itemCount: topRatedTvState.tvList.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: TopRatedTvWidget(
                topRatedMovies: topRatedTvState.tvList[index],
              ),
            );
          },
          options: CarouselOptions(
            height: height * 0.6,
            enlargeCenterPage: true, // 突出顯示當前項目
            enableInfiniteScroll: false,
            viewportFraction: 0.8, // 控制每個項目的寬度占比
            scrollPhysics: const BouncingScrollPhysics(), // 增加彈性滾動效果
          ),
        );
      },
    );
  }
}
