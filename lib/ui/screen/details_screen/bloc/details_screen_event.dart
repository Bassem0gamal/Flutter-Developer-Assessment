import 'package:equatable/equatable.dart';
import 'package:flutter_developer_assessment/domain/model/article.dart';

abstract class DetailsScreenEvent extends Equatable {
  const DetailsScreenEvent();
}

class InitializeArticleDetailsEvent extends DetailsScreenEvent {
  final Article article;

  const InitializeArticleDetailsEvent(this.article);

  @override
  List<Object?> get props => [article];
}

class OpenArticleEvent extends DetailsScreenEvent {
  final String articleUrl;

  const OpenArticleEvent(this.articleUrl);

  @override
  List<Object?> get props => [articleUrl];
}

class ShareArticleEvent extends DetailsScreenEvent {
  final String articleUrl;

  const ShareArticleEvent(this.articleUrl);

  @override
  List<Object?> get props => [articleUrl];
}