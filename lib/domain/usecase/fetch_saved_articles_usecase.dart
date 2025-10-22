
import 'package:flutter_developer_assessment/data/repository/articles_repository.dart';
import 'package:flutter_developer_assessment/domain/model/article.dart';

class FetchSavedArticlesUseCase {
  final ArticleRepository repository;

  FetchSavedArticlesUseCase(this.repository);

  Future<List<Article>> call() async {
    return await repository.getSavedArticles();
  }
}