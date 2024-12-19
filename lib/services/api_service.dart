import 'dart:convert';
import 'dart:developer';

import 'package:flutter_netflix/common/api_constants.dart';
import 'package:flutter_netflix/models/movie_detail_model.dart';
import 'package:flutter_netflix/models/movie_model.dart';
import 'package:flutter_netflix/models/tv_detail_model.dart';
import 'package:flutter_netflix/models/tv_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // 最受歡迎電影(熱門電影)
  Future<List<MovieModel>> fetchPopularMovies({int page = 1}) async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}/movie/popular?language=zh-tw&page=$page');
    final response = await http.get(url, headers: ApiConstants.headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // log('data: $data');
      return List.from(
          data['results'].map((element) => MovieModel.fromJson(element)));
    } else {
      throw Exception(
          'error: ${ApiConstants.baseUrl} 錯誤 ${response.statusCode}');
    }
  }

  // 最高評分電影(最多人讚)
  Future<List<MovieModel>> fetchTopRatedMovies({int page = 1}) async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}/movie/top_rated?language=zh-tw&page=$page');
    final response = await http.get(url, headers: ApiConstants.headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // log('data: $data');
      return List.from(
          data['results'].map((element) => MovieModel.fromJson(element)));
    } else {
      throw Exception(
          'error: ${ApiConstants.baseUrl} 錯誤 ${response.statusCode}');
    }
  }

  // 即將上映
  Future<List<MovieModel>> fetchUpcomingMovies({int page = 1}) async {
    final endPoint = '/movie/upcoming?language=zh-tw&page=$page';
    final url = Uri.parse('${ApiConstants.baseUrl}$endPoint');
    final response = await http.get(url, headers: ApiConstants.headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // log('data: $data');
      return List.from(
          data['results'].map((element) => MovieModel.fromJson(element)));
    } else {
      throw Exception(
          'error: ${ApiConstants.baseUrl} 錯誤 ${response.statusCode}');
    }
  }

  // 最高評分劇集
  Future<List<TvModel>> fetchTopRatedTv({int page = 1}) async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}/tv/top_rated?language=zh-tw&page=$page');
    final response = await http.get(url, headers: ApiConstants.headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // log('data: $data');
      return List.from(
          data['results'].map((element) => TvModel.fromJson(element)));
    } else {
      throw Exception(
          'error: ${ApiConstants.baseUrl} 錯誤 ${response.statusCode}');
    }
  }

  // 搜尋電影
  Future<List<MovieModel>> searchMovie(
      {required String title, int page = 1}) async {
    final endPoint = '/search/movie?language=zh-tw&query=$title&page=$page';
    final url = Uri.parse('${ApiConstants.baseUrl}$endPoint');
    final response = await http.get(url, headers: ApiConstants.headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // log('data: $data');
      return List.from(
          data['results'].map((element) => MovieModel.fromJson(element)));
    } else {
      throw Exception(
          'error: ${ApiConstants.baseUrl} 錯誤 ${response.statusCode}');
    }
  }

  // 上映中電影(電影推薦)
  Future<List<MovieModel>> fetchNowPlayingMovies({int page = 1}) async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}/movie/now_playing?language=zh-tw&page=$page');
    final response = await http.get(url, headers: ApiConstants.headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // log('data: $data');
      return List.from(
          data['results'].map((element) => MovieModel.fromJson(element)));
    } else {
      throw Exception(
          'error: ${ApiConstants.baseUrl} 錯誤 ${response.statusCode}');
    }
  }

  // 電影內頁
  Future<MovieDetailModel> fetchMovieDetails({required int movieId}) async {
    final url =
        Uri.parse('${ApiConstants.baseUrl}/movie/$movieId?language=zh-tw');
    final response = await http.get(url, headers: ApiConstants.headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // log('data: $data');
      return MovieDetailModel.fromJson(data);
    } else {
      throw Exception(
          'error: ${ApiConstants.baseUrl} 錯誤 ${response.statusCode}');
    }
  }

// TV內頁
  Future<TvDetailModel> fetchTvDetails({required int tvId}) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/tv/$tvId?language=zh-tw');
    final response = await http.get(url, headers: ApiConstants.headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      log('data: $data');
      return TvDetailModel.fromJson(data);
    } else {
      throw Exception(
          'error: ${ApiConstants.baseUrl} 錯誤 ${response.statusCode}');
    }
  }
}
