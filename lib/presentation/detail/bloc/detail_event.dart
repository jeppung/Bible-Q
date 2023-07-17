abstract class DetailEvent {}

class DetailInitialEvent extends DetailEvent {
  final String abbr;
  final int? chapter;

  DetailInitialEvent({required this.abbr, this.chapter = 1});
}
