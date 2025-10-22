import 'package:equatable/equatable.dart';
import 'package:flutter_developer_assessment/domain/model/article.dart';
import 'package:flutter_developer_assessment/domain/model/category_filter.dart';

sealed class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object> get props => [];
}

class HomeScreenInitial extends HomeScreenState {}

class HomeScreenLoadedState extends HomeScreenState {
  final List<Article> articles;
  final int pageNumber;
  final bool isLastPage;
  final bool isNextPageError;
  final bool isLoadingNextPage;
  final bool isSearching;
  final String searchQuery;
  final List<CategoryFilter> filters;
  final CategoryFilter selectedFilter;

  const HomeScreenLoadedState({
    required this.articles,
    required this.pageNumber,
    required this.isLastPage,
    this.isNextPageError = false,
    this.isLoadingNextPage = false,
    this.isSearching = false,
    this.searchQuery = '',
    this.filters = CategoryFilter.values,
    this.selectedFilter = CategoryFilter.general,
  });

  HomeScreenLoadedState copyWith({
    List<Article>? articles,
    int? pageNumber,
    bool? isLastPage,
    bool? isNextPageError,
    bool? isLoadingNextPage,
    bool? isSearching,
    String? searchQuery,
    CategoryFilter? selectedFilter,
  }) {
    return HomeScreenLoadedState(
      articles: articles ?? this.articles,
      pageNumber: pageNumber ?? this.pageNumber,
      isLastPage: isLastPage ?? this.isLastPage,
      isNextPageError: isNextPageError ?? this.isNextPageError,
      isLoadingNextPage: isLoadingNextPage ?? this.isLoadingNextPage,
      isSearching: isSearching ?? this.isSearching,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }

  @override
  List<Object> get props => [
    articles,
    pageNumber,
    isLastPage,
    isNextPageError,
    isLoadingNextPage,
    isSearching,
    searchQuery,
    selectedFilter,
  ];
}

class HomeScreenError extends HomeScreenState {
  final String message;

  const HomeScreenError(this.message);

  @override
  List<Object> get props => [message];
}