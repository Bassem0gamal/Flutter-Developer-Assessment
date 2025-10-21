
import 'package:equatable/equatable.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();
}

class FetchArticlesEvent extends HomeScreenEvent {
  const FetchArticlesEvent();

  @override
  List<Object> get props => [];
}

class LoadNextPageEvent extends HomeScreenEvent {
  const LoadNextPageEvent();

  @override
  List<Object?> get props => [];
}

class OnRefreshArticlesEvent extends HomeScreenEvent {
  const OnRefreshArticlesEvent();

  @override
  List<Object> get props => [];
}