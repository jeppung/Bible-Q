import 'package:bible_q/models/passsage.dart';

abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final PassageResponse data;

  HomeSuccessState({required this.data});
}

class HomeErrorState extends HomeState {}

class HomeNavigateToDetailActionState extends HomeActionState {
  final String abbr;
  final int? chapter;

  HomeNavigateToDetailActionState({required this.abbr, required this.chapter});
}

class HomeSelectChapterState extends HomeActionState {
  final int? chapter;

  HomeSelectChapterState({this.chapter});
}

class HomeSearchState extends HomeState {
  final String? search;

  HomeSearchState({this.search});
}
