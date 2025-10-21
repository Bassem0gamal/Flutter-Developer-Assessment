import 'article_dto.dart';

class ArticlesResponseDto {
  final List<ArticleDto> articles;
  final int totalResults;
  final String status;

  ArticlesResponseDto({
    required this.status,
    required this.articles,
    required this.totalResults,
  });

  factory ArticlesResponseDto.fromJson(Map<String, dynamic> json) {
    var articlesJson = json['articles'] as List;
    List<ArticleDto> articlesList =
        articlesJson.map((article) => ArticleDto.fromJson(article)).toList();

    return ArticlesResponseDto(
      articles: articlesList,
      totalResults: json['totalResults'],
      status: json['status'],
    );
  }
}