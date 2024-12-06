import 'package:flutter/material.dart';
import 'package:flutter_netflix/common/utils.dart';

class AppGradients {
  static LinearGradient blueToBlackGradient() {
    return const LinearGradient(
      colors: [kBlueColor, kBlackColor],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
}
