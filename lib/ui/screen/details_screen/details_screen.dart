import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_developer_assessment/domain/model/article.dart';
import 'package:flutter_developer_assessment/ui/screen/details_screen/bloc/details_screen_bloc.dart';
import 'package:flutter_developer_assessment/ui/screen/details_screen/bloc/details_screen_event.dart';
import 'package:flutter_developer_assessment/ui/screen/details_screen/bloc/details_screen_state.dart';

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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Article Details'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
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
              physics: const BouncingScrollPhysics(),
              children: [
                Hero(
                  tag: state.url,
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: CachedNetworkImage(
                          imageUrl: state.urlToImage,
                          placeholder: (context, url) => Container(
                            color: Colors.grey.shade200,
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.broken_image, size: 48),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),

                      Container(
                        height: 100,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black54],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        state.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        '${state.publishedAt} — By ${state.author}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        state.description,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.5,
                          color: colorScheme.onSurface.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 32),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 2,
                          ),
                          icon: const Icon(Icons.open_in_new, size: 20),
                          label: const Text(
                            'Open Full Article',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            context.read<DetailsScreenBloc>().add(
                              OpenArticleEvent(state.url),
                            );
                          },
                        ),
                      ),
                    ],
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
