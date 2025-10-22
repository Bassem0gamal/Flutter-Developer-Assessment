import 'package:flutter_developer_assessment/data/repository/articles_repository.dart';
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
    return await repository.getArticles(
      pageNum: pageNum,
      pageSize: pageSize,
      category: category,
      query: query,
    );
  }
}
