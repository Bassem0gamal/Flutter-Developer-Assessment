import 'package:objectbox/objectbox.dart';

@Entity()
class ArticleEntity {
  @Id(assignable: true)
  int id;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;

  ArticleEntity({
    this.id = 0,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
  });
}