import 'package:flutter_developer_assessment/data/data_source/article_local_datasource.dart';
import 'package:flutter_developer_assessment/data/data_source/article_remote_datasource.dart';
import 'package:flutter_developer_assessment/data/transformer/article_transformer.dart';
import 'package:flutter_developer_assessment/domain/model/article.dart';
import 'package:flutter_developer_assessment/domain/model/page_result.dart';

class ArticleRepository {
  final ArticleRemoteDatasource _remoteDatasource;
  final ArticleLocalDataSource _localDataSource;
  final ArticleTransformer _transformer;

  ArticleRepository(
      this._remoteDatasource,
      this._localDataSource,
      this._transformer,
      );

  Future<PageResult<Article>> getArticles({
    required int pageNum,
    required int pageSize,
    String? category,
    String? query,
  }) async {

      final response = await _remoteDatasource.fetchTopArticles(
        pageNum: pageNum,
        pageSize: pageSize,
        category: category,
        query: query,
    );

      return PageResult(
        items: response.articles.map((dto) => _transformer.fromDto(dto)).toList(),
        pageNum: pageNum,
        totalItems: response.totalResults,
      );

  }

  Future<List<Article>> getSavedArticles() async {
    final entities = _localDataSource.getSavedArticles();
    return entities.map((e) => _transformer.fromEntity(e)).toList();
  }

  Future<void> saveArticles(List<Article> articles) async {
    final entities = articles.map((a) => _transformer.toEntity(a)).toList();
    _localDataSource.saveArticles(entities);
  }
}
