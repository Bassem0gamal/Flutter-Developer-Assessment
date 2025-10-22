import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_developer_assessment/consts.dart';
import 'package:flutter_developer_assessment/domain/model/article.dart';
import 'package:flutter_developer_assessment/ui/screen/details_screen/details_screen.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  const ArticleCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Hero(
          tag: article.url ?? Object(),
          child: CachedNetworkImage(
            imageUrl: article.urlToImage ?? PLACEHOLDER_IMAGE_URL,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
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
  }
}
