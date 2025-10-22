
import 'package:flutter_developer_assessment/data/dto/article_dto.dart';
import 'package:flutter_developer_assessment/domain/model/article.dart';
import 'package:flutter_developer_assessment/data/entity/article_entity.dart';

class ArticleTransformer {
  Article fromDto(ArticleDto dto) {
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

  Article fromEntity(ArticleEntity entity) {
    return Article(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      url: entity.url,
      urlToImage: entity.urlToImage,
      publishedAt: entity.publishedAt,
    );
  }

  ArticleEntity toEntity(Article model) {
    return ArticleEntity(
      id: model.id ?? 0,
      title: model.title,
      description: model.description,
      url: model.url,
      urlToImage: model.urlToImage,
      publishedAt: model.publishedAt,
    );
  }
}