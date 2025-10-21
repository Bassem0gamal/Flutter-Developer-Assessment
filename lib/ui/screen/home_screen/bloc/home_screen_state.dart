import 'package:equatable/equatable.dart';
import 'package:flutter_developer_assessment/ui/screen/home_screen/model/article.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();
  @override
  List<Object> get props => [];
}

class HomeScreenInitial extends HomeScreenState {
  const HomeScreenInitial();
}

class HomeScreenLoading extends HomeScreenState {
  const HomeScreenLoading();
}

class HomeScreenLoaded extends HomeScreenState {
  final List<Article> articles;
  const HomeScreenLoaded(this.articles);

  @override
  List<Object> get props => [articles];
}

class HomeScreenError extends HomeScreenState {
  final String message;
  const HomeScreenError(this.message);

  @override
  List<Object> get props => [message];
}