import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_developer_assessment/ui/screen/home_screen/bloc/home_screen_bloc.dart';
import 'package:flutter_developer_assessment/ui/screen/home_screen/home_screen.dart';

import 'data/api/configs_api.dart';

void main() {
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
      home: BlocProvider(
          create: (context) => HomeScreenBloc(ConfigService()),
          child: const HomeScreen()),
    );
  }
}