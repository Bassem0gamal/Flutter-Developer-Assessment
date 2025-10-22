import 'package:objectbox/objectbox.dart';
import '../entity/article_entity.dart';
import '../entity/objectbox_store.dart';

class ArticleLocalDataSource {
  final Box<ArticleEntity> _box;

  ArticleLocalDataSource(ObjectBoxStore store)
      : _box = store.store.box<ArticleEntity>();

  List<ArticleEntity> getSavedArticles() => _box.getAll();

  void saveArticles(List<ArticleEntity> articles) {
    _box.putMany(articles);
  }

  void clear() => _box.removeAll();
}