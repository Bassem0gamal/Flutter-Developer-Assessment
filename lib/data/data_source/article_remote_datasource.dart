import 'package:dio/dio.dart';
import 'package:flutter_developer_assessment/consts.dart';
import 'package:flutter_developer_assessment/data/dto/articles_response_dto.dart';

class ArticleRemoteDatasource {
  final Dio _dio = Dio();

  final String _baseUrl = 'https://newsapi.org/v2';
  final String _endpoint = '/top-headlines';

  Future<ArticlesResponseDto> fetchTopArticles({
    required int pageNum,
    required int pageSize,
    String? category,
  }) async {

    final response = await _dio.get(
      '$_baseUrl$_endpoint',
      queryParameters: {
        'apiKey': NEWS_API_KEY,
        'page': pageNum,
        'pageSize': pageSize,
        'category': category,
      },
    );

    return ArticlesResponseDto.fromJson(response.data);
  }
}