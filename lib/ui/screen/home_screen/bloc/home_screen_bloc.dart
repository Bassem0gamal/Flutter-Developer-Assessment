
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_developer_assessment/data/api/configs_api.dart';
import 'package:flutter_developer_assessment/ui/screen/home_screen/model/article.dart';

import 'home_screen_event.dart';
import 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {

  final ConfigService configService;
  int currentPage = 1;
  List<Article> allArticles = [];

  HomeScreenBloc(this.configService) : super(const HomeScreenInitial()) {
    on<FetchArticlesEvent>(_fetchArticlesEvent);
    on<OnTapArticleEvent>(_onTapArticleEvent);
    on<OnRefreshArticlesEvent>(_onRefreshArticlesEvent);
  }

  Future<void> _fetchArticlesEvent(FetchArticlesEvent event, Emitter<HomeScreenState> emit) async {
      emit(const HomeScreenLoading());
    try {
      final articlesJson = await configService.fetchTopArticlas();
      final articles = articlesJson.map<Article>((json) => Article.fromJson(json)).toList();

      emit(HomeScreenLoaded(articles));

    } catch (e) {
      emit(HomeScreenError(e.toString()));
    }
  }

  Future<void> _onTapArticleEvent(OnTapArticleEvent event, Emitter<HomeScreenState> emit) async {
    final Uri articleUrl = Uri.parse(event.articleUrl);
    if (await launchUrl(articleUrl)) {
      print('Url lunched successfully: ${event.articleUrl}');
    } else {
      print('Could not launch url: ${event.articleUrl}');
    }
  }

  Future<void> _onRefreshArticlesEvent(OnRefreshArticlesEvent event, Emitter<HomeScreenState> emit) async {
    currentPage = 1;
    await _fetchArticlesEvent(FetchArticlesEvent(), emit);
  }
}