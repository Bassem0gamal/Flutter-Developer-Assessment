import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_developer_assessment/consts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'details_screen_event.dart';
import 'details_screen_state.dart';

class DetailsScreenBloc extends Bloc<DetailsScreenEvent, DetailsScreenState>{
  DetailsScreenBloc() : super(DetailsScreenInitial()) {
    on<InitializeArticleDetailsEvent>(_initializeArticleDetailsEvent);
    on<OpenArticleEvent>(_openArticle);
    on<ShareArticleEvent>(_shareArticle);
  }

  Future<void> _initializeArticleDetailsEvent(InitializeArticleDetailsEvent event, Emitter<DetailsScreenState> emit) async {
    final article = event.article;
    String formatedDate = '';
    if (article.publishedAt != null) {
      final date = DateTime.parse(article.publishedAt!);

      final formatter = DateFormat('MMM d, y • h:mm a');
      formatedDate = formatter.format(date);
    }

    emit(DetailsScreenLoadedState(
        author: article.author ?? 'Unknown Author',
        title: article.title ?? '',
        url: article.url ?? '',
        publishedAt: formatedDate,
        description: article.description ?? '',
        urlToImage: article.urlToImage ?? PLACEHOLDER_IMAGE_URL,
    ));
  }

  Future<void> _openArticle(OpenArticleEvent event, Emitter<DetailsScreenState> emit) async {
    launchUrl(Uri.parse(event.articleUrl));
  }

  Future<void> _shareArticle(ShareArticleEvent event, Emitter<DetailsScreenState> emit) async {
    SharePlus.instance.share(ShareParams(text: event.articleUrl));
  }
}