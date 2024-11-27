import 'package:flutter/material.dart';
import 'package:flutter_netflix/common/utils.dart';
import 'package:flutter_netflix/screens/home_screen.dart';
import 'package:flutter_netflix/screens/more_screen.dart';
import 'package:flutter_netflix/screens/search_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  final Widget tabBar = const TabBar(
    tabs: [
      Tab(
        icon: Icon(Icons.home),
        text: '首頁',
      ),
      Tab(
        icon: Icon(Icons.search),
        text: "搜尋",
      ),
      Tab(
        icon: Icon(Icons.photo_library_outlined),
        text: "熱播新片",
      ),
    ],
    labelColor: kWhiteColor,
    unselectedLabelColor: kGreyColor,
    indicatorColor: Colors.transparent,
    dividerColor: Colors.transparent, // 去除分隔白線
  );

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: kBlackColor,
          height: height * 0.09,
          child: tabBar,
        ),
        body: const TabBarView(
          children: [
            HomeScreen(),
            SearchScreen(),
            MoreScreen(),
          ],
        ),
      ),
    );
  }
}
