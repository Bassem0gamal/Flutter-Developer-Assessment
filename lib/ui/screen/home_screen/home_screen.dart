import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_developer_assessment/consts.dart';
import 'package:flutter_developer_assessment/ui/screen/details_screen/details_screen.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

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
          if (state is HomeScreenInitial) {
            return const Center(child: CircularProgressIndicator());

          } else if (state is HomeScreenError) {
            return Center(child: Text('Error: ${state.message}'));

          } else if (state is HomeScreenLoaded) {
            return RefreshIndicator(
              onRefresh: () {
                context.read<HomeScreenBloc>().add(const OnRefreshArticlesEvent());
                return Future.value();
              },
              child: InfiniteList(
                isLoading: state.isLoadingNextPage,
                centerLoading: true,
                loadingBuilder: (_) => Center(child: CircularProgressIndicator()),
                hasReachedMax: state.isLastPage,
                  itemCount: state.articles.length,
                  onFetchData: () => context.read<HomeScreenBloc>().add(const FetchArticlesEvent()),
                  itemBuilder: (context, index) {
                    final article = state.articles[index];
                    return Card(
                      child: ListTile(
                        leading: Hero(
                          tag: article.url ?? Object(),
                          child: Image.network(
                            article.urlToImage ?? PLACEHOLDER_IMAGE_URL,
                            height: 250,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(article.title ?? ''),
                        subtitle: Text(article.source?.name ?? 'Unknown Source'),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => DetailsScreen(article: article),
                          ));
                        },
                      ),
                    );
                  },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
