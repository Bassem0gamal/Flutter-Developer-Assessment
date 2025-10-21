
import 'package:flutter_developer_assessment/data/dto/article_dto.dart';
import 'package:flutter_developer_assessment/domain/model/article.dart';

class ArticleTransformer {
  Article transform(ArticleDto dto) {
    return Article(
      source: Source(id: dto.source?.id, name: dto.source?.name),
      author: dto.author,
      title: dto.title,
      description: dto.description,
      url: dto.url,
      urlToImage: dto.urlToImage,
      publishedAt: dto.publishedAt,
      content: dto.content,
    );
  }
}