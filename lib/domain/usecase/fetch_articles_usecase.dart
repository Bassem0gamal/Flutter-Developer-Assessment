import 'package:dio/dio.dart';
import 'package:flutter_developer_assessment/data/repository/articles_repository.dart';
import 'package:flutter_developer_assessment/domain/model/app_error.dart';
import 'package:flutter_developer_assessment/domain/model/article.dart';
import 'package:flutter_developer_assessment/domain/model/page_result.dart';

class FetchArticlesUseCase {
  final ArticleRepository repository;

  FetchArticlesUseCase(this.repository);

  Future<PageResult<Article>> call({
    required int pageNum,
    required int pageSize,
    String? category,
    String? query,
  }) async {

    try {
      final response = await repository.getArticles(
        pageNum: pageNum,
        pageSize: pageSize,
        category: category,
        query: query,
      );

      repository.saveArticles(response.items);
      return response;

    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw AppError(AppErrorType.timeOut);
        case DioExceptionType.badResponse:
          final code = e.response?.statusCode ?? 0;
          if (code == 429) {
            throw AppError(AppErrorType.rateLimitExceeded);
          } else if (code == 500) {
            throw AppError(AppErrorType.serverError);
          } else {
            throw AppError(AppErrorType.unknown);
          }
        case DioExceptionType.connectionError:
          throw AppError(AppErrorType.noInternet);
        case DioExceptionType.badCertificate:
        case DioExceptionType.cancel:
        case DioExceptionType.unknown:
          throw AppError(AppErrorType.unknown);
      }
    }
  }
}
