import 'package:flutter/material.dart';
import 'package:flutter_netflix/models/movie_model.dart';

const kBlackColor = Color(0xFF000000);
const kRedColor = Color(0xFFDB0000);
const kGreyColor = Color(0xFF564D4D);
const kWhiteColor = Color(0xFFF5F5F1);
const kBlueColor = Color(0xFF073763);
const String movieImage = 'https://i.ibb.co/FwTPCCc/Ultra-Linx.jpg';

// 定義一個介面，確保所有狀態類型都實作這個介面
abstract class MovieState {
  List<MovieModel> get moviesList;
}
