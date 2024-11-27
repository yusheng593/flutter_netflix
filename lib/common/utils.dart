import 'package:flutter/material.dart';

// const kBlackColor = Color(0xFF0D0D0D);
const kBlackColor = Color(0xFF000000);
const kRedColor = Color(0xFFDB0000);
const kGreyColor = Color(0xFF564D4D);
const kWhiteColor = Color(0xFFF5F5F1);
const kBlueColor = Color(0xFF073763);
const String movieImage = 'https://i.ibb.co/FwTPCCc/Ultra-Linx.jpg';

class AppGradients {
  static LinearGradient blueToBlackGradient() {
    return const LinearGradient(
      colors: [kBlueColor, kBlackColor],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
}
