
import 'package:equatable/equatable.dart';
import 'package:flutter_developer_assessment/ui/screen/home_screen/bloc/home_screen_state.dart';

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

class OnSelectFilterEvent extends HomeScreenEvent {
  final CategoryFilter selectedFilter;

  const OnSelectFilterEvent(this.selectedFilter);

  @override
  List<Object> get props => [selectedFilter];
}

class SearchArticlesEvent extends HomeScreenEvent {
  final String query;

  const SearchArticlesEvent(this.query);

  @override
  List<Object> get props => [query];
}