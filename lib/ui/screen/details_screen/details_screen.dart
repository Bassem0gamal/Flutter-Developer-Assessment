import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_developer_assessment/domain/model/article.dart';
import 'package:flutter_developer_assessment/ui/screen/details_screen/bloc/details_screen_event.dart';
import 'package:flutter_developer_assessment/ui/screen/details_screen/bloc/details_screen_state.dart';

import 'bloc/details_screen_bloc.dart';

class DetailsScreen extends StatefulWidget {
  final Article article;

  const DetailsScreen({super.key, required this.article});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DetailsScreenBloc>().add(
      InitializeArticleDetailsEvent(widget.article),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              context.read<DetailsScreenBloc>().add(
                ShareArticleEvent(widget.article.url ?? ''),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<DetailsScreenBloc, DetailsScreenState>(
        builder: (context, state) {
          return switch (state) {

            DetailsScreenInitial() => const Center(child: CircularProgressIndicator()),
            DetailsScreenLoadedState() => ListView(
              children: [
                Hero(
                  tag: state.url,
                  child: Image.network(
                    state.urlToImage,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: Text(
                    state.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    '${state.publishedAt} -- By ${state.author}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    state.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    top: 32,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: ElevatedButton(
                    child: Text('Open Full Article'),
                    onPressed: () {
                      context.read<DetailsScreenBloc>().add(
                        OpenArticleEvent(state.url),
                      );
                    },
                  ),
                ),
              ],
            ),
          };
        },
      ),
    );
  }
}
