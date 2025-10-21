import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_developer_assessment/data/repository/articles_repository.dart';
import 'package:flutter_developer_assessment/data/transformer/article_transformer.dart';
import 'package:flutter_developer_assessment/domain/usecase/fetch_articles_usecase.dart';
import 'package:flutter_developer_assessment/ui/screen/home_screen/bloc/home_screen_bloc.dart';
import 'package:flutter_developer_assessment/ui/screen/home_screen/home_screen.dart';
import 'package:get_it/get_it.dart';

import 'data/api/article_remote_datasource.dart';

void main() {
  _setupDependencies();

  runApp(const ArticleApp());
}
class ArticleApp extends StatelessWidget {
  const ArticleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Article App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
          providers: [
            BlocProvider<HomeScreenBloc>(
              create: (context) => GetIt.instance<HomeScreenBloc>(),
            ),
          ],
          child: const HomeScreen()),
    );
  }
}

void _setupDependencies() {
  final getIt = GetIt.instance;

  getIt.registerFactory<ArticleRemoteDatasource>(() => ArticleRemoteDatasource());
  getIt.registerFactory<ArticleTransformer>(() => ArticleTransformer());
  getIt.registerFactory<ArticleRepository>(() => ArticleRepository(getIt(), getIt()));
  getIt.registerFactory<FetchArticlesUseCase>(() => FetchArticlesUseCase(getIt()));
  getIt.registerFactory<HomeScreenBloc>(() => HomeScreenBloc(getIt()));
}