import 'package:equatable/equatable.dart';
import 'package:flutter_developer_assessment/domain/model/article.dart';

sealed class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object> get props => [];
}

class HomeScreenInitial extends HomeScreenState {}

class HomeScreenLoaded extends HomeScreenState {
  final List<Article> articles;
  final int pageNumber;
  final bool isLastPage;
  final bool isNextPageError;
  final bool isLoadingNextPage;

  const HomeScreenLoaded({
    required this.articles,
    required this.pageNumber,
    required this.isLastPage,
    this.isNextPageError = false,
    this.isLoadingNextPage = false,
  });

  HomeScreenLoaded copyWith ({
    List<Article>? articles,
    int? pageNumber,
    bool? isLastPage,
    bool? isNextPageError,
    bool? isLoadingNextPage,
  }) {
    return HomeScreenLoaded(
      articles: articles ?? this.articles,
      pageNumber: pageNumber ?? this.pageNumber,
      isLastPage: isLastPage ?? this.isLastPage,
      isNextPageError: isNextPageError ?? this.isNextPageError,
      isLoadingNextPage: isLoadingNextPage ?? this.isLoadingNextPage,
    );
  }

  @override
  List<Object> get props => [articles, isLastPage];
}

class HomeScreenError extends HomeScreenState {
  final String message;

  const HomeScreenError(this.message);

  @override
  List<Object> get props => [message];
}

