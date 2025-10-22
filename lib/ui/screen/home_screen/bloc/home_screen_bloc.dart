
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_developer_assessment/domain/model/category_filter.dart';
import 'package:flutter_developer_assessment/domain/usecase/fetch_articles_usecase.dart';
import 'package:flutter_developer_assessment/domain/model/article.dart';
import 'package:flutter_developer_assessment/domain/usecase/fetch_saved_articles_usecase.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:rxdart/rxdart.dart';

import 'home_screen_event.dart';
import 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {

  final FetchArticlesUseCase _fetchArticlesUseCase;
  final FetchSavedArticlesUseCase _fetchSavedArticlesUseCase;

  HomeScreenBloc(
      this._fetchArticlesUseCase,
      this._fetchSavedArticlesUseCase,
      ) : super(HomeScreenInitial()) {
    on<FetchArticlesEvent>(_fetchArticlesEvent);
    on<OnRefreshArticlesEvent>(_onRefreshArticlesEvent);
    on<OnSelectFilterEvent>(_onSelectFilterEvent);
    on<SearchArticlesEvent>(
      _searchArticlesEvent,
      transformer: debounceTransformer(Duration(milliseconds: 500)),
    );
  }

  EventTransformer<E> debounceTransformer<E>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  Future<void> _fetchArticlesEvent(FetchArticlesEvent event, Emitter<HomeScreenState> emit) async {
    InternetConnection internetConnection = InternetConnection();

    final hasConnection = await internetConnection.hasInternetAccess;

    if (!hasConnection) {
      await _fetchArticlesFromCache(event, emit);
    } else {
      await _fetchArticlesFromAPI(event, emit);
    }
  }

  Future<void> _fetchArticlesFromAPI(FetchArticlesEvent event, Emitter<HomeScreenState> emit) async {
    try {
      int pageNum = 0;
      int pageSize = 10;


      List<Article> currentArticles = [];
      CategoryFilter filter = CategoryFilter.general;
      String? query;

      if (state is HomeScreenLoadedState) {
        final currentState = state as HomeScreenLoadedState;

        pageNum = currentState.pageNumber + 1;
        currentArticles = currentState.articles;
        filter = currentState.selectedFilter;
        query = currentState.isSearching ? currentState.searchQuery : null;

        emit(currentState.copyWith(isLoadingNextPage: true));
      }

      final result = await _fetchArticlesUseCase.call(
        pageNum: pageNum ,
        pageSize: pageSize,
        category: filter.name,
        query: query,
      );

      final newState = HomeScreenLoadedState(
        articles: currentArticles + result.items,
        isLastPage: result.isLastPage(pageSize),
        pageNumber: result.pageNum,
        selectedFilter: filter,
      );

      emit(newState);

    } catch (e) {
      emit(HomeScreenError(e.toString()));
    }
  }
  Future<void> _fetchArticlesFromCache(FetchArticlesEvent event, Emitter<HomeScreenState> emit) async {

   final result = await _fetchSavedArticlesUseCase.call();

    final newState = HomeScreenLoadedState(
      articles: result,
      isLastPage: true,
      pageNumber: 0,
      selectedFilter: CategoryFilter.general,
    );

    emit(newState);
  }

    Future<void> _onRefreshArticlesEvent(OnRefreshArticlesEvent event, Emitter<HomeScreenState> emit) async {
    emit(HomeScreenInitial());
    add(const FetchArticlesEvent());
  }

  Future<void> _onSelectFilterEvent(OnSelectFilterEvent event, Emitter<HomeScreenState> emit) async {
    if (state is HomeScreenLoadedState) {
      final currentState = state as HomeScreenLoadedState;

      emit(currentState.copyWith(
          selectedFilter: event.selectedFilter,
          articles: [],
          pageNumber: 0,
          isLastPage: false,
      ));
      add(const FetchArticlesEvent());
    }
  }

  Future<void> _searchArticlesEvent(SearchArticlesEvent event, Emitter<HomeScreenState> emit) async {
    final query = event.query.trim();

    if (state is HomeScreenLoadedState) {
      final currentState = state as HomeScreenLoadedState;

      emit(currentState.copyWith(
        isSearching: query.isNotEmpty,
        searchQuery: query,
        articles: [],
        pageNumber: 0,
        isLastPage: false,
      ));
      add(const FetchArticlesEvent());
    }
  }
}