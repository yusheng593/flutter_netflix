import 'dart:convert';
import 'dart:developer';

import 'package:flutter_netflix/common/api_constants.dart';
import 'package:flutter_netflix/models/movie_model.dart';
import 'package:flutter_netflix/models/tv_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<MovieModel>> fetchPopularMovies({int page = 1}) async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}/movie/popular?language=zh-tw&page=$page');
    final response = await http.get(url, headers: ApiConstants.headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // log('data: $data);
      return List.from(
          data['results'].map((element) => MovieModel.fromJson(element)));
    } else {
      throw Exception(
          'error: ${ApiConstants.baseUrl} 錯誤 ${response.statusCode}');
    }
  }

  Future<List<MovieModel>> fetchTopRatedMovies({int page = 1}) async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}/movie/top_rated?language=zh-tw&page=$page');
    final response = await http.get(url, headers: ApiConstants.headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // log('data: $data);
      return List.from(
          data['results'].map((element) => MovieModel.fromJson(element)));
    } else {
      throw Exception(
          'error: ${ApiConstants.baseUrl} 錯誤 ${response.statusCode}');
    }
  }

  Future<List<MovieModel>> getUpcomingMovies({int page = 1}) async {
    final endPoint = '/movie/upcoming?language=zh-tw&page=$page';
    final url = Uri.parse('${ApiConstants.baseUrl}$endPoint');
    final response = await http.get(url, headers: ApiConstants.headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      log('data: $data');
      return List.from(
          data['results'].map((element) => MovieModel.fromJson(element)));
    } else {
      throw Exception(
          'error: ${ApiConstants.baseUrl} 錯誤 ${response.statusCode}');
    }
  }

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
}
