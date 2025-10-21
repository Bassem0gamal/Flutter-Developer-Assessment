import 'package:equatable/equatable.dart';

sealed class DetailsScreenState extends Equatable {
  const DetailsScreenState();

  @override
  List<Object> get props => [];
}

class DetailsScreenInitial extends DetailsScreenState {}

class DetailsScreenLoadedState extends DetailsScreenState {
  final String author;
  final String title;
  final String url;
  final String publishedAt;
  final String description;
  final String urlToImage;

  const DetailsScreenLoadedState({
    required this.author,
    required this.title,
    required this.url,
    required this.publishedAt,
    required this.description,
    required this.urlToImage,
  });

  @override
  List<Object> get props => [
    author,
    title,
    url,
    publishedAt,
    description,
    urlToImage,
  ];
}
