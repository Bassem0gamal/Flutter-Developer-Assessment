import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_developer_assessment/data/data_source/article_local_datasource.dart';
import 'package:flutter_developer_assessment/data/repository/articles_repository.dart';
import 'package:flutter_developer_assessment/data/transformer/article_transformer.dart';
import 'package:flutter_developer_assessment/domain/usecase/fetch_articles_usecase.dart';
import 'package:flutter_developer_assessment/ui/screen/details_screen/bloc/details_screen_bloc.dart';
import 'package:flutter_developer_assessment/ui/screen/home_screen/bloc/home_screen_bloc.dart';
import 'package:flutter_developer_assessment/ui/screen/home_screen/home_screen.dart';
import 'package:get_it/get_it.dart';
import 'domain/usecase/fetch_saved_articles_usecase.dart';
import 'local_storage/objectbox_store.dart';

import 'data/data_source/article_remote_datasource.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setupDependencies();

  runApp(const ArticleApp());
}

class ArticleApp extends StatelessWidget {
  const ArticleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeScreenBloc>(
          create: (context) => GetIt.instance<HomeScreenBloc>(),
        ),

        BlocProvider<DetailsScreenBloc>(
          create: (context) => GetIt.instance<DetailsScreenBloc>(),
        ),
      ],

      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
          home: const HomeScreen()),
    );
  }
}

Future<void> _setupDependencies() async {
  final getIt = GetIt.instance;
  final objectBoxStore = await ObjectBoxStore.create();

  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerFactory<ArticleRemoteDatasource>(() => ArticleRemoteDatasource(getIt()));
  getIt.registerFactory<ArticleLocalDataSource>(() => ArticleLocalDataSource(objectBoxStore));
  getIt.registerFactory<ArticleTransformer>(() => ArticleTransformer());
  getIt.registerFactory<ArticleRepository>(() => ArticleRepository(getIt(), getIt(), getIt()));
  getIt.registerFactory<FetchArticlesUseCase>(() => FetchArticlesUseCase(getIt()));
  getIt.registerFactory<FetchSavedArticlesUseCase>(() => FetchSavedArticlesUseCase(getIt()));
  getIt.registerFactory<HomeScreenBloc>(() => HomeScreenBloc(getIt(), getIt()));
  getIt.registerFactory<DetailsScreenBloc>(() => DetailsScreenBloc());
}