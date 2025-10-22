import 'package:flutter_developer_assessment/data/api/article_remote_datasource.dart';
import 'package:flutter_developer_assessment/data/transformer/article_transformer.dart';
import 'package:flutter_developer_assessment/domain/model/article.dart';
import 'package:flutter_developer_assessment/domain/model/page_result.dart';

class ArticleRepository {
  final ArticleRemoteDatasource _remoteDatasource;
  final ArticleTransformer _transformer;

  ArticleRepository(this._remoteDatasource, this._transformer);

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
        items: response.articles.map((dto) => _transformer.transform(dto)).toList(),
        pageNum: pageNum,
        totalItems: response.totalResults,
    );
  }
}
