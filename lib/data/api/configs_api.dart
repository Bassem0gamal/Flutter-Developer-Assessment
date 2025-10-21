import 'package:dio/dio.dart';
import 'package:flutter_developer_assessment/consts.dart';

class ConfigService {
  final Dio _dio = Dio();

  final String _baseUrl = 'https://newsapi.org/v2';
  final String _endpoint = '/top-headlines';
  final String _apiKey = NEWS_API_KEY;

  Future<List<dynamic>> fetchTopArticlas() async {
    try{
      final response = await _dio.get(
        '$_baseUrl$_endpoint',
        queryParameters: {
          'country': 'us',
          'apiKey': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        return response.data['articles'];
      } else {
        throw Exception('Failed to load articles');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}