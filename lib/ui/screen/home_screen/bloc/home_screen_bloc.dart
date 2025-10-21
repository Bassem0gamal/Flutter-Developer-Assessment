
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_developer_assessment/domain/usecase/fetch_articles_usecase.dart';
import 'package:flutter_developer_assessment/domain/model/article.dart';

import 'home_screen_event.dart';
import 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {

  final FetchArticlesUseCase fetchArticlesUseCase;

  HomeScreenBloc(this.fetchArticlesUseCase) : super(HomeScreenInitial()) {
    on<FetchArticlesEvent>(_fetchArticlesEvent);
    on<OnRefreshArticlesEvent>(_onRefreshArticlesEvent);
  }

  Future<void> _fetchArticlesEvent(FetchArticlesEvent event, Emitter<HomeScreenState> emit) async {
    try {
      int pageNum = 0;
      int pageSize = 10;
      List<Article> currentArticles = [];

      if (state is HomeScreenLoaded) {
        final currentState = state as HomeScreenLoaded;
        pageNum = currentState.pageNumber + 1;
        currentArticles = currentState.articles;

        emit(currentState.copyWith(isLoadingNextPage: true));
      }

      await Future.delayed(const Duration(seconds: 3));
      final result = await fetchArticlesUseCase.call(pageNum, pageSize);

      final newState = HomeScreenLoaded(
          articles: currentArticles + result.items,
          isLastPage: result.isLastPage(pageSize),
          pageNumber: result.pageNum,
      );

      emit(newState);

    } catch (e) {
      emit(HomeScreenError(e.toString()));
    }
  }

  Future<void> _onRefreshArticlesEvent(OnRefreshArticlesEvent event, Emitter<HomeScreenState> emit) async {
    emit(HomeScreenInitial());
    add(const FetchArticlesEvent());
  }
}