
import 'package:equatable/equatable.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();
}

class FetchArticlesEvent extends HomeScreenEvent {
  const FetchArticlesEvent();

  @override
  List<Object> get props => [];
}

class LoadNextPageEvent extends HomeScreenEvent {
  const LoadNextPageEvent();

  @override
  List<Object?> get props => [];
}

class OnTapArticleEvent extends HomeScreenEvent {
  final String articleUrl;

  const OnTapArticleEvent(this.articleUrl);

  @override
  List<Object?> get props => [articleUrl];
}

class OnRefreshArticlesEvent extends HomeScreenEvent {
  const OnRefreshArticlesEvent();

  @override
  List<Object> get props => [];
}