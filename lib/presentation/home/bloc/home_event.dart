abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomePassageItemClickEvent extends HomeEvent {
  final String abbr;
  final int? chapter;

  HomePassageItemClickEvent({required this.abbr, required this.chapter});
}

class HomeChapterSelectEvent extends HomeEvent {
  final int? chapter;

  HomeChapterSelectEvent({this.chapter});
}

class HomeSearchEvent extends HomeEvent {
  final String? search;

  HomeSearchEvent({this.search});
}
