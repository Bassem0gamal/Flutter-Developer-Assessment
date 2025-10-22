import 'package:dio/dio.dart';
import 'package:flutter_developer_assessment/consts.dart';
import 'package:flutter_developer_assessment/data/dto/articles_response_dto.dart';

class ArticleRemoteDatasource {
  final Dio _dio;

  static final String _baseUrl = 'https://newsapi.org/v2';
  static final String _endpoint = '/top-headlines';

  ArticleRemoteDatasource(this._dio);

  Future<ArticlesResponseDto> fetchTopArticles({
    required int pageNum,
    required int pageSize,
    String? category,
    String? query,
  }) async {

    final response = await _dio.get(
      '$_baseUrl$_endpoint',
      queryParameters: {
        'apiKey': NEWS_API_KEY,
        'page': pageNum,
        'pageSize': pageSize,
        'category': category,
        'q': query,
      },
    );

    return ArticlesResponseDto.fromJson(response.data);
  }
}