import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_developer_assessment/ui/screen/home_screen/article_card.dart';
import 'package:flutter_developer_assessment/ui/screen/home_screen/category_filter_chip.dart';
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
          title: const Text('Top Articles'),
        ),
        body: BlocConsumer<HomeScreenBloc, HomeScreenState>(
          listener: (context, state) {
            if (state is HomeScreenError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')),
              );
            }
          },
          builder: (context, state) {
            if (state is HomeScreenInitial) {
              return const Center(child: CircularProgressIndicator());

            } else if (state is HomeScreenError) {
              return Center(child: Text('Error: ${state.message}'));

            } else if (state is HomeScreenLoadedState) {
              return RefreshIndicator(
                onRefresh: () {
                  context.read<HomeScreenBloc>().add(const OnRefreshArticlesEvent());
                  return Future.value();
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.filters.length,
                        itemBuilder: (context, index) {
                          final filter = state.filters[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CategoryFilterChip(
                                filter: filter,
                                isSelected: state.selectedFilter == filter,
                                onSelected: () => context.read<HomeScreenBloc>().add(OnSelectFilterEvent(filter)),
                            ),

                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(12),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Search Articles',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onChanged: (query) {
                          context.read<HomeScreenBloc>().add(SearchArticlesEvent(query));
                        },
                      ),
                    ),
                    Expanded(
                      child: InfiniteList(
                        isLoading: state.isLoadingNextPage,
                        centerLoading: true,
                        loadingBuilder: (_) => Center(child: CircularProgressIndicator()),
                        hasReachedMax: state.isLastPage,
                          itemCount: state.articles.length,
                          onFetchData: () => context.read<HomeScreenBloc>().add(const FetchArticlesEvent()),
                          itemBuilder: (context, index) {
                            final article = state.articles[index];
                            return ArticleCard(article: article);
                          },
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      );
  }
}
