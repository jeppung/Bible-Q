
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomePassageItemClickEvent extends HomeEvent {
  final String abbr;

  HomePassageItemClickEvent({required this.abbr});
}

class HomeChapterSelectEvent extends HomeEvent {
  final int? chapter;

  HomeChapterSelectEvent({this.chapter});
}