import 'package:flutter_developer_assessment/data/repository/articles_repository.dart';
import 'package:flutter_developer_assessment/domain/model/article.dart';
import 'package:flutter_developer_assessment/domain/model/page_result.dart';

class FetchArticlesUseCase {
  final ArticleRepository repository;

  FetchArticlesUseCase(this.repository);

  Future<PageResult<Article>> call(int pageNum, int pageSize) async {
    return await repository.getArticles(pageNum, pageSize);
  }
}