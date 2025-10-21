import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_developer_assessment/consts.dart';

import 'bloc/home_screen_bloc.dart';
import 'bloc/home_screen_event.dart';
import 'bloc/home_screen_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    context.read<HomeScreenBloc>().add(const FetchArticlesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Top Headlines'),
      ),
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          if (state is HomeScreenInitial || state is HomeScreenLoading) {
            return const Center(child: CircularProgressIndicator());

          } else if (state is HomeScreenError) {
            return Center(child: Text('Error: ${state.message}'));

          } else if (state is HomeScreenLoaded) {
            return RefreshIndicator(
              onRefresh: () {
                context.read<HomeScreenBloc>().add(const OnRefreshArticlesEvent());
                return Future.value();
              },
              child: ListView.builder(
                  itemCount: state.articles.length,
                  itemBuilder: (context, index) {
                    final article = state.articles[index];
                    return Card(
                      child: ListTile(
                        leading: Image.network(
                          article.urlToImage ?? PLACEHOLDER_IMAGE_URL,
                          height: 250,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        title: Text(article.title ?? ''),
                        subtitle: Text(article.source?.name ?? 'Unknown Source'),
                        onTap: () {
                          context.read<HomeScreenBloc>().add(OnTapArticleEvent(article.url ?? ''));
                        },
                      ),
                    );
                  }
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
